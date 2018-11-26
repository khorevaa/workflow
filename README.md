# workflow

[![Stars](https://img.shields.io/github/stars/khorevaa/workflow.svg?label=Github%20%E2%98%85&a)](https://github.com/khorevaa/workflow/stargazers)
[![Release](https://img.shields.io/github/tag/khorevaa/workflow.svg?label=Last%20release&a)](https://github.com/khorevaa/workflow/releases)
[![Открытый чат проекта https://gitter.im/EvilBeaver/oscript-library](https://badges.gitter.im/khorevaa/workflow.png)](https://gitter.im/EvilBeaver/oscript-library)

[![Build Status](https://travis-ci.org/khorevaa/workflow.svg?branch=master)](https://travis-ci.org/khorevaa/workflow)
[![Coverage Status](https://coveralls.io/repos/github/khorevaa/workflow/badge.svg?branch=master)](https://coveralls.io/github/khorevaa/workflow?branch=master)

# Библиотека для workflow

> Короткое название `workflow`

## Возможности

Данная библиотека предназначена для формирования бизнес-процессов в OScript.

## Установка

Для установки необходимо:
* Скачать файл workflow*.ospx из раздела [releases](https://github.com/khorevaa/workflow/releases)
* Воспользоваться командой:

```
opm install -f <ПутьКФайлу>
```
или установить с хаба пакетов

```
opm install workflow
```

## Пример работы

* Выполнение задач с использованием общего контекста
```bsl

	МассивПараметровЗадачи = Новый Массив();
	МассивПараметровЗадачи.Добавить("Параметр1ИзМассива");

	КонтекстВыполнения = БизнесПроцессы.НовыйКонтекстВыполнения();

	БизнесПроцесс = Новый БизнесПроцесс("Тестовый бизнес процесс");
	БизнесПроцесс.ДобавитьЗадачу("Задача1", ЭтотОбъект, "ПроцедураПомещенияВКонтекстЗначения", МассивПараметровЗадачи, КонтекстВыполнения);
	БизнесПроцесс.ДобавитьЗадачу("Задача2", ЭтотОбъект, "ПроцедураПолученияИзКонтекстаЗначения", МассивПараметровЗадачи, КонтекстВыполнения);
	БизнесПроцесс.Запустить();

```

## Публичный интерфейс

[Документация публичного интерфейса (в разработке)](docs/README.md)

## Доработка

Доработка проводится по git-flow. Жду ваших PR.

## Лицензия

Смотри файл [`LICENSE`](LICENSE).
