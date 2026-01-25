# Lesson 7: Kubernetes (EKS) + Helm

Django-застосунок в AWS EKS з Terraform та Helm.

## Структура

```
lesson-7/
├── main.tf, backend.tf, outputs.tf
├── modules/
│   ├── s3-backend/    # Terraform state
│   ├── vpc/           # Мережа
│   ├── ecr/           # Docker registry
│   └── eks/           # Kubernetes кластер
└── charts/django-app/ # Helm chart
    └── templates/     # deployment, service, configmap, hpa
```

## Команди

### 1. Terraform
```bash
cd lesson-7
terraform init
terraform apply
```

### 2. kubectl
```bash
aws eks update-kubeconfig --region eu-west-1 --name lesson-7-eks
kubectl get nodes
```

### 3. Docker → ECR
```bash
# Login
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin <ECR_URL>

# Build та Push
cd lesson-4/django
docker build --platform linux/amd64 -t django-app .
docker tag django-app:latest <ECR_URL>:latest
docker push <ECR_URL>:latest
```

### 4. Helm
```bash
cd lesson-7/charts
helm install django-app ./django-app
```

### 5. Перевірка
```bash
kubectl get pods
kubectl get svc
kubectl get hpa
kubectl get configmap
```

## Helm Chart

- **Deployment** — Django з ECR, envFrom ConfigMap
- **Service** — LoadBalancer (порт 80)
- **HPA** — 2-6 подів, CPU > 70%
- **ConfigMap** — змінні середовища

## Очистка
```bash
helm uninstall django-app
terraform destroy
```

## Demo

![](demo/demo_01.png)
![](demo/demo_02.png)
![](demo/demo_03.png)
![](demo/demo_04.png)
![](demo/demo_05.png)
![](demo/demo_06.png)
![](demo/demo_07.png)
![](demo/demo_08.png)
![](demo/demo_09.png)
![](demo/demo_10.png)
![](demo/demo_11.png)
![](demo/demo_12.png)
![](demo/demo_13.png)
![](demo/demo_14.png)
