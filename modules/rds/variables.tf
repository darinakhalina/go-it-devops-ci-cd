variable "name" {
  description = "Назва інстансу або кластера"
  type        = string
}

variable "engine" {
  description = "Тип бази даних для RDS (postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_cluster" {
  description = "Тип бази даних для Aurora (aurora-postgresql, aurora-mysql)"
  type        = string
  default     = "aurora-postgresql"
}

variable "aurora_replica_count" {
  description = "Кількість read-replica для Aurora"
  type        = number
  default     = 1
}

variable "aurora_instance_count" {
  description = "Загальна кількість інстансів Aurora (1 primary + replicas)"
  type        = number
  default     = 2
}

variable "engine_version" {
  description = "Версія бази даних для RDS"
  type        = string
  default     = "14.7"
}

variable "instance_class" {
  description = "Клас інстансу (db.t3.micro, db.t3.medium, etc.)"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Обсяг дискового простору в ГБ для RDS"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Ім'я бази даних, яка буде створена"
  type        = string
}

variable "username" {
  description = "Ім'я адміністративного користувача"
  type        = string
}

variable "password" {
  description = "Пароль адміністративного користувача"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "ID VPC для розміщення бази даних"
  type        = string
}

variable "subnet_private_ids" {
  description = "Список ID приватних сабнетів"
  type        = list(string)
}

variable "subnet_public_ids" {
  description = "Список ID публічних сабнетів"
  type        = list(string)
}

variable "publicly_accessible" {
  description = "Чи буде БД доступна з інтернету"
  type        = bool
  default     = false
}

variable "multi_az" {
  description = "Увімкнути Multi-AZ для відмовостійкості"
  type        = bool
  default     = false
}

variable "parameters" {
  description = "Словник параметрів для parameter group"
  type        = map(string)
  default     = {}
}

variable "use_aurora" {
  description = "Використовувати Aurora замість звичайної RDS"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Кількість днів для збереження резервних копій"
  type        = number
  default     = 7
}

variable "tags" {
  description = "Теги для ресурсів"
  type        = map(string)
  default     = {}
}

variable "parameter_group_family_aurora" {
  description = "Родина параметрів для Aurora (aurora-postgresql15, etc.)"
  type        = string
  default     = "aurora-postgresql15"
}

variable "engine_version_cluster" {
  description = "Версія бази даних для Aurora кластера"
  type        = string
  default     = "15.3"
}

variable "storage_encrypted" {
  description = "Увімкнути шифрування сховища"
  type        = bool
  default     = true
}

variable "allowed_cidr_blocks" {
  description = "Список CIDR-блоків, яким дозволено доступ до БД"
  type        = list(string)
  default     = []
}

variable "port" {
  description = "Порт бази даних (5432 для PostgreSQL, 3306 для MySQL)"
  type        = number
  default     = 5432
}

variable "parameter_group_family_rds" {
  description = "Родина параметрів для RDS (postgres15, mysql8.0, etc.)"
  type        = string
  default     = "postgres15"
}