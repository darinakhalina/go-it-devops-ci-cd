# CI/CD Pipeline: Jenkins + ArgoCD + Terraform

## Архітектура

```
Git Push → Jenkins → Збірка Docker → Push в ECR → Оновлення Helm Chart → ArgoCD → Деплой в EKS
```

## Структура проєкту

```
├── main.tf                 # Головний конфіг Terraform
├── modules/
│   ├── vpc/                # Модуль VPC
│   ├── eks/                # EKS кластер
│   ├── ecr/                # ECR репозиторій
│   ├── jenkins/            # Jenkins через Helm
│   └── argo_cd/            # ArgoCD через Helm
├── charts/django-app/      # Helm chart для застосунку
└── docker/                 # Django застосунок + Dockerfile
```

## Розгортання інфраструктури

```bash
terraform init
terraform plan
terraform apply
aws eks update-kubeconfig --region eu-west-1 --name lesson-8-9-eks
```

## Перевірка Jenkins

```bash
kubectl get svc -n jenkins jenkins
```

Відкрити `http://<EXTERNAL-IP>` → Увійти → Натиснути `django-ci-cd` → Build Now

## Перевірка ArgoCD

```bash
kubectl get svc -n argocd argo-cd-argocd-server
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Відкрити `https://<EXTERNAL-IP>` → Перевірити `django-app`: Synced, Healthy

## Доступ до застосунку

```bash
kubectl get svc -n default django-app-django
```

## Видалення ресурсів

```bash
terraform destroy
```

## Демонстрація

### GitHub Token
![demo_01](demo/demo_01.png)

### Terraform Variables
![demo_02](demo/demo_02.png)

### Jenkins Pods
![demo_03](demo/demo_03.png)

### ArgoCD Pods
![demo_04](demo/demo_04.png)

### Jenkins Service
![demo_05](demo/demo_05.png)

### Jenkins Login
![demo_06](demo/demo_06.png)

### Jenkins Dashboard
![demo_07](demo/demo_07.png)

### Jenkins Build Success
![demo_08](demo/demo_08.png)

### Services Overview
![demo_09](demo/demo_09.png)

### ArgoCD Login
![demo_10](demo/demo_10.png)

### ArgoCD Applications
![demo_11](demo/demo_11.png)

### ArgoCD App Details
![demo_12](demo/demo_12.png)

### Django Service
![demo_13](demo/demo_13.png)

### Django App Running
![demo_14](demo/demo_14.png)

### ECR Repository
![demo_15](demo/demo_15.png)

### EKS Cluster
![demo_16](demo/demo_16.png)

### EC2 Nodes
![demo_17](demo/demo_17.png)

### GitHub Commits
![demo_18](demo/demo_18.png)

### Jenkins Blue Ocean Pipeline
![demo_19](demo/demo_19.png)

### ArgoCD Sync Status
![demo_20](demo/demo_20.png)