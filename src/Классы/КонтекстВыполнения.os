
#Использовать "./internal/types"

Перем ВнутреннийКонтекст;

Функция Добавить(КлючКонтекста, ЗначениеКонтекста) Экспорт
	
	ВнутреннийКонтекст.Вставить(КлючКонтекста, ЗначениеКонтекста);

	Возврат ЭтотОбъект;

КонецФункции

Функция Получить(КлючКонтекста, ПриемникЗначения = Неопределено) Экспорт
	
	ВнутреннийКонтекст.Свойство(КлючКонтекста, ПриемникЗначения);

	Возврат ПриемникЗначения;

КонецФункции

Функция Скопировать() Экспорт

	НовыйКонтекст = Новый КонтекстВыполнения;
	
	Для каждого ЭлементКонтекста Из ВнутреннийКонтекст Цикл

		НовыйКонтекст.Добавить(ЭлементКонтекста.Ключ, РаботаСТипами.Скопировать(ЭлементКонтекста.Значение));
	
	КонецЦикла;

	Возврат НовыйКонтекст;

КонецФункции

Процедура ПриСозданииОбъекта()
	
	ВнутреннийКонтекст = Новый Структура();

КонецПроцедуры