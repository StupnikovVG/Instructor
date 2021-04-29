#Использовать "."
#Использовать cmdline
#Использовать logos
#Использовать 1commands

Перем Лог;

Процедура Инициализация()
	Лог = ПараметрыСистемы.Лог();

	СистемнаяИнформация = Новый СистемнаяИнформация;

	МенеджерКомандПриложения.РегистраторКоманд(ПараметрыСистемы);

КонецПроцедуры

Функция ВыполнениеКоманды()
	
	ПараметрыЗапуска = РазобратьАргументыКоманднойСтроки();

	Если ПараметрыЗапуска = Неопределено ИЛИ ПараметрыЗапуска.Количество() = 0 Тогда

		ВывестиВерсию();
		Лог.Ошибка("Некорректные аргументы командной строки");
		МенеджерКомандПриложения.ПоказатьСправкуПоКомандам();
		Возврат МенеджерКомандПриложения.РезультатыКоманд().ОшибкаВремениВыполнения;

	КонецЕсли;

	Команда = "";
	ЗначенияПараметров = Неопределено;

	Если ТипЗнч(ПараметрыЗапуска) = Тип("Структура") Тогда

		// это команда
		Команда				= ПараметрыЗапуска.Команда;
		ЗначенияПараметров	= ПараметрыЗапуска.ЗначенияПараметров;

		Лог.Отладка("Выполняю команду продукта %1", Команда);

	ИначеЕсли ЗначениеЗаполнено(ПараметрыСистемы.ИмяКомандыПоУмолчанию()) Тогда

		// это команда по-умолчанию
		Команда				= ПараметрыСистемы.ИмяКомандыПоУмолчанию();
		ЗначенияПараметров	= ПараметрыЗапуска;

		Лог.Отладка("Выполняю команду продукта по умолчанию %1", Команда);

	Иначе

		ВызватьИсключение "Некорректно настроено имя команды по-умолчанию.";

	КонецЕсли;

	Возврат МенеджерКомандПриложения.ВыполнитьКоманду(Команда, ЗначенияПараметров);
	
КонецФункции

Процедура ВывестиВерсию()

	Сообщить(СтрШаблон("%1 v%2", ПараметрыСистемы.ИмяПродукта(), ПараметрыСистемы.ВерсияПродукта()));

КонецПроцедуры // ВывестиВерсию()

Функция РазобратьАргументыКоманднойСтроки()

	Парсер = ПолучитьПарсерКоманднойСтроки();
	Возврат Парсер.Разобрать(АргументыКоманднойСтроки);

КонецФункции // РазобратьАргументыКоманднойСтроки

Функция ПолучитьПарсерКоманднойСтроки()

	Парсер = Новый ПарсерАргументовКоманднойСтроки();

	МенеджерКомандПриложения.ЗарегистрироватьКоманды(Парсер);

	Возврат Парсер;

КонецФункции // ПолучитьПарсерКоманднойСтроки

Инициализация();
Попытка
	
	КодВозврата = ВыполнениеКоманды();
	ЗавершитьРаботу(КодВозврата);
	
Исключение
	
	Лог.КритичнаяОшибка(ОписаниеОшибки());
	ЗавершитьРаботу(1);
	
КонецПопытки;