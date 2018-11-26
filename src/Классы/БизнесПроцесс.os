#Использовать delegate
#Использовать logos
#Использовать "./internal/types"
#Использовать "./internal/handlers"
#Использовать "./internal/context"

Перем Лог;

Перем Наименование;
Перем МассивЗадач;
Перем _Стартован;
Перем _Завершен;
Перем _ОписаниеОшибки;
Перем ПрерватьВыполнение;

Перем ДелегатОбработкиОшибки;
Перем ОбработчикОшибкиЗадачаИлиБизнесПроцесса;
Перем Контекст; // Соответствие

Перем ОбработчикиСобытий;

Функция Стартован() Экспорт
	Возврат _Стартован;
КонецФункции

Функция Завершен() Экспорт
	Возврат _Завершен;
КонецФункции

Функция Наименование() Экспорт
	Возврат Наименование; 	
КонецФункции

Процедура УстановитьКонтекст(НовыйКонтекстБизнесПроцесса) Экспорт
	
	Контекст = НовыйКонтекстБизнесПроцесса;
	
КонецПроцедуры

Функция ПолучитьОписаниеОшибки() Экспорт
	Возврат _ОписаниеОшибки;
КонецФункции

Функция ПолучитьКонтекст() Экспорт
	
	Возврат Контекст;
	
КонецФункции

Функция НоваяЗадача(Знач НаименованиеЗадачи, Знач ВНачало = Ложь, ОбъектОбработчик,
	Знач ИмяМетода, ПараметрыМетода = Неопределено, КонтекстВыполненияЗадачи = Неопределено) Экспорт
	
	Возврат ДобавитьЗадачуВБизнесПроцесс(НаименованиеЗадачи, ВНачало, ОбъектОбработчик, ИмяМетода, ПараметрыМетода, КонтекстВыполненияЗадачи);
	
КонецФункции

Функция ДобавитьЗадачу(Знач НаименованиеЗадачи, ОбъектОбработчик,
	Знач ИмяМетода, ПараметрыМетода = Неопределено, КонтекстВыполненияЗадачи = Неопределено) Экспорт
	
	ДобавитьЗадачуВБизнесПроцесс(НаименованиеЗадачи, , ОбъектОбработчик, ИмяМетода, ПараметрыМетода, КонтекстВыполненияЗадачи);
	
	Возврат ЭтотОбъект;
	
КонецФункции

Функция ДобавитьЗадачуВНачало(Знач НаименованиеЗадачи, ОбъектОбработчик,
	Знач ИмяМетода, ПараметрыМетода = Неопределено, КонтекстВыполненияЗадачи = Неопределено) Экспорт
	
	ДобавитьЗадачуВБизнесПроцесс(НаименованиеЗадачи, Истина, ОбъектОбработчик, ИмяМетода, ПараметрыМетода, КонтекстВыполненияЗадачи);
	
	Возврат ЭтотОбъект;
	
КонецФункции

Функция ДобавитьЗадачуВБизнесПроцесс(Знач НаименованиеЗадачи, Знач ВНачало = Ложь, Знач ОбъектОбработчик,
	Знач ИмяМетода, ПараметрыМетода = Неопределено, КонтекстВыполненияЗадачи = Неопределено)
	
	НоваяЗадача = Новый ЗадачаБизнесПроцесса(НаименованиеЗадачи, ОбъектОбработчик, ИмяМетода, ПараметрыМетода, КонтекстВыполненияЗадачи);
	НоваяЗадача.УстановитьБизнесПроцесс(ЭтотОбъект);
	
	Если ВНачало Тогда
		МассивЗадач.Вставить(0, НоваяЗадача);	
	Иначе
		МассивЗадач.Добавить(НоваяЗадача);	
	КонецЕсли;
	
	Возврат НоваяЗадача;
	
КонецФункции

Функция НовоеУсловие(КлючКонтекста, КонтекстВыполнения = Неопределено) Экспорт
	
	УсловиеБизнесПроцесса = Новый УсловиеБизнесПроцесса(КлючКонтекста, КонтекстВыполнения, ЭтотОбъект);
	
	ДобавитьЗадачуВБизнесПроцесс(УсловиеБизнесПроцесса.Наименование(), , УсловиеБизнесПроцесса, "ВыполнитьУсловие", , КонтекстВыполнения);
	
	Возврат УсловиеБизнесПроцесса;
	
КонецФункции

