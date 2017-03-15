# Honey Bunny

- Создать config/database.yml
- Создать config/oauth.yml
- Создать config/w1.yml
- bundle exec rake db:create db:schema:load rake db:seed

Админ corehook@gmail.com Пароль qwerty123

## Docker

Запустить окружение для разработки можно с помощью
`docker-compose -f development.yml up`

Команды типа rails ... или rake ... выполняем через `docker-compose -f development.yml run app [КОМАНДА]`

Пример: `docker-compose -f development.yml run app rake db:migrate`
