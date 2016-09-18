package Karabas::Controller::Editor::Base;

use Mojo::Base 'Mojolicious::Controller';
use utf8;
use POSIX 'locale_h';
setlocale(LC_CTYPE, 'ru_RU.UTF8');

has 'app';

1;