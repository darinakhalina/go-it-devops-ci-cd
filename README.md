# Terraform RDS Module

Універсальний модуль для створення бази даних в AWS.

- `use_aurora = false` — звичайна RDS (PostgreSQL, MySQL)
- `use_aurora = true` — Aurora Cluster

## Приклад використання

### RDS

```hcl
module "rds" {
  source = "./modules/rds"

  name                       = "myapp-db"
  use_aurora                 = false
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  db_name                    = "myapp"
  username                   = "postgres"
  password                   = var.db_password
  vpc_id                     = module.vpc.vpc_id
  subnet_private_ids         = module.vpc.private_subnets
  subnet_public_ids          = module.vpc.public_subnets

  parameters = {
    "max_connections" = "200"
  }
}
```

### Aurora

```hcl
module "rds" {
  source = "./modules/rds"

  name                          = "myapp-db"
  use_aurora                    = true
  engine_cluster                = "aurora-postgresql"
  engine_version_cluster        = "16.8"
  parameter_group_family_aurora = "aurora-postgresql16"
  instance_class                = "db.t3.medium"
  db_name                       = "myapp"
  username                      = "postgres"
  password                      = var.db_password
  vpc_id                        = module.vpc.vpc_id
  subnet_private_ids            = module.vpc.private_subnets
  subnet_public_ids             = module.vpc.public_subnets

  parameters = {
    "max_connections" = "200"
  }
}
```

## Змінні

| Змінна | Тип | Default | Опис |
|--------|-----|---------|------|
| `name` | string | — | Назва БД |
| `use_aurora` | bool | `false` | Aurora чи RDS |
| `engine` | string | `postgres` | Engine для RDS |
| `engine_version` | string | `14.7` | Версія для RDS |
| `engine_cluster` | string | `aurora-postgresql` | Engine для Aurora |
| `engine_version_cluster` | string | `15.3` | Версія для Aurora |
| `instance_class` | string | `db.t3.micro` | Клас інстансу |
| `allocated_storage` | number | `20` | Диск в ГБ (RDS) |
| `db_name` | string | — | Ім'я бази |
| `username` | string | — | Користувач |
| `password` | string | — | Пароль |
| `vpc_id` | string | — | VPC ID |
| `subnet_private_ids` | list | — | Приватні сабнети |
| `subnet_public_ids` | list | — | Публічні сабнети |
| `publicly_accessible` | bool | `false` | Публічний доступ |
| `multi_az` | bool | `false` | Multi-AZ |
| `parameters` | map | `{}` | Параметри БД |

## Outputs

| Output | Опис |
|--------|------|
| `rds_endpoint` | Endpoint RDS |
| `aurora_cluster_endpoint` | Endpoint Aurora (writer) |
| `aurora_reader_endpoint` | Endpoint Aurora (reader) |
| `security_group_id` | Security Group ID |
| `db_subnet_group_name` | Subnet Group |

## Як змінити engine

```hcl
# MySQL замість PostgreSQL
engine                     = "mysql"
engine_version             = "8.0"
parameter_group_family_rds = "mysql8.0"

# Aurora MySQL
engine_cluster                = "aurora-mysql"
engine_version_cluster        = "8.0.mysql_aurora.3.04.0"
parameter_group_family_aurora = "aurora-mysql8.0"
```

## Демонстрація

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
![](demo/demo_15.png)
![](demo/demo_16.png)
![](demo/demo_17.png)
