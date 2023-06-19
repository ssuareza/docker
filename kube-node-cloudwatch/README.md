This docker container sends to CloudWatch metrics about Kubernetes nodes CPU and memory allocation.

## Files
- **kubernetes.yaml**: code to launch this container as a DaemonSet in Kubernetes.
- **iam.yaml**: permissions you need to have in your worker nodes. I recommend you to add it as a role.
