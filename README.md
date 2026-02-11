# Фінальний проєкт

## Опис

Інфраструктура на AWS з використанням Terraform. Включає VPC, EKS, RDS (Aurora PostgreSQL), ECR, Jenkins, Argo CD, Prometheus та Grafana.

## Компоненти

- **VPC** — 3 public + 3 private subnets, NAT Gateway, Internet Gateway
- **EKS** — Kubernetes кластер (t3.medium, 2 ноди)
- **RDS** — Aurora PostgreSQL (writer + reader)
- **ECR** — Docker registry для Django image
- **Jenkins** — CI pipeline (lint, tests, security scan, build, push to ECR)
- **Argo CD** — CD, автоматичний деплой з Git
- **Prometheus** — збір метрик з Kubernetes
- **Grafana** — візуалізація метрик

## Як запустити

### 1. Підготовка

```bash
cp terraform.tfvars.example terraform.tfvars
# Заповнити terraform.tfvars своїми значеннями
terraform init
```

### 2. Розгортання

```bash
terraform apply
```

### 3. Оновити kubeconfig

```bash
aws eks update-kubeconfig --name final-eks --region eu-west-1
```

### 4. Перевірити стан ресурсів

```bash
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring
```

### 5. Доступ до сервісів

```bash
kubectl port-forward svc/jenkins 8080:80 -n jenkins
kubectl port-forward svc/argo-cd-argocd-server 8081:443 -n argocd
kubectl port-forward svc/grafana 3000:80 -n monitoring
kubectl port-forward svc/prometheus-server 9090:80 -n monitoring
```

- Jenkins: http://localhost:8080
- Argo CD: http://localhost:8081
- Grafana: http://localhost:3000
- Prometheus: http://localhost:9090

### 6. Видалення ресурсів

```bash
terraform destroy
```

## Скріншоти

![](demo/01.png)
![](demo/02.png)
![](demo/03.png)
![](demo/04.png)
![](demo/05.png)
![](demo/06.png)
![](demo/07.png)
![](demo/08.png)
![](demo/09.png)
![](demo/10.png)
![](demo/11.png)
![](demo/12.png)
![](demo/13.png)
![](demo/14.png)
![](demo/15.png)
![](demo/16.png)
![](demo/17.png)
![](demo/18.png)
![](demo/19.png)
![](demo/20.png)
![](demo/21.png)
![](demo/22.png)
![](demo/23..png)
![](demo/24.png)
![](demo/25.png)
![](demo/26.png)
