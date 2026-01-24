#!/bin/bash

# Скрипт для встановлення Docker, Docker Compose, Python та Django
# Для Ubuntu/Debian систем

echo "=== Початок встановлення інструментів розробки ==="

# --- Визначення способу виконання команд (з sudo або без) ---
if [ "$(id -u)" -eq 0 ]; then
    # Запущено від root - sudo не потрібен
    SUDO=""
    echo "Запущено від користувача root"
else
    # Запущено від звичайного користувача - потрібен sudo
    SUDO="sudo"
    echo "Запущено від користувача: $(whoami)"
fi

# --- Визначення поточного користувача ---
CURRENT_USER="${USER:-$(whoami)}"

# --- Встановлення базових залежностей ---
echo ""
echo "=== Встановлення базових залежностей ==="
$SUDO apt update
$SUDO apt install -y curl lsb-release ca-certificates gnupg

# --- Docker ---
echo ""
echo "=== Перевірка Docker ==="
if command -v docker &> /dev/null; then
    echo "Docker вже встановлено: $(docker --version)"
else
    echo "Встановлення Docker..."
    $SUDO apt install -y apt-transport-https software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | $SUDO tee /etc/apt/sources.list.d/docker.list > /dev/null
    $SUDO apt update
    $SUDO apt install -y docker-ce docker-ce-cli containerd.io

    # Додавання користувача до групи docker (якщо не root)
    if [ -n "$CURRENT_USER" ] && [ "$CURRENT_USER" != "root" ]; then
        $SUDO usermod -aG docker "$CURRENT_USER"
        echo "Користувача $CURRENT_USER додано до групи docker"
    fi

    echo "Docker встановлено: $(docker --version)"
fi

# --- Docker Compose ---
echo ""
echo "=== Перевірка Docker Compose ==="
if command -v docker-compose &> /dev/null; then
    echo "Docker Compose вже встановлено: $(docker-compose --version)"
else
    echo "Встановлення Docker Compose..."
    $SUDO apt install -y docker-compose
    echo "Docker Compose встановлено: $(docker-compose --version)"
fi

# --- Python ---
echo ""
echo "=== Перевірка Python ==="
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
    echo "Python вже встановлено: $PYTHON_VERSION"
else
    echo "Встановлення Python 3..."
    $SUDO apt install -y python3
    echo "Python встановлено: $(python3 --version)"
fi

# --- pip ---
echo ""
echo "=== Перевірка pip ==="
if command -v pip3 &> /dev/null; then
    echo "pip вже встановлено: $(pip3 --version)"
else
    echo "Встановлення pip3..."
    $SUDO apt install -y python3-pip
    echo "pip встановлено: $(pip3 --version)"
fi

# --- Django ---
echo ""
echo "=== Перевірка Django ==="
if python3 -m django --version &> /dev/null; then
    echo "Django вже встановлено: $(python3 -m django --version)"
else
    echo "Встановлення Django..."
    pip3 install django
    echo "Django встановлено: $(python3 -m django --version)"
fi

echo ""
echo "=== Встановлення завершено ==="
echo "Docker: $(docker --version 2>/dev/null || echo 'не встановлено')"
echo "Docker Compose: $(docker-compose --version 2>/dev/null || echo 'не встановлено')"
echo "Python: $(python3 --version 2>/dev/null || echo 'не встановлено')"
echo "pip: $(pip3 --version 2>/dev/null || echo 'не встановлено')"
echo "Django: $(python3 -m django --version 2>/dev/null || echo 'не встановлено')"

# Підказка про перелогін для застосування групи docker
if [ -n "$CURRENT_USER" ] && [ "$CURRENT_USER" != "root" ]; then
    echo ""
    echo "УВАГА: Для використання Docker без sudo, перелогіньтесь або виконайте: newgrp docker"
fi