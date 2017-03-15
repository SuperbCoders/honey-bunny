# Honey Bunny

- Создать config/database.yml на основе config/database.yml.example
- Создать config/oauth.yml на основе config/oauth.yml.example
- Создать config/w1.yml (можно не создавать)
- bundle exec rake db:create db:schema:load rake db:seed

## Доступы в админку

Логин: corehook@gmail.com

Пароль: qwerty123

## Docker

Запустить окружение для разработки можно с помощью
`docker-compose -f development.yml up`

Команды типа rails ... или rake ... выполняем через `docker-compose -f development.yml run app [КОМАНДА]`

Пример: `docker-compose -f development.yml run app rake db:migrate`

Настройки database.yml для Docker'а:

```
development:
  adapter: postgresql
  encoding: unicode
  database: 'honey_bunny-development'
  pool: 5
  host: postgres
  username: postgres
```
