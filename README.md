# Production-Ready Kubernetes Application Platform

# 1. Project Overview
This project demonstrates Kubernetes application deployment and operational best practices using Helm, Kubernetes YAML, and NGINX.
The goal is to deploy a multi-replica web application with health probes, resource management, container security settings, autoscaling configuration, and operational documentation.

# 2. Architecture
Request flow:
Client → Ingress (optional) → Kubernetes Service → NGINX Pods
The application runs inside a Kubernetes cluster. Helm manages the Kubernetes resources as a reusable chart.

# 3. Technologies Used
* Kubernetes
* Helm
* NGINX
* YAML
* kubectl
* Kubernetes HPA
* NetworkPolicy
* PodDisruptionBudget (PDB)

# 4. Repository Structure
k8s-production-portfolio/
├── README.md
├── .gitignore
├── helm/
│   └── k8s-platform/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
│           ├── _helpers.tpl
│           ├── configmap.yaml
│           ├── deployment.yaml
│           ├── service.yaml
│           ├── ingress.yaml
│           ├── hpa.yaml
│           ├── pdb.yaml
│           ├── serviceaccount.yaml
│           └── networkpolicy.yaml
└── docs/
    └── operations-runbook.md

# 5. Prerequisites
Install and configure:
* A Kubernetes cluster, such as Minikube, Kind, or a cloud Kubernetes service.
* kubectl connected to the intended cluster.
* Helm 3 or a compatible newer Helm version.

Optional features require additional components:
* HPA: working Metrics Server and resource metrics.
* Ingress: an installed Ingress Controller and suitable host configuration.
* NetworkPolicy: a CNI plugin that enforces NetworkPolicy resources.

# 6. Deployment Steps
Run these commands from the repository root.

# Step 1: Verify cluster access
kubectl cluster-info
kubectl get nodes

# Step 2: Create a namespace
kubectl create namespace k8s-portfolio
If the namespace already exists, continue to the next step.

# Step 3: Validate the Helm chart
helm lint ./helm/k8s-platform

# Step 4: Preview the Kubernetes manifests
helm template portfolio ./helm/k8s-platform \
  --namespace k8s-portfolio

# Step 5: Deploy the application
helm upgrade --install portfolio ./helm/k8s-platform \
  --namespace k8s-portfolio

# Step 6: Verify the deployment
kubectl rollout status deployment/portfolio-k8s-platform \
  -n k8s-portfolio

kubectl get deploy,rs,pods,svc,hpa,pdb \
  -n k8s-portfolio

# Step 7: Access the application
kubectl port-forward -n k8s-portfolio \
  service/portfolio-k8s-platform 8080:8080

Keep that terminal running. Open another terminal and run:
curl http://localhost:8080

Alternatively, open `http://localhost:8080` in your browser on the same machine where the port-forward command is running.

# 8. Features
* Helm-based reusable Kubernetes deployment.
* Multi-replica application deployment.
* Kubernetes Service for internal application access.
* Startup, readiness, and liveness probes.
* CPU and memory requests and limits.
* Non-root container security configuration.
* Horizontal Pod Autoscaler configuration.
* PodDisruptionBudget configuration.
* Optional Ingress and NetworkPolicy resources.
* Helm upgrade and rollback procedures.
* Operational troubleshooting documentation.

# 9. Operations and Troubleshooting
See [`docs/operations-runbook.md`](docs/operations-runbook.md) for:
* Checking application health.
* Troubleshooting Pending and CrashLoopBackOff Pods.
* Diagnosing image-pull failures.
* Troubleshooting Service connectivity.
* Checking autoscaling metrics.
* Managing Helm release history and rollbacks.

# 10. Rollback
Review the release history:
helm history portfolio -n k8s-portfolio

Roll back to a previous revision:
helm rollback portfolio <revision-number> \
  -n k8s-portfolio

Verify the result:
kubectl rollout status deployment/portfolio-k8s-platform \
  -n k8s-portfolio

# 11. Cleanup
Remove the Helm release:
helm uninstall portfolio -n k8s-portfolio
If the namespace contains only resources for this project and you want to remove them too:
kubectl delete namespace k8s-portfolio

Warning: Deleting a namespace deletes all resources inside it. Check its contents before running this command.

# 12. Limitations
This is a production-style learning project, not a fully production-certified platform. Actual production use would require additional design and validation for monitoring, alerting, secret management, TLS, backups, disaster recovery, and availability requirements.
Only mark features as tested after verifying them in your own cluster.

# 13. Author and Repository
GitHub Repository: https://github.com/malikobaid81/k8s-production-portfolio

Skills demonstrated: Kubernetes, Helm, kubectl, YAML, container security, health probes, resource management, autoscaling configuration, troubleshooting, and release rollback.
