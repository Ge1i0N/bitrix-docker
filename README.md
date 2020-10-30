# Bitrix-docker
Сборка Docker для разработки и тестирования проектов.

## В сборке
- PHP 7.3 (opcache, xdebug)
- nginx stable
- mysql 5.7
- smtp (иммитация, перехват писем скриптом на go)
- mailhog для просмотра писем

Соответствует всем тестам на БУС

## Установка зависимостей
- Git
```
sudo apt-get install -y git
```
- Docker
```
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo usermod -aG docker $USER
```

- Docker compose
```
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Первичная настройка и установка
- Остановите штатный apache (Для MacOS)
```
sudo apachectl stop
```
- Склонируйте репозиторий bitrix-docker
- Выполните настройку окружения  в `.env`
- Запустите bitrix-docker
```
make install
```

## Начало работы
Запустить контейнер:
```
make docker-up
```

Выключить контейнер:
```
make docker-down
```

## Установка bitrix

Bitrix проект нужно расположить в папке `src`

### Установка через `bitrixsetup.php`
- Скачайте `bitrixsetup.php` (файл будет скачан с официального сайта автоматически)
```
make bitrix-setup
```

- Установка будет доступна по адресу `http://10.100.0.21` (NGINX_INTERFACE в `.env`)
> При установке `bitrix` необходимо в окне создания базы данных в графе "Сервер" 
`localhost` заменить на `mysql` (так как контейнер поднятый в сети имеет название `mysql`)

### Востановление через `restore.php`
- Скачайте `restore.php` (файл будет скачан с официального сайта автоматически)
```
make bitrix-restore-download &&
make bitrix-restore url=<ссылка для переноса>
```

- Востановление будет доступна по адресу `http://10.100.0.21/restore.php`
> При востановлениии необходимо в окне создания базы данных в графе "Сервер" 
`localhost` заменить на `mysql` (так как контейнер поднятый в сети имеет название `mysql`)

## Использование

### Mailhog 
Mailhog (почтовый клиент) все письма из системы будут отображены в почтовом клиенте. Доступен по адресу http://10.100.0.1:8025/
