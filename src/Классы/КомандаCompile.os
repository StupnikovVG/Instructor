///////////////////////////////////////////////////////////////////
//
// Служебный модуль с реализацией работы команды version
//
// Структура модуля реализована в соответствии с рекомендациями 
// oscript-app-template (C) EvilBeaver
//
///////////////////////////////////////////////////////////////////

#Использовать fs
#Использовать logos

Перем Лог;

Функция ПолучитьЛог()
	Если Лог = Неопределено Тогда
		Лог = Логирование.ПолучитьЛог(ПараметрыСистемы.ИмяЛогаСистемы());
	КонецЕсли;
	Возврат Лог;
КонецФункции

Процедура ЗарегистрироватьКоманду(Знач ИмяКоманды, Знач Парсер) Экспорт

	ОписаниеКоманды = Парсер.ОписаниеКоманды(ИмяКоманды, "     Преобразование инструкций в формате markdown в 1C.");
	Парсер.ДобавитьКоманду(ОписаниеКоманды);

КонецПроцедуры // ЗарегистрироватьКоманду

// Выполняет логику команды
// 
// Параметры:
//   ПараметрыКоманды - Соответствие - Соответствие ключей командной строки и их значений
//   ДополнительныеПараметры - Соответствие - дополнительные параметры (необязательно)
//
// Возвращаемое значение:
//   Число - результат выполнения команды
//
Функция ВыполнитьКоманду(Знач ПараметрыКоманды, Знач ДополнительныеПараметры) Экспорт

	Лог = ПолучитьЛог();
	Лог.Отладка("Команда compile");
	Лог.Отладка(ТекущийКаталог());
	Для каждого Параметр Из ПараметрыКоманды Цикл
		Лог.Отладка(Параметр.КЛюч + " " + Параметр.значение)	
	КонецЦикла;

	КаталогИсходников = ПараметрыКоманды["--src-path"];
	КаталогИнструкций = ПараметрыКоманды["--ins-path"];
	Если Не ФС.КаталогСуществует(КаталогИнструкций) Тогда
		Лог.Ошибка("Не обнаружен каталог с инструкциями");
		Возврат МенеджерКомандПриложения.РезультатыКоманд().НеверныеПараметры;
	КонецЕсли;

	Если Не ФС.КаталогСуществует(КаталогИсходников) Тогда
		Лог.Ошибка("Не обнаружен каталог с исходными файлами");
		Возврат МенеджерКомандПриложения.РезультатыКоманд().НеверныеПараметры;
	КонецЕсли;

	Файлы = НайтиФайлы(Откуда, ПолучитьМаскуВсеФайлы());
	Для Каждого Файл Из Файлы Цикл

		ИмяФайла = Файл.Имя;
		Расширение = Файл.Расширение;
		Если ИмяФайла = "_files" Тогда
			СкопироватьВложенныеРисунки(Файл.ПолноеИмя, КаталогИсходников, КаталогИсходников);	
		КонецЕсли;

	КонецЦикла;

	Возврат МенеджерКомандПриложения.РезультатыКоманд().Успех;

КонецФункции // ВыполнитьКоманду

Процедура СкопироватьВложенныеРисунки(КаталогИсточник, КаталогИнструкций, КаталогИсходников)
	
	Лог = ПолучитьЛог();
	КаталогНазначение = СтрЗаменить(КаталогИсточник, КаталогИнструкций, КаталогИсходников);
	ФС.ОбеспечитьПустойКаталог(КаталогНазначение);
	Файлы = НайтиФайлы(КаталогИсточник, ПолучитьМаскуВсеФайлы());
	Для Каждого Файл Из Файлы Цикл
		ПутьКопирования = КаталогНазначение + Файл.Имя;
		КопироватьФайл(Файл.ПолноеИмя, ПутьКопирования);
		Лог.Отладка(ПутьКопирования);
	КонецЦикла;

КонецПроцедуры