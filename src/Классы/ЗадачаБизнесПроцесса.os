#Использовать logos
#Использовать delegate
#Использовать reflector
#Использовать "./internal/types"
#Использовать "./internal/handlers"
Перем Лог;

Перем Выполнена;          // Булево
Перем Наименование;       // Строка
Перем ОбъектОбработчик;   // Объект
Перем ИмяМетода;          // Строка
Перем ПараметрыМетода;    // Массив
Перем КонтекстВыполнения; // Объект <КонтекстВыполнения>
Перем Идентификатор;      // УникальныйИдентификатор
Перем БизнесПроцессЗадачи;      // Объект <БизнесПроцесс>
Перем ОбработчикиСобытийЗадачи; // Объект <ОбработчикиСобытий>
Перем ОписаниеОшибкиВыполнения; // Неопределено / Объект <ОписаниеОшибкиВыполнения>

#Область Программный_интерфейс

// Возвращает наименование задачи бизнес процесса
//
//  Возвращаемое значение:
//   Строка - наименование задачи бизнес процесса
//
Функция Наименование() Экспорт
	Возврат Наименование;
КонецФункции

// Возвращает UID задачи бизнес процесса
//
//  Возвращаемое значение:
//   УникальныйИдентификатор - UID задачи бизнес процесса
//
Функция Идентификатор() Экспорт
	Возврат Идентификатор;
КонецФункции

// Возвращает признак выполненности задачи бизнес процесса
//
//  Возвращаемое значение:
//   Булево - признак выполненности задачи бизнес процесса
//
Функция Выполнена() Экспорт
	Возврат Выполнена;
КонецФункции

// Начинает выполнение задачи
//
Процедура ВыполнитьЗадачу() Экспорт
	
	Если Выполнена Тогда
		ВызватьИсключение "Выполнение, уже выполненной задачи не возможно";
	КонецЕсли;

	ВыполнениеЗадачи();
	
	Если Не Выполнена Тогда 
		
		ПриОшибкеВыполненияЗадачи();

	КонецЕсли;
	
КонецПроцедуры

// Возвращает описание ошибки выполнения задачи бизнес процесса
//
//  Возвращаемое значение:
//   Объект - объект класса <ОписаниеОшибкиВыполнения>
//
Функция ПолучитьОписаниеОшибки() Экспорт
	
	Возврат ОписаниеОшибкиВыполнения; 
	
КонецФункции

// Устанавливает обработчик ошибки выполнения задачи бизнес процесса
//
// Параметры:
//   ОбъектОбработчик - Объект - произвольный класс
//   ИмяМетода - Строка - имя метода класс для выполнения
//
//  Возвращаемое значение:
//   Объект - объект класса <ЗадачаБизнесПроцесса>
//
Функция ПриОшибке(Обработчик, Знач ИмяМетодаОбработчика) Экспорт
	
	ОбработчикиСобытийЗадачи.ПроверитьОбработчикДляСобытия("ПриОшибке", Обработчик, ИмяМетодаОбработчика);
	ОбработчикиСобытийЗадачи.Добавить("ПриОшибке", Обработчик, ИмяМетодаОбработчика);

	Возврат ЭтотОбъект;
	
КонецФункции

// Возвращает бизнес процесс задачи
//
//  Возвращаемое значение:
//   Объект - объект класса <БизнесПроцесс>
//
Функция БизнесПроцесс() Экспорт
	
	Возврат БизнесПроцессЗадачи;
	
КонецФункции

// Устанавливает бизнес процесс задачи
//
// Параметры:
//   НовыйБизнесПроцессЗадачи - Объект - объект класса <БизнесПроцесс>
//
Процедура УстановитьБизнесПроцесс(НовыйБизнесПроцессЗадачи) Экспорт
	
	Если Не БизнесПроцессЗадачи = Неопределено Тогда
		Лог.КритичнаяОшибка("Для данной задачи <%1> (<%2>) уже задан бизнес процесс. Переопределение невозможно", Наименование, Идентификатор);
		Возврат;
	КонецЕсли;
	
	БизнесПроцессЗадачи = НовыйБизнесПроцессЗадачи;
	
КонецПроцедуры

#КонецОбласти

#Область Печать_графа

Процедура НапечататьГрафВыполнения(Уровень = 0) Экспорт
	// ВыводГрафаВыполнения = Новый ВыводГрафаВыполнения(Уровень);
	
	// TODO: Заготовка вывода графа выполнения
	// ВыводГрафаВыполнения.Вывести("Задача <%1> обработчик <%2> метод <%3>", Наименование(), ОбъектОбработчик, ИмяМетода);
	// ВыводГрафаВыполнения.Вывести("Обработчики:");
	// ВывестиИнформациюПоСобытию("ПриОшибке", ВыводГрафаВыполнения);
КонецПроцедуры

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Процедура ПриОшибкеВыполненияЗадачи()
	
	ПараметрыМетодаПриОшибке = Новый Массив();
	ПараметрыМетодаПриОшибке.Добавить(ЭтотОбъект);

	ОбработчикиСобытийЗадачи.Выполнить_("ПриОшибке", ПараметрыМетодаПриОшибке);
			
КонецПроцедуры

