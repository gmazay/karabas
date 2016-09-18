# Karabas

Конструктор пользовательского интерфейса к реляционным СУБД


Позволяет строить интерфейс для анализа и редактирования данных,

обеспечивает распределение уровней доступа пользователей и логгирование их действий.


Зависимости:

perl >5.10;
Mojolicious;
DBI;
DBD::mysql; DBD::pg; DBD::SQLite;
Text::Diff;



Установка и запуск сервера с демо-шаблоном крайне просты:

git clone https://github.com/gmazay/karabas

cd karabas

hypnotoad script/karabas  # production server

or

morbo script/karabas      # development server


go to http://localhost:3000 as login='admin', password='karabas'

Запуск будет произведен с шаблонной SQLite базой данных.

Там будет и кое-какая документация.

Конфиг: etc/karabas.conf





На данный момент поддерживается 3 СУБД: MySQL, Postgres и SQLite.

Чтобы добавить еще, нужно просто добавить модуль в lib/model/, переопределив в нем, при необходимости,
соответствующие методы родительского класса Model::Base.

Модуль будет загружен, если прописать в конфиге DSN с соответствующим "db_type".




При необходимости добавить функционал в один из редакторов (сейчас доступны Aed, Aedx, Subed), удобнее сделать так:

клонировать старый редактор, внести нужные изменения, подключить его - в списке редакторов в конфиге(чтобы грузился модуль)
и указать его в поле "editor" соответствующего раздела.
