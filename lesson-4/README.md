# Django + PostgreSQL + Nginx (Docker)

Docker-проєкт з Django, базою даних PostgreSQL та веб-сервером Nginx.

## Вимоги

- Docker
- Docker Compose

## Швидкий старт

### 1. Перейдіть у папку lesson-4
```bash
cd lesson-4
```

### 2. Створіть .env файл
```bash
cp .env.example .env
```

### 3. Запустіть контейнери
```bash
docker-compose up -d
```

### 4. Перевірте статус контейнерів
```bash
docker ps
```

### 5. Відкрийте у браузері
- http://localhost (через Nginx)
- http://localhost:8000 (Django напряму)

### 6. Перегляд логів
```bash
docker-compose logs
```

### 7. Зупинка контейнерів
```bash
docker-compose down
```

## Демо

### Запущені контейнери
![Запущені контейнери](demo/demo-1.png)

### Стартова сторінка Django
![Стартова сторінка Django](demo/demo-2.png)
