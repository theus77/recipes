#!/usr/bin/make -f

include .env

ELK_VERSION  	?= elk8
ENVIRONMENT  	?= local
DOCKER_USER  	?= $(shell id -u)
PWD				= $(shell pwd)
RUN_WEB			= docker compose exec -u ${DOCKER_USER} web-${ENVIRONMENT} preview
RUN_NPM			= docker run -u ${DOCKER_USER}:0 --rm -it -v ${PWD}:/app --workdir /app smalswebtech/base-php:8.5-cli-dev npm

.DEFAULT_GOAL := help
.PHONY: help npm

help: # Show help for each of the Makefile recipes.
	@echo "EMS RECIPES"
	@echo "---------------------------"
	@echo "ELK_VERSION: ${ELK_VERSION}"
	@echo "DOCKER_USER: ${DOCKER_USER}"
	@echo "ADMIN:		${BACKEND_URL}"
	@echo "---------------------------"
	@echo ""
	@echo "Usage: make [target]"
	@echo "Targets:"
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' Makefile | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

## —— Demo —————————————————————————————————————————————————————————————————————————————————————————————————————————————
start: init_sandbox.passwd ## start docker
	@docker compose up -d
restart: init_sandbox.passwd ## restart docker and recreate
	@docker compose up -d --force-recreate
clean: ## delete docker volumes, generated assets and npm dependencies
	@$(MAKE) -s stop
	@docker volume rm elasticms_demo_${ELK_VERSION}_data01 elasticms_demo_${ELK_VERSION}_data02 elasticms_demo_${ELK_VERSION}_data03 elasticms_demo_postgres elasticms_demo_redis elasticms_demo_s3
	@rm -Rf dist/
	@rm -Rf node_modules/
stop: ## stop docker
	@docker compose down
status: ## status docker
	@docker compose ps
logs: ## logs
	@docker compose logs -f
update: ## update docker images
	@docker compose pull
	@docker compose up -d
clear-cache: ## clear cache
	@$(RUN_WEB) cache:clear

## —— Web ——————————————————————————————————————————————————————————————————————————————————————————————————————————————
web/%: ## run web command
	@$(RUN_WEB) $*
login: ## login
	@$(RUN_WEB) ems:admin:login --username=${EMS_USER}
emsch-status: ## local status
	@$(RUN_WEB) emsch:local:status
emsch-push: ## local push
	@$(RUN_WEB) emsch:local:push --force
emsch-pull: ## local pull
	@$(RUN_WEB) emsch:local:pull
emsch-assets: ## local upload (bundle.zip)
	@$(RUN_WEB) emsch:local:upload-assets --filename=/app/src/elasticms/local/skeleton/template/asset_hash.twig --as-style-set-assets
emsch-folder-upload: ## upload folder assets
	@$(RUN_WEB) emsch:local:folder-upload /app/src/elasticms/admin/assets
backup-configs: ## backup configs
	@$(RUN_WEB) ems:admin:backup --configs --export
backup-documents: ## backup documents
	@$(RUN_WEB) ems:admin:backup --documents --export
restore-configs: ## restore configs
	@$(RUN_WEB) ems:admin:restore --configs --force
restore-documents: ## restore documents
	@$(RUN_WEB) ems:admin:restore --documents --force
health-check: ## health check
	@$(RUN_WEB) emsch:health-check -g --no-debug

## —— Npm ——————————————————————————————————————————————————————————————————————————————————————————————————————————————
npm/%:
	@$(RUN_NPM) $*
npm-install: ## npm install
	@$(MAKE) npm/install
npm-prod: ## npm run prod
	@$(MAKE) npm/"run build"
npm-watch: ## npm run watch
	@$(MAKE) npm/"run watch"
npm-dev: ## npm run dev
	@$(MAKE) npm/"run dev"

## —— Tools—————————————————————————————————————————————————————————————————————————————————————————————————————————————
sandbox: ## open a terminal in a development sandbox container
	@docker compose exec sandbox sh -lc 'exec "$${SHELL:-bash}"'

init_sandbox.passwd:
	@printf '%s\n' \
		'root:x:0:0:root:/root:/bin/sh' \
		'bin:x:1:1:bin:/bin:/sbin/nologin' \
		'daemon:x:2:2:daemon:/sbin:/sbin/nologin' \
		'lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin' \
		'sync:x:5:0:sync:/bin:/bin/sync' \
		'shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown' \
		'halt:x:7:0:halt:/sbin:/sbin/halt' \
		'mail:x:8:12:mail:/var/mail:/sbin/nologin' \
		'news:x:9:13:news:/usr/lib/news:/sbin:/sbin/nologin' \
		'uucp:x:10:14:uucp:/var/spool/uucppublic:/sbin/nologin' \
		'cron:x:16:16:cron:/var/spool/cron:/sbin/nologin' \
		'ftp:x:21:21::/var/lib/ftp:/sbin/nologin' \
		'sshd:x:22:22:sshd:/dev/null:/sbin/nologin' \
		'games:x:35:35:games:/usr/games:/sbin/nologin' \
		'ntp:x:123:123:NTP:/var/empty:/sbin/nologin' \
		'guest:x:405:100:guest:/dev/null:/sbin/nologin' \
		'nobody:x:65534:65534:nobody:/:/sbin/nologin' \
		'www-data:x:82:82::/home/www-data:/sbin/nologin' \
		'postgres:x:70:70:PostgreSQL user:/var/lib/postgresql:/bin/sh' \
		'default:x:$(DOCKER_USER):0:default:/home/default:/bin/bash' \
		> sandbox.passwd