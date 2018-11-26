// Условие это вложенный бизнес процесс
#Использовать logos

перем КлючКонтекста;
Перем ИндексЗадачУсловия;
Перем Контекст;
Перем БизнесПроцесс;
Перем БизнесПроцессПоУмолчанию;

Перем Наименование;
Перем Идентификатор;
Перем Лог;

Функция ДляЗначения(Знач ЗначениеУсловия) Экспорт

	БизнесПроцессУсловия = Новый БизнесПроцесс(СтрШаблон("БП_Условия_%1_%2", КлючКонтекста, ЗначениеУсловия));
	// TODO: Скопировать обработчики связанные с задачами	
	ИндексЗадачУсловия.Вставить(ЗначениеУсловия, БизнесПроцессУсловия);

	Возврат БизнесПроцессУсловия;

КонецФункции

Функция ПоУмолчанию() Экспорт
	
	БизнесПроцессПоУмолчанию = Новый БизнесПроцесс(СтрШаблон("БП_Условия_%1_%2", КлючКонтекста, "ПоУмолчанию"));
	
	Возврат БизнесПроцессПоУмолчанию;

КонецФункции

Функция Наименование() Экспорт
	Возврат Наименование;
КонецФункции

Функция КлючКонтекста() Экспорт
	Возврат КлючКонтекста;
КонецФункции

Процедура ВыполнитьУсловие() Экспорт
	
	Если Контекст = Неопределено Тогда
		Контекст = БизнесПроцесс.ПолучитьКонтекст();
	КонецЕсли;

	ЗначениеУсловия = Контекст.Получить(КлючКонтекста);
	БизнесПроцессЗначения = ИндексЗадачУсловия[ЗначениеУсловия];

	Если Не БизнесПроцессЗначения = Неопределено Тогда
		БизнесПроцессЗначения.Запустить();
	ИначеЕсли НЕ БизнесПроцессПоУмолчанию = Неопределено Тогда
		БизнесПроцессПоУмолчанию.Запустить();
	КонецЕсли;

КонецПроцедуры

Процедура УстановитьБизнесПроцесс(БизнесПроцессУсловия) Экспорт
	
	Если Не БизнесПроцессУсловия = Неопределено Тогда
		Лог.КритичнаяОшибка("Для данного условия <%1> (<%2>) уже задан бизнес процесс. Переопределение невозможно", Наименование, Идентификатор);
		Возврат;
	КонецЕсли;
	
	БизнесПроцесс = БизнесПроцессУсловия;
	
КонецПроцедуры

Функция Скопировать() Экспорт
	
	ПараметрыМетодаНовойЗадач = РаботаСТипами.СкопироватьМассив(ПараметрыМетода);
	
	НоваяЗадача = Новый УсловиеБизнесПроцесса(Наименование, КонтекстВыполнения);
	
	Возврат НоваяЗадача;
	
КонецФункции

Процедура НапечататьГрафВыполнения(Уровень = 0) Экспорт
	// TODO: Заготовка вывода графа выполнения
КонецПроцедуры

Процедура ПриСозданииОбъекта(КлючУсловия, КонтекстВыполнения = Неопределено, БизнесПроцессУсловия = Неопределено)
	
	Наименование = КлючУсловия;
	Идентификатор = Новый УникальныйИдентификатор();
	КлючКонтекста = КлючУсловия;

	БизнесПроцесс = БизнесПроцессУсловия;
	Контекст = КонтекстВыполнения;

	ИндексЗадачУсловия = Новый Соответствие();

	Лог = Логирование.ПолучитьЛог("oscript.lib.workflow.condition");

КонецПроцедуры