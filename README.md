# Karabas

**Конструктор пользовательского интерфейса к реляционным СУБД**


Позволяет строить интерфейс для анализа и редактирования данных,

обеспечивает распределение уровней доступа пользователей и логгирование их действий.


**Зависимости:**
```
perl >5.10;
Mojolicious;
DBI;
DBD::mysql; DBD::Pg; DBD::SQLite;
Text::Diff;
```


**Установка:**
```
cpan Mojolicious (и прочие недостающие модули)
git clone https://github.com/gmazay/karabas
```

**Запуск сервера с демо-шаблоном** (SQLite БД; в /db лежит и дамп БД для MySQL):
```
cd karabas
hypnotoad script/karabas  # production server
или
morbo script/karabas      # development server


По умолчанию путь к конфиг-файлу такой: etc/karabas.conf
Если возникнет потребность его изменить, нужно будет написать стартовый скрипт, и в нем, перед запуском,
задать переменную окружения: \$ENV{karabas_config}
```

**Вход:**
```
http://localhost:3000
Дефолтный аккаунт: login='admin', password='karabas'
```


Документация по использованию встроена в систему и будет доступна после развертывания шаблона.


Конфиг: etc/karabas.conf





На данный момент поддерживается 3 СУБД: MySQL, PostgreSQL и SQLite.

Чтобы добавить поддержку других СУБД, (или, например, реализовать поддержку транзакций и т.п.) нужно просто добавить модуль
в lib/model/, переопределив в нем, при необходимости, соответствующие методы родительского класса Model::Base.

Модуль будет загружен, если в конфиге будет присутствовать DSN с соответствующим "db_type".




При необходимости добавить функционал в один из редакторов (сейчас доступны Aed, Aedx, Subed), удобнее сделать так:

клонировать старый редактор, внести нужные изменения, подключить его - в списке редакторов в конфиге(чтобы грузился модуль)
и указать его в поле "editor" соответствующего раздела.


(Подключение как редакторов, так и моделей реализовано шаблоном "фабрика")