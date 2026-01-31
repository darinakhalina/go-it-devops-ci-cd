# Terraform RDS Module

Універсальний модуль для створення керованої бази даних в AWS - підтримує як звичайну RDS, так і Aurora кластер.

## Можливості

- **Звичайна RDS** (PostgreSQL, MySQL) - `use_aurora = false`
- **Aurora Cluster** (Aurora PostgreSQL, Aurora MySQL) - `use_aurora = true`
- Автоматичне створення DB Subnet Group
- Автоматичне створення Security Group
- Налаштування Parameter Group з кастомними параметрами
- Підтримка Multi-AZ для відмовостійкості
- Read replicas для Aurora

## Приклад використання

### Звичайна RDS (PostgreSQL)

```hcl
module "rds" {
  source = "./modules/rds"

  name                       = "myapp-db"
  use_aurora                 = false

  # RDS параметри
  engine                     = "postgres"
  engine_version             = "17.2"
  parameter_group_family_rds = "postgres17"

  # Загальні параметри
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  db_name                    = "myapp"
  username                   = "postgres"
  password                   = var.db_password
  subnet_private_ids         = module.vpc.private_subnets
  subnet_public_ids          = module.vpc.public_subnets
  publicly_accessible        = true
  vpc_id                     = module.vpc.vpc_id
  multi_az                   = false
  backup_retention_period    = 7

  parameters = {
    "max_connections" = "200"
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```

### Aurora Cluster (PostgreSQL)

```hcl
module "rds" {
  source = "./modules/rds"

  name                          = "myapp-db"
  use_aurora                    = true
  aurora_instance_count         = 2
  aurora_replica_count          = 1

  # Aurora параметри
  engine_cluster                = "aurora-postgresql"
  engine_version_cluster        = "15.3"
  parameter_group_family_aurora = "aurora-postgresql15"

  # Загальні параметри
  instance_class                = "db.t3.medium"
  db_name                       = "myapp"
  username                      = "postgres"
  password                      = var.db_password
  subnet_private_ids            = module.vpc.private_subnets
  subnet_public_ids             = module.vpc.public_subnets
  publicly_accessible           = false
  vpc_id                        = module.vpc.vpc_id
  backup_retention_period       = 7

  parameters = {
    "max_connections" = "200"
  }

  tags = {
    Environment = "prod"
    Project     = "myapp"
  }
}
```

## Змінні

| Змінна | Тип | За замовчуванням | Опис |
|--------|-----|------------------|------|
| `name` | string | - | Назва інстансу або кластера (обов'язково) |
| `use_aurora` | bool | `false` | Використовувати Aurora замість звичайної RDS |
| `engine` | string | `"postgres"` | Тип БД для RDS (postgres, mysql) |
| `engine_version` | string | `"14.7"` | Версія БД для RDS |
| `engine_cluster` | string | `"aurora-postgresql"` | Тип БД для Aurora |
| `engine_version_cluster` | string | `"15.3"` | Версія БД для Aurora |
| `instance_class` | string | `"db.t3.micro"` | Клас інстансу |
| `allocated_storage` | number | `20` | Обсяг диску в ГБ (тільки RDS) |
| `db_name` | string | - | Ім'я бази даних (обов'язково) |
| `username` | string | - | Ім'я адміністратора (обов'язково) |
| `password` | string | - | Пароль адміністратора (обов'язково) |
| `vpc_id` | string | - | ID VPC (обов'язково) |
| `subnet_private_ids` | list(string) | - | Приватні сабнети (обов'язково) |
| `subnet_public_ids` | list(string) | - | Публічні сабнети (обов'язково) |
| `publicly_accessible` | bool | `false` | Публічний доступ до БД |
| `multi_az` | bool | `false` | Multi-AZ для RDS |
| `backup_retention_period` | number | `7` | Днів збереження бекапів |
| `aurora_replica_count` | number | `1` | Кількість read replicas для Aurora |
| `parameter_group_family_rds` | string | `"postgres15"` | Родина параметрів RDS |
| `parameter_group_family_aurora` | string | `"aurora-postgresql15"` | Родина параметрів Aurora |
| `parameters` | map(string) | `{}` | Кастомні параметри БД |
| `tags` | map(string) | `{}` | Теги для ресурсів |

## Виходи (Outputs)

| Вихід | Опис |
|-------|------|
| `rds_endpoint` | Endpoint звичайної RDS |
| `rds_address` | Адреса звичайної RDS |
| `rds_port` | Порт звичайної RDS |
| `aurora_cluster_endpoint` | Endpoint Aurora (writer) |
| `aurora_reader_endpoint` | Endpoint Aurora (reader) |
| `aurora_cluster_port` | Порт Aurora |
| `db_subnet_group_name` | Ім'я Subnet Group |
| `security_group_id` | ID Security Group |
| `db_name` | Ім'я бази даних |

## Як змінити тип БД

### Змінити engine (PostgreSQL → MySQL)

```hcl
# RDS
engine                     = "mysql"
engine_version             = "8.0"
parameter_group_family_rds = "mysql8.0"

# Aurora
engine_cluster                = "aurora-mysql"
engine_version_cluster        = "8.0.mysql_aurora.3.04.0"
parameter_group_family_aurora = "aurora-mysql8.0"
```

### Змінити клас інстансу

```hcl
instance_class = "db.t3.medium"  # або db.r6g.large для production
```

### Увімкнути Multi-AZ (RDS)

```hcl
multi_az = true
```

## Архітектура

### Звичайна RDS (use_aurora = false)

```
┌─────────────────────────────────────┐
│              VPC                    │
│  ┌─────────────┐  ┌─────────────┐  │
│  │  Subnet A   │  │  Subnet B   │  │
│  │  ┌───────┐  │  │  ┌───────┐  │  │
│  │  │Primary│  │  │  │Standby│  │  │
│  │  │ (RDS) │◄─┼──┼─▶│(M-AZ) │  │  │
│  │  └───────┘  │  │  └───────┘  │  │
│  └─────────────┘  └─────────────┘  │
└─────────────────────────────────────┘
```

### Aurora Cluster (use_aurora = true)

```
┌─────────────────────────────────────┐
│          Aurora Cluster             │
│  ┌─────────────────────────────┐   │
│  │   Shared Storage Layer      │   │
│  └─────────────────────────────┘   │
│         ▲           ▲              │
│  ┌──────┴───┐ ┌─────┴────┐        │
│  │  Writer  │ │  Reader  │ × N    │
│  └──────────┘ └──────────┘        │
└─────────────────────────────────────┘
```

## Створені ресурси

- `aws_db_instance` (якщо use_aurora = false)
- `aws_db_parameter_group` (якщо use_aurora = false)
- `aws_rds_cluster` (якщо use_aurora = true)
- `aws_rds_cluster_instance` (writer + readers)
- `aws_rds_cluster_parameter_group` (якщо use_aurora = true)
- `aws_db_subnet_group` (завжди)
- `aws_security_group` (завжди)