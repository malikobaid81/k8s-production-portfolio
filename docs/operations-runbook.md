# Kubernetes Operations Runbook
This document describes how to verify, troubleshoot, and manage the Kubernetes application deployed using Helm.

# 1. Check Application Status
Check the Deployment, Pods, Service, HPA, and PDB:
kubectl get deploy,rs,pods,svc,hpa,pdb -n k8s-portfolio

Check whether the application rollout has completed:
kubectl rollout status deployment/portfolio-k8s-platform -n k8s-portfolio

# 2. Troubleshoot Pod Problems

### Pod is Pending
kubectl describe pod <pod-name> -n k8s-portfolio
kubectl get events -n k8s-portfolio
Check for insufficient CPU or memory, scheduling restrictions, and other events.

### ImagePullBackOff
kubectl describe pod <pod-name> -n k8s-portfolio
Verify the container image name, tag, registry access, and network connectivity.

### CrashLoopBackOff
kubectl logs <pod-name> -n k8s-portfolio
kubectl logs <pod-name> -n k8s-portfolio --previous
Review application logs and Pod events to identify the cause.

# 3. Troubleshoot Service Connectivity
Check the Service and its backend endpoints:
kubectl get svc -n k8s-portfolio
kubectl get endpointslice -n k8s-portfolio

Test the web application using port forwarding:
kubectl port-forward -n k8s-portfolio service/portfolio-k8s-platform 8080:8080

In another terminal, run:
curl http://localhost:8080

# 4. Troubleshoot Autoscaling
kubectl get hpa -n k8s-portfolio
kubectl describe hpa -n k8s-portfolio
kubectl top pods -n k8s-portfolio

If metrics are unavailable, verify that Metrics Server is installed and functioning. HPA requires a working metrics pipeline and suitable resource requests.

# 5. Helm Release Management
View the release history:
helm history portfolio -n k8s-portfolio

Check the release status:
helm status portfolio -n k8s-portfolio

Upgrade the application after changing the chart:
helm upgrade portfolio ./helm/k8s-platform -n k8s-portfolio

Roll back to an earlier revision:
helm rollback portfolio <revision-number> -n k8s-portfolio

Verify the rollout after rollback:
kubectl rollout status deployment/portfolio-k8s-platform -n k8s-portfolio

# 6. Operational Notes
* HPA requires working Metrics Server and resource metrics.
* Ingress requires an Ingress Controller and appropriate host configuration.
* NetworkPolicy enforcement depends on the cluster networking plugin.
* A PodDisruptionBudget does not prevent every type of outage.
* Test configuration changes before using them in production.
* Never commit kubeconfig files, credentials, or real secrets to the repository.

# 7. Project Limitations
This portfolio project demonstrates Kubernetes deployment and operations practices. It is not a complete production platform with centralized monitoring, alerting, secret management, backups, and disaster recovery.
