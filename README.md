# Реализует преобразование инструкций конфигурации 1С в формат markdown и обратную сборку из markdown в html

## Методы библиотеки

 - **decompile** Преобразование инструкций из html в markdown
 - **compile** Преобразование инструкций из markdown в html 

## Параметры методов

 - **--src-path** Каталог выгрузки конфигурации в файлы
 - **--ins-path** Каталог инструкций в формате markdown 

## Принцип работы библиотеки

Методом **decompile** сформировать на основании выгруженной в файлы конфигурации каталог с инструкциями. В каталоге **--ins-path** дублируется структура каталогов исходников конфигурации, существующие файлы инструкций (ru.html) преобразуются в формат markdown.  

Далее инструкции в формате markdown дорабатываются по мере необходимости и методом compile обновляются в каталоге с исходными файлами. После чего конфигурация собираеся из исходников с обновленными инструкциями (например, с использованием утилиты pacman)

Для конвертации файлов html в markdown используется утилита [pandoc](https://github.com/jgm/pandoc). Путь к установенной утилите должен быть указан в переменной $PATH
