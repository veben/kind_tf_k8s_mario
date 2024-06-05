# Mario on Kind K8s cluster with Terraform
This repository provides instructions for setting up a local Kubernetes cluster using **Kind** (Kubernetes IN Docker) and deploying the Mario bros game on it.

## 1. ⚙ Prerequisites
### Tools
**Docker**, installed in your machine

### (optional) WSL configured
- Update WSL to last version:
```sh
wsl --list --verbose
wsl --update
```
- Enable `systemd` as the boot manager for WSL
```sh
sudo vim /etc/wsl.conf
```
Add the following lines:
```plaintext
[boot]
systemd=true
```
- Restart WSL
```sh
wsl --shutdown
wsl
```
- Verify that `systemd` is active:
```sh
ps -p 1
```

## 2. 📝 Installation
Follow the instructions from the [Kind Quick Start Guide](https://kind.sigs.k8s.io/docs/user/quick-start/) to install Kind:

```sh
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64

chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

kind --version
```

## 3. 🪂 Deploying kind cluster
Use Terraform to create the Kind cluster:
```sh
terraform init; terraform plan; terraform apply --auto-approve
```

## 4. 🚀 Deploying the game
- Deploy the `deployment` and the `service` resources:
```sh
kubectl apply -f k8s_mario/deployment.yaml
kubectl apply -f k8s_mario/service.yaml
```
- Verify the existence of the different components:
```sh
kubectl get all
```
- Expose the service externally using port forwarding:
```sh
kubectl port-forward service/mario-service 8080:80
```

## 5. 🧪 Testing the game
Open a web browser and visit `http://localhost:8080` to access the Mario game.

## 6. 🚿 Cleaning up
- Destroy the `deployment` and the `service` resources:
```sh
kubectl delete service mario-service
kubectl delete deployment mario-deployment
```
- Destroy the kind cluster:
```sh
terraform destroy --auto-approve
```