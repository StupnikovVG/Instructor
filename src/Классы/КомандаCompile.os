#Использовать "../.."

Перем Лог;

Перем ПутьКИсходномуКоду;
Перем ПутьКИнструкциям;

Процедура ОписаниеКоманды(Команда) Экспорт

	Команда.Опция("src-path", "", "путь к исходному коду конфигурации")
		.ТСтрока();
	Команда.Опция("inst-path", "", "путь к каталогу инструкций в формате markdown")
		.ТСтрока();

КонецПроцедуры

Процедура ПередВыполнениемКоманды(Знач Команда) Экспорт
	
	Лог = ПараметрыПриложения.Лог();

	ПутьКИсходномуКоду = Команда.ЗначениеОпции("src-path");
	ПутьКИнструкциям = Команда.ЗначениеОпции("inst-path");

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт


		
КонецПроцедуры
