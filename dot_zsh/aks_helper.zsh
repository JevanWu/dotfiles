#!/bin/bash

function usage() {
  cat << EOF
Usage: bastion [OPTIONS] [ENVIRONMENT]

Start or terminate an Azure Bastion tunnel to an AKS cluster.

ENVIRONMENT (optional, default: lxp_dev):
  lxp_dev                Connect to lxp-dev environment
  lxp_qa                 Connect to lxp-qa environment
  lxp_uat                Connect to lxp-uat environment
  bos_prod               Connect to bos-prod environment        (requires BOS_PROD_PEM_FILE env)
  maxen_amer             Connect to maxen-amer-prod environment (requires MAXEN_AMER_PEM_FILE env)

OPTIONS:
  -h, --help             Show this help message
  -d, --daemon           Run tunnel in background (daemon mode, default: false)
  -t, --terminate        Terminate running tunnel on specified port
  --port=<PORT>          Local port for tunnel (default: 1080)

EXAMPLES:
  bastion
  bastion lxp_dev
  bastion --daemon lxp_qa
  bastion lxp_dev -d --port=1080
  bastion --terminate
  bastion --terminate --port=1080
  bastion --help

EOF
}

function tunnel_terminate () {
  port=${1:-1080}
  silent=${2:-false}

  found=false

  # Kill processes listening on this port
  if lsof -i TCP:$port -sTCP:LISTEN -t >/dev/null 2>&1; then
    if [ "$silent" != "true" ]; then
      echo "Terminating tunnel on port $port..."
    fi
    kill -9 $(lsof -i TCP:$port -sTCP:LISTEN -t) 2>/dev/null
    found=true
    sleep 1
  fi

  # Also kill any az network bastion tunnel/ssh processes that might be running
  if pkill -f "az network bastion tunnel.*--port $port" 2>/dev/null; then
    found=true
    sleep 1
  fi
  if pkill -f "az network bastion ssh.*-D $port" 2>/dev/null; then
    found=true
    sleep 1
  fi

  if [ "$silent" != "true" ]; then
    if [ "$found" = "true" ]; then
      echo "Tunnel terminated on port $port"
    else
      echo "No tunnel found running on port $port"
    fi
  fi
}

function tunnel_start () {
  target_resource_id=$1
  bastion_name=$2
  daemon_mode=${3:-false}
  port=${4:-1080}

  if [ -z "$target_resource_id" ] || [ -z "$bastion_name" ]; then
    echo "target_resource_id and bastion_name are required"
    return 1
  fi

  # Kill any existing tunnel processes on this port
  tunnel_terminate $port true

  subscription=$(echo $target_resource_id | cut -d '/' -f 3)
  resource_group=$(echo $target_resource_id | cut -d '/' -f 5)
  aks_name=$(echo $target_resource_id | cut -d '/' -f 9)

  az account set --subscription $subscription
  az aks get-credentials --resource-group $resource_group --name $aks_name --overwrite-existing

  if [ "$daemon_mode" = "true" ]; then
    echo "Starting tunnel in background (daemon mode) on port $port..."
    az network bastion tunnel \
      --name $bastion_name \
      --resource-group $resource_group \
      --target-resource-id $target_resource_id \
      --port $port \
      --resource-port 443 > /dev/null 2>&1 &
    echo "Tunnel started in background (PID: $!)"
  else
    az network bastion tunnel \
      --name $bastion_name \
      --resource-group $resource_group \
      --target-resource-id $target_resource_id \
      --port $port \
      --resource-port 443
  fi
}

function tunnel_start_vm () {
  target_resource_id=$1
  bastion_name=$2
  aks_name=$3
  daemon_mode=${4:-false}
  port=${5:-1080}
  pem_file=${6:-}

  if [ -z "$target_resource_id" ] || [ -z "$bastion_name" ] || [ -z "$aks_name" ]; then
    echo "target_resource_id, bastion_name, and aks_name are required"
    return 1
  fi

  if [ ! -f "$pem_file" ]; then
    echo "Private Key not found: $pem_file"
    return 1
  fi

  # Kill any existing tunnel processes on this port
  tunnel_terminate $port true

  subscription=$(echo $target_resource_id | cut -d '/' -f 3)
  resource_group=$(echo $target_resource_id | cut -d '/' -f 5)

  az account set --subscription $subscription
  az aks get-credentials --resource-group $resource_group --name $aks_name --overwrite-existing

  SSH_TUNNEL_OPTS=(-N -D $port -o ExitOnForwardFailure=yes -o ServerAliveInterval=60 -o ServerAliveCountMax=3)
  if [ "$daemon_mode" = "true" ]; then
    echo "Starting tunnel in background (daemon mode) on port $port..."
    az network bastion ssh \
      --name "$bastion_name" \
      --resource-group "$resource_group" \
      --target-resource-id "$target_resource_id" \
      --auth-type "ssh-key" \
      --username "azureuser" \
      --only-show-errors \
      --ssh-key "$pem_file" \
      -- "${SSH_TUNNEL_OPTS[@]}" > /dev/null 2>&1 &
    echo "Tunnel started in background (PID: $!)"
  else
    az network bastion ssh \
      --name "$bastion_name" \
      --resource-group "$resource_group" \
      --target-resource-id "$target_resource_id" \
      --auth-type "ssh-key" \
      --username "azureuser" \
      --only-show-errors \
      --ssh-key "$pem_file" \
      -- "${SSH_TUNNEL_OPTS[@]}"
  fi
}

function bastion () {
  # Default values
  ENV="lxp_dev"
  DAEMON_MODE="false"
  PORT=1080
  TERMINATE=false

  # Parse all arguments flexibly
  for arg in "$@"; do
    case $arg in
      --help|-h)
        usage
        return 0
        ;;
      --daemon|-d)
        DAEMON_MODE="true"
        ;;
      --terminate|-t)
        TERMINATE=true
        ;;
      --port=*)
        PORT="${arg#*=}"
        ;;
      lxp_dev|lxp_qa|lxp_uat|bos_prod|maxen_amer)
        ENV="$arg"
        ;;
      *)
        echo "Unknown argument: $arg"
        echo "Use --help or -h for usage information"
        return 1
        ;;
    esac
  done

  # If terminate option is set, just terminate and exit
  if [ "$TERMINATE" = "true" ]; then
    tunnel_terminate $PORT
    return 0
  fi

  # Remove any existing proxy environment variables and Alias kubectl
  aks_remove

  # Start tunnel based on environment
  case $ENV in
        lxp_dev )
            target_resource_id="/subscriptions/bb16c0e3-a575-4c10-8aeb-f9054110c439/resourceGroups/lxp-dev-eastus-aks-rg/providers/Microsoft.ContainerService/managedClusters/lxp-dev-aks"
            bastion_name="lxp-dev-bastion"
            tunnel_start $target_resource_id $bastion_name $DAEMON_MODE $PORT
          ;;
        lxp_qa )
            target_resource_id="/subscriptions/421db4d8-df7d-46b4-9c02-00328f45cc3c/resourceGroups/lxp-qa-saas-eastus-aks-rg/providers/Microsoft.ContainerService/managedClusters/lxp-qa-saas-aks"
            bastion_name="lxp-qa-saas-bastion"
            tunnel_start $target_resource_id $bastion_name $DAEMON_MODE $PORT
          ;;
        lxp_uat )
            target_resource_id="/subscriptions/78360b9c-5f5b-4eca-8611-1a3c8fc0ed3e/resourceGroups/lxp-uat-saas-eastus-aks-rg/providers/Microsoft.ContainerService/managedClusters/lxp-uat-saas-aks"
            bastion_name="lxp-uat-saas-bastion"
            tunnel_start $target_resource_id $bastion_name $DAEMON_MODE $PORT
          ;;
        bos_prod )
            target_resource_id="/subscriptions/d71b7988-4401-48d2-b0c1-2fc9776ae2cf/resourceGroups/bos-prod-southeastasia-aks-rg/providers/Microsoft.Compute/virtualMachines/bos-prod-bastion-jumphost"
            bastion_name="bos-prod-bastion"
            aks_name="bos-prod-fmop-aks"
            pem_file="$BOS_PROD_PEM_FILE"
            tunnel_start_vm $target_resource_id $bastion_name $aks_name $DAEMON_MODE $PORT $pem_file
          ;;
        maxen_amer )
            target_resource_id="/subscriptions/378f5b91-5c0f-4e5b-8776-4c15f36af431/resourceGroups/maxen-amer-prod-eastus2-aks-rg/providers/Microsoft.Compute/virtualMachines/maxen-amer-prod-bastion-jumphost"
            bastion_name="maxen-amer-prod-bastion"
            aks_name="maxen-amer-prod-aks"
            pem_file="$MAXEN_AMER_PEM_FILE"
            tunnel_start_vm $target_resource_id $bastion_name $aks_name $DAEMON_MODE $PORT $pem_file
          ;;
        * )
            echo "Environment is not supported"
            return 1
    esac
}

function aks_tunnel () {
  PORT=${1:-1080}
  # Check if VM mode tunnel is running (SSH tunnel with SOCKS proxy)
  if pgrep -f "az network bastion ssh.*-D $PORT" > /dev/null 2>&1; then
    # VM mode: set proxy environment variables (works for both kubectl and helm)
    export HTTPS_PROXY="socks5://127.0.0.1:$PORT"
    export HTTP_PROXY="$HTTPS_PROXY"
    export NO_PROXY="localhost,127.0.0.1"
    echo "Proxy environment variables set for VM tunnel mode (port $PORT)"
    echo "kubectl and helm will use the SOCKS proxy"
  else
    current_context=$(kubectl config current-context 2>/dev/null)
    if [ -n "$current_context" ]; then
      current_cluster=$(kubectl config view -o jsonpath="{.contexts[?(@.name==\"$current_context\")].context.cluster}" 2>/dev/null)
      if [ -n "$current_cluster" ]; then
        kubectl config set-cluster "$current_cluster" --server="https://localhost:$PORT" > /dev/null 2>&1
        echo "kubeconfig updated to use tunnel endpoint (https://localhost:$PORT)"
        echo "kubectl and helm are now configured to use the tunnel"
      else
        echo "Warning: Could not determine current cluster"
      fi
    else
      echo "Warning: No current context found"
    fi
  fi
}

function aks_remove () {
  # Unset proxy environment variables if set
  if [ -n "$HTTPS_PROXY" ] || [ -n "$HTTP_PROXY" ]; then
    unset HTTPS_PROXY
    unset HTTP_PROXY
    unset NO_PROXY
    echo "Proxy environment variables unset"
  fi
}