Процедура ВыполнениеЗадачи()
	
	Попытка
		
		ВыполнитьЗадачуПоУмолчанию();
		Выполнена = Истина;
		
	Исключение
		
		СформироватьОписаниеОшибкиВыполнения(ИнформацияОбОшибке());
		
	КонецПопытки;
	
КонецПроцедуры

Процедура СформироватьОписаниеОшибкиВыполнения(ОписаниеОшибкиИсключения);
	
	ОписаниеОшибкиВыполнения = Новый ОписаниеОшибкиВыполнения;
	ОписаниеОшибкиВыполнения.Ошибка = ОписаниеОшибкиИсключения;
	ОписаниеОшибкиВыполнения.Задача = ЭтотОбъект;
	ОписаниеОшибкиВыполнения.БизнесПроцесс = БизнесПроцессЗадачи;
	
КонецПроцедуры

Процедура ВыполнитьЗадачуПоУмолчанию()
	
	Делегат = Делегаты.Создать(ОбъектОбработчик, ИмяМетода);
	
	ИспользуетсяКонтекст = Не КонтекстВыполнения = Неопределено;
	
	Если ИспользуетсяКонтекст Тогда
		ВыполнитьЗадачуСКонтекстом(Делегат);
	Иначе
		ВыполнитьЗадачуБезКонтекста(Делегат);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЗадачуСКонтекстом(Делегат)
	
	ПараметрыСУчетомКонтекста = Новый Массив;
	ПараметрыСУчетомКонтекста.Добавить(КонтекстВыполнения);
	
	ЕстьСвоиПараметры = ПараметрыМетода.Количество();
	
	Если ЕстьСвоиПараметры Тогда
		Для каждого ПараметрМетода Из ПараметрыМетода Цикл
			ПараметрыСУчетомКонтекста.Добавить(ПараметрМетода);
		КонецЦикла;
	КонецЕсли;
	
	Делегат.Исполнить(ПараметрыСУчетомКонтекста);
	
	Если ЕстьСвоиПараметры Тогда
		
		МаксимальныйИндексПараметров = ПараметрыМетода.ВГраница();

		Для ИИ = 0 По МаксимальныйИндексПараметров Цикл
			ПараметрыМетода[ИИ] = ПараметрыСУчетомКонтекста[ИИ+1];
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЗадачуБезКонтекста(Делегат)
	
	Если ПараметрыМетода.Количество() > 0  Тогда
		Делегат.Исполнить(ПараметрыМетода);
		// TODO: Проработать вопрос присвоения массива параметров назад
	Иначе
		Делегат.Исполнить();
	КонецЕсли;
	
КонецПроцедуры

Функция Скопировать() Экспорт
	
	ПараметрыМетодаНовойЗадач = РаботаСТипами.СкопироватьМассив(ПараметрыМетода);
	
	НоваяЗадача = Новый ЗадачаБизнесПроцесса(Наименование, ОбъектОбработчик, ИмяМетода, ПараметрыМетодаНовойЗадач, КонтекстВыполнения);
	
	Возврат НоваяЗадача;
	
КонецФункции

Процедура ПроверитьОбъектОбработчик()
	
	КоличествоПараметровМетода = ПараметрыМетода.Количество();
	
	Если НЕ КонтекстВыполнения = Неопределено Тогда
		КоличествоПараметровМетода = КоличествоПараметровМетода + 1;
	КонецЕсли;
	
	РефлекторОбработчика = Новый РефлекторОбъекта(ОбъектОбработчик);
	МетодЗадачиЕсть = РефлекторОбработчика.ЕстьПроцедура(ИмяМетода, КоличествоПараметровМетода);
	
	Если Не МетодЗадачиЕсть Тогда
		ВызватьИсключение СтрШаблон("Не удалось создать задачу для объекта <%1> с методом <%2> (количество параметров <%3>)",
		ОбъектОбработчик, ИмяМетода, КоличествоПараметровМетода);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриСозданииОбъекта(Знач ЗначениеНаименование, Знач ЗначениеОбъектОбработчик,
	Знач ЗначениеИмяМетода, Знач ЗначениеПараметрыМетода = Неопределено, Знач ЗначениеКонтекстВыполнения = Неопределено)
	
	БизнесПроцессЗадачи = Неопределено;
	Идентификатор = Новый УникальныйИдентификатор();
	
	Наименование = ЗначениеНаименование;
	ОбъектОбработчик = ЗначениеОбъектОбработчик;
	ИмяМетода = ЗначениеИмяМетода;
	ПараметрыМетода = ЗначениеПараметрыМетода;
	КонтекстВыполнения = ЗначениеКонтекстВыполнения;
	
	ОбработчикиСобытийЗадачи = Новый ОбработчикиСобытий;
	ОбработчикиСобытийЗадачи.ДобавитьСобытие("ПриОшибке", 1);

	Выполнена = Ложь;
	
	Лог = Логирование.ПолучитьЛог("oscript.lib.workflow.task");
	
	Если ПараметрыМетода = Неопределено Тогда
		ПараметрыМетода = Новый Массив;
	КонецЕсли;
	
	ПроверитьОбъектОбработчик();
	
КонецПроцедуры

#КонецОбласти