# Terraform Infrastructure - Lesson 5

Terraform-проєкт для створення AWS інфраструктури.

## Структура проєкту

```
lesson-5/
├── main.tf                  # Головний файл для підключення модулів
├── backend.tf               # Налаштування бекенду для стейтів (S3 + DynamoDB)
├── outputs.tf               # Загальне виведення ресурсів
├── modules/
│   ├── s3-backend/          # Модуль для S3 та DynamoDB
│   ├── vpc/                 # Модуль для VPC
│   └── ecr/                 # Модуль для ECR
└── README.md
```

## Модулі

### s3-backend
Створює інфраструктуру для зберігання Terraform state:
- **S3 bucket** — зберігання terraform.tfstate
- **DynamoDB table** — блокування state для командної роботи

### vpc
Створює мережеву інфраструктуру:
- **VPC** з CIDR 10.0.0.0/16
- **3 публічні підмережі** — для ресурсів з доступом до інтернету
- **3 приватні підмережі** — для внутрішніх ресурсів
- **Internet Gateway** — вихід в інтернет для публічних підмереж
- **NAT Gateway** — вихід в інтернет для приватних підмереж
- **Route Tables** — маршрутизація трафіку

### ecr
Створює репозиторій для Docker-образів:
- **ECR Repository** — зберігання Docker images
- **Lifecycle Policy** — автоматичне видалення старих образів
- **Image Scanning** — сканування на вразливості при push

## Команди

### Ініціалізація
```bash
cd lesson-5
terraform init
```

### Перегляд плану змін
```bash
terraform plan
```

### Застосування змін
```bash
terraform apply
```

### Видалення всіх ресурсів
```bash
terraform destroy
```

## Порядок першого запуску

1. Переконайтесь, що `backend.tf` закоментований
2. Виконайте `terraform init`
3. Виконайте `terraform apply`
4. Розкоментуйте `backend.tf`
5. Виконайте `terraform init -reconfigure`

## Порядок відновлення після destroy

1. Закоментуйте `backend.tf`
2. Виконайте `terraform apply` (створить S3 та DynamoDB)
3. Розкоментуйте `backend.tf`
4. Виконайте `terraform init -reconfigure`

## Демо

![Demo 1](../demo/demo-01.png)
![Demo 2](../demo/demo-02.png)
![Demo 3](../demo/demo-03.png)
![Demo 4](../demo/demo-04.png)
![Demo 5](../demo/demo-05.png)
![Demo 6](../demo/demo-06.png)
![Demo 7](../demo/demo-07.png)
![Demo 8](../demo/demo-08.png)
![Demo 9](../demo/demo-09.png)
![Demo 10](../demo/demo-10.png)
![Demo 11](../demo/demo-11.png)
![Demo 12](../demo/demo-12.png)