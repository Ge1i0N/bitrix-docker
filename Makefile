apache-stop:
	sudo apachectl stop
	
start:
	docker-compose up --build -d

stop:
	docker-compose down --remove-orphans

setup:
	docker-compose exec php-fpm wget http://www.1c-bitrix.ru/download/scripts/bitrixsetup.php -O bitrixsetup.php
	make perm

restore:
	docker-compose exec php-fpm wget http://www.1c-bitrix.ru/download/scripts/restore.php -O restore.php
	make perm

composer-install:
	docker-compose exec -w /var/www/bitrix/bitrix -e COMPOSER=composer-bx.json php-fpm composer i

perm:
	sudo chgrp -R ${USER} src
	sudo chown -R ${USER}:${USER} src
	sudo chmod -R ug+rwx src
