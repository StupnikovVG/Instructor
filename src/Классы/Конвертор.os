#Использовать cmdline
#Использовать fs
#Использовать logos

Перем Лог;

Процедура ПриСозданииОбъекта(КаталогПоискаБиблиотек = "")
	
	Лог = ПолучитьЛог();
	// todo добавить проверку на установленный pandoc

КонецПроцедуры

Процедура HtmlToMarkdown(Знач Источник, Знач Куда) Экспорт

	ИмяФайлаПриемника = ОбъединитьПути(Куда, Источник.ИмяБезРасширения) + ".md";
	СтрокаЗапуска = СтрШаблон("pandoc -f html -t markdown %1", Источник.ПолноеИмя);	
	Лог.Отладка(СтрокаЗапуска);
	
	Результат = ВыполнитьКоманду(СтрокаЗапуска);
	СохранитьТекстовыйФайл(Результат, ИмяФайлаПриемника);

КонецПроцедуры

Процедура MarkdownToHtml(Знач Источник, Знач Куда) Экспорт

	ИмяФайлаПриемника = ОбъединитьПути(Куда, Источник.ИмяБезРасширения) + ".html";
	СтрокаЗапуска = СтрШаблон("pandoc -f markdown -t html %1 %2", Источник.ПолноеИмя);	
	Лог.Отладка(СтрокаЗапуска);

	Результат = ВыполнитьКоманду(СтрокаЗапуска);
	Результат = СтрШаблон(ШаблонHtml(), Результат);
	СохранитьТекстовыйФайл(Результат, ИмяФайлаПриемника);

КонецПроцедуры

Функция ШаблонHtml()
	Возврат "<!DOCTYPE html PUBLIC ""-//W3C//DTD HTML 4.0 Transitional//EN"">
	|<html>
	|<head>
	|<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">
	|</meta>
	|<link rel=""stylesheet"" type=""text/css"" href=""v8help://service_book/service_style"">
	|</link>
	|</head>
	|<body>
	|%1
	|</body>
	|</html>";	
КонецФункции

Функция ПолучитьЛог()

	Если Лог = Неопределено Тогда
		Лог = Логирование.ПолучитьЛог(ПараметрыСистемы.ИмяЛогаСистемы());
	КонецЕсли;
	Возврат Лог;

КонецФункции

Функция ВыполнитьКоманду(СтрокаЗапуска)

	Команда = Новый Команда;
	Команда.УстановитьПравильныйКодВозврата(0);
	Команда.ПоказыватьВыводНемедленно(Ложь);
	Команда.УстановитьСтрокуЗапуска(СтрокаЗапуска);
	КодВозврата = Команда.Исполнить();
	Результат = Команда.ПолучитьВывод();
	Если КодВозврата <> 0 Тогда
		ВызватьИсключение СтрШаблон("Код возврата не равен 0, а равен %1", КодВозврата);
	КонецЕсли;
	
	Возврат Результат;

КонецФункции

Функция СохранитьТекстовыйФайл(Знач ТекстДляСохранения, Знач ФайлДляСохранения)

	Текст = Новый ТекстовыйДокумент();
	Текст.УстановитьТекст(ТекстДляСохранения);
	Текст.Записать(ФайлДляСохранения);	

КонецФункции