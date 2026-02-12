# k8s setup

<br />

## Install and create the cluster using docker and k3d

### Step 1: Install Docker CE on Ubuntu 
If not already installed, follow these steps to install Docker Engine: 

1. Update and install dependencies

``` bash
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release
```

2. Add Docker Official GPG Key & Repository

``` bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

2. Install Docker Engine

``` bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3. Verify Installation

``` bash
sudo docker run hello-world
```

### Step 2: Configure Docker without Sudo (Optional but Recommended) 

``` bash
sudo usermod -aG docker $USER
# Log out and log back in for changes to take effect
```

### Step 3: Install K3D 
Use the official installation script to install the latest version of k3d: 

``` shell
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
```

### Step 4: Create a Kubernetes Cluster 
Create a new cluster using k3d, which spins up K3s inside Docker: 

``` shell
k3d cluster delete prd-local-apps-001
k3d cluster create prd-local-apps-001 \
  -p "8080:80@loadbalancer" \
  -p "9443:443@loadbalancer" \
  --agents 2 \
  --gpus all
```

### Step 5: Verify the Cluster 
Use kubectl (installed automatically with k3d or installed separately) to verify: 

```
# If kubectl is not installed, first follow the install instructions below
kubectl get nodes
```


### Common Commands:
```  shell
# Stop cluster:
k3d cluster stop mycluster

# Delete cluster: 
k3d cluster delete mycluster

# List clusters:
k3d cluster list
```

<br/> 

## Install Kubectl

### Step 1: Update your local package index and install required dependencies:

``` shell
sudo apt update && sudo apt install -y ca-certificates curl apt-transport-https gpg
```

### Step 2: Download the public signing key for the Kubernetes package repositories and add it to the system's keyring:

``` shell
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```
_Note: The version in the URL (v1.29 in this example) should be checked against the latest stable release on the Kubernetes documentation for the most up-to-date instructions._

### Step 3: Add the Kubernetes apt repository to your system's package sources

``` shell
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

### Step 4: Update the apt package index again to include the new repository

``` shell
sudo apt update
```

### Step 5: Install kubectl

``` shell
sudo apt install -y kubectl
```

<br />

## Install Helm

### Step 1: Install prerequisites

``` bash
sudo apt-get install curl gpg apt-transport-https --yes
```

### Step 2: Add the GPG key for the Helm repository

``` bash
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
```
_Note: The Helm apt repository recently moved to Buildkite; these instructions reflect the current, official source._

### Step 3: Add the Helm apt repository to your system's software sources

``` shell
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list > /dev/null
```

### Install helm and verify

``` shell
sudo apt-get update
sudo apt-get install helm
helm version
```

<br />

## Install Rancher

Rancher requires cert-manager to issue its own TLS certificate

### Step 1: Add the Jetstack Helm repository
``` shell
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

### Step 2: Install cert-manager in the cert-manager namespace
``` shell
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.19.3 \
  --set installCRDs=true

# Setup the cluster issuer
kubectl apply -f k8s-setup/cluster-cert-issuer.yml
```



_Note: Check the cert-manager documentation for the latest version and CRD installation instructions._

### Step 4: Install Rancher using Helm 
https://rancher.com/docs/

``` shell
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
```

### Step 5: Create a namespace for the Rancher server:

``` shell
kubectl create namespace cattle-system
```

### Step 6: Install Rancher, setting the hostname to localhost and specifying the exposed ports:

``` shell
# The hostname=localhost is important for local testing.
# ingress.tls.source=certmanager tells Rancher to use the cert-manager we installed.
# replicas=1 saves resources for a local, non-HA setup. 

helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=localhost \
  --set ingress.tls.source=certmanager \
  --set ingress.enabled=true \
  --set replicas=1 \
  --set global.cattle.ingress.class=traefik
```

_The installation may take a few minutes. You can check the status by watching the pods in the cattle-system namespace_

``` shell
kubectl get pods -n cattle-system --watch
```

### Step 7: Login to Rancher

https://localhost:8443
__User:__ admin

If you provided your own bootstrap password during installation, browse to https://localhost to get started.
If this is the first time you installed Rancher, get started by running this command and clicking the URL it generates:

```
echo https://localhost/dashboard/?setup=$(kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}')
```

To get just the bootstrap password on its own, run:

```
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{ "\n" }}'
```


<br/>

## Install Argo CD
To install Argo CD into your k3d cluster alongside Rancher, the most efficient method is using its official Helm chart.

### Step 1: Add the Argo helm repo

``` shell
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

### Step 2: Install Argo CD
Create a dedicated namespace and install the chart. Since this is a local k3d environment, you can use the non-HA (High Availability) version to save resources

``` shell
helm install argocd argo/argo-cd \
  --namespace argocd \
  --create-namespace
```

### Step 3: Make it accessible locally via port forwarding
By default, the Argo CD API server is not exposed externally. Use port-forwarding to access it locally: 

``` shell
kubectl port-forward svc/argocd-server -n argocd 9090:443
```

### Step 4: Retreive the auto-generated admin password

``` shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

### Step 5: Login to Argo CD
URL: https://localhost:9090  
Username: admin

### Step 6: Optionally create a Rancher Ingress (recommended)
Since you have Rancher and likely a k3d load balancer running, you can create an Ingress in the Rancher UI to avoid port-forwarding

When you create the Ingress in the Rancher UI, use the values confirmed from the command above: 

__Namespace:__ argocd  
__Name:__ argocd-ingress  
__Hostname:__ argocd.127.0.0.1.sslip.io (This resolves to your local machine)  
__Path (prefix):__ /  
__Target Service:__ argocd-server  
__Port:__ 80 (Choosing 80 avoids SSL mismatch issues during the initial setup) 

_Note: Before looking for the Target Service, ensure the Namespace dropdown at the top of the "Create Ingress" screen is set specifically to argocd. If it is set to "All Namespaces" or "Default," the argocd-server won't appear in the list.  Also, argocd should be added to the default project in Rancher_


#### Allow insecure connections to Argo CD
``` shell
kubectl patch cm argocd-cmd-params-cm -n argocd -p '{"data": {"server.insecure": "true"}}'
kubectl rollout restart deployment argocd-server -n argocd
```

### Browse to Argo CD
http://argocd.127.0.0.1.sslip.io

_Note: if using an non standard (80) port number like 8080 then that port would need to be used on the ingress urls when access them_

<br />

## Enable NVIDIA GPU Support in k3d

### 1. Install NVIDIA Drivers on the Host

Make sure your host system has the latest NVIDIA drivers installed.  
You can check with:

```bash
nvidia-smi
```

If not installed, follow the official NVIDIA instructions for your OS.

### 2. Install NVIDIA Container Toolkit

This allows Docker to use the GPU.

```bash
# Add the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

### 3. Install the NVIDIA Device Plugin in Kubernetes

```bash
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/v0.17.0/deployments/static/nvidia-device-plugin.yml
```

### 5. Create the NVIDIA RuntimeClass

```yaml
apiVersion: node.k8s.io/v1
kind: RuntimeClass
metadata:
  name: nvidia
handler: nvidia
```

Apply it:

```bash
kubectl apply -f k8s-setup/nvidia-runtime-class.yml
```