Функция НовыйВложенныйБизнесПроцесс(Знач НаименованиеВложенногоБизнесПроцесса) Экспорт
	
	ВложенныйБизнесПроцесс = БизнесПроцессы.НовыйБизнесПроцесс(НаименованиеВложенногоБизнесПроцесса);
	ДобавитьВложенныйБизнесПроцесс(ВложенныйБизнесПроцесс);
	
КонецФункции

Функция ДобавитьВложенныйБизнесПроцесс(ВложенныйБизнесПроцесс) Экспорт
	
	Если ТипЗнч(ВложенныйБизнесПроцесс) = Тип("БизнесПроцесс") Тогда
		ДобавитьЗадачуВБизнесПроцесс(ВложенныйБизнесПроцесс.Наименование(), , ВложенныйБизнесПроцесс, "Запустить");
	Иначе
		ВызватьИсключение СтрШаблон("Не корректный тип <%1> бизнес процесса", ТипЗнч(ВложенныйБизнесПроцесс));
	КонецЕсли;
	
КонецФункции

Процедура ДобавитьЗадачуБизнесПроцесса(НоваяЗадачаБизнесПроцесса) Экспорт
	
	МассивЗадач.Добавить(НоваяЗадачаБизнесПроцесса);	
	
КонецПроцедуры

#Область Стандартные_обработчики

Процедура ПриОшибкеВыполненияЗадачиСтандартнаяОбработка(ЗадачаБизнесПроцесса, ПродолжитьВыполнение) Экспорт
	
	_ОписаниеОшибки = ЗадачаБизнесПроцесса.ПолучитьОписаниеОшибки();
	
	ПродолжитьВыполнение = Ложь;
	
КонецПроцедуры

Процедура ПриЗавершенииСтандартнаяОбработка() Экспорт
	
	_Завершен = Истина;
	
КонецПроцедуры

#КонецОбласти

Процедура НапечататьГрафВыполнения(НачальныйУровень = 0) Экспорт
	
	ВыводГрафаВыполнения = Новый ВыводГрафаВыполнения(НачальныйУровень);
	// TODO: Заготовка вывода графа выполнения

	// ВыводГрафаВыполнения.Вывести("Бизнес процесс <%1>:", Наименование());
	// ВыводГрафаВыполнения.Вывести("|");
	// ВыводГрафаВыполнения.Вывести("|\ Обработчики:");
	// // ВыводГрафаВыполнения.Вывести("|\");
	// ВывестиИнформациюПоСобытию("ПередВыполнением", ВыводГрафаВыполнения);
	// ВывестиИнформациюПоСобытию("ПередВыполнениемЗадачи", ВыводГрафаВыполнения);
	// ВывестиИнформациюПоСобытию("ПриОшибкеВыполненияЗадачи", ВыводГрафаВыполнения);
	// ВывестиИнформациюПоСобытию("ПослеВыполнениемЗадачи", ВыводГрафаВыполнения);
	// ВывестиИнформациюПоСобытию("ПриЗавершении", ВыводГрафаВыполнения);

	// ВыводГрафаВыполнения.Вывести("|");
	// ВыводГрафаВыполнения.Вывести("|-Задачи:");
	// ВыводГрафаВыполнения.Вывести("|\");
	
	// Для каждого ЗадачаБизнесПроцесса Из МассивЗадач Цикл

	// 	ЗадачаБизнесПроцесса.НапечататьГрафВыполнения(Уровень);

	// КонецЦикла;

КонецПроцедуры

Процедура ВывестиИнформациюПоСобытию(Знач ИмяСобытия, ВыводГрафаВыполнения)
	ТаблицаОбработчиков = ОбработчикиСобытий.ПолучитьОбработчикиПоСобытию(ИмяСобытия);
	ВыводГрафаВыполнения.Вывести("| |-<%1> - количество обработчиков <%2>", ИмяСобытия, ТаблицаОбработчиков.Количество());
	Для каждого СтрокаОбработчик Из ТаблицаОбработчиков Цикл
		
		ВыводГрафаВыполнения.Вывести("   |-<%1> - имя метода <%2>", СтрокаОбработчик.Обработчик, СтрокаОбработчик.ИмяМетода);
		
	КонецЦикла;
	
КонецПроцедуры

Процедура Запустить() Экспорт
	
	Если МассивЗадач.Количество() = 0 
		ИЛИ _Стартован 
		ИЛИ _Завершен Тогда
		Возврат;
	КонецЕсли;
	
	_Стартован = Истина;
	
	ПрерватьВыполнение = Ложь;
	
	Для каждого Задача Из МассивЗадач Цикл
		
		Если ПрерватьВыполнение Тогда
			_Завершен = Истина;
			Прервать;
		КонецЕсли;
		// ОбработчикиСобытий.Выполнить_("ПередВыполнениемЗадачи", ПараметрыСобытия)
		Задача.ВыполнитьЗадачу();
		
		Если Не Задача.Выполнена() Тогда
			Событие_ПриОшибкеВыполненияЗадачи(Задача, ПрерватьВыполнение);
		КонецЕсли;	
		// ОбработчикиСобытий.Выполнить_("ПослеВыполненияЗадачи", ПараметрыСобытия)
		
	КонецЦикла;
	
	Событие_ПриЗавершении();
	
КонецПроцедуры

#Область Переопределяемые_событий

Процедура ПриОшибкеВыполненияЗадачи(ОбъектОбработчик, Знач ИмяМетода) Экспорт
	
	ОбработчикиСобытий.Добавить("ПриОшибкеВыполненияЗадачи", ОбъектОбработчик, ИмяМетода);
	
КонецПроцедуры

#КонецОбласти


#Область События_Обработчики

Процедура Событие_ПриОшибкеВыполненияЗадачи(ЗадачаБизнесПроцесса, ПрерватьВыполнение)
	
	СтандартнаяОбработка = Истина;
	ПродолжитьВыполнение = Ложь;
	Параметры = ОбработчикиСобытий.НовыеПараметры(ЗадачаБизнесПроцесса, ПродолжитьВыполнение, СтандартнаяОбработка);
	ОбработчикиСобытий.Выполнить_("ПриОшибкеВыполненияЗадачи", Параметры);
	
	ПродолжитьВыполнение = Параметры[1];
	СтандартнаяОбработка = Параметры[2];
	
	Если СтандартнаяОбработка Тогда
		ПриОшибкеВыполненияЗадачиСтандартнаяОбработка(ЗадачаБизнесПроцесса, ПродолжитьВыполнение);
		ПродолжитьВыполнение = Параметры[1];
	КонецЕсли;
	
	ПрерватьВыполнение = НЕ ПродолжитьВыполнение;
	
КонецПроцедуры

Процедура ПолучитьОбработчикиСобытий() Экспорт
	Возврат ОбработчикиСобытий;
КонецПроцедуры

Процедура УстановитьОбработчикиСобытий(НовыеОбработчикиСобытий) Экспорт
	ОбработчикиСобытий = НовыеОбработчикиСобытий;
КонецПроцедуры

Процедура Событие_ПриЗавершении()
	
	СтандартнаяОбработка = Истина;
	Параметры = ОбработчикиСобытий.НовыеПараметры(ЭтотОбъект, СтандартнаяОбработка);
	ОбработчикиСобытий.Выполнить_("ПриЗавершении", Параметры);
	
	СтандартнаяОбработка = Параметры[1];
	
	Если СтандартнаяОбработка Тогда
		ПриЗавершенииСтандартнаяОбработка();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

Функция Скопировать() Экспорт
	
	НовыйБизнесПроцесс = Новый БизнесПроцесс(Наименование());
	НовыйКонтекст = НовыйБизнесПроцесс.ПолучитьКонтекст();
	
	Контекст.СкопироватьВ(НовыйКонтекст);
	
	Для каждого ЗадачаБизнесПроцесса Из МассивЗадач Цикл
		
		НоваяЗадача = ЗадачаБизнесПроцесса.Скопировать();
		НовыйБизнесПроцесс.ДобавитьЗадачуБизнесПроцесса(НоваяЗадача);
		
	КонецЦикла;
	
	Возврат НовыйБизнесПроцесс;
	
КонецФункции

Процедура ПриСозданииОбъекта(НаименованиеБизнесПроцесса)
	
	МассивЗадач = Новый Массив();
	_Стартован = Ложь;
	_Завершен = Ложь;
	ПрерватьВыполнение = Ложь;
	
	Наименование = НаименованиеБизнесПроцесса;
	
	ОбработчикиСобытий = Новый ОбработчикиСобытий;
	
	Контекст = Новый КонтекстВыполнения;
	
	Лог = Логирование.ПолучитьЛог("oscript.lib.workflow");
	
КонецПроцедуры