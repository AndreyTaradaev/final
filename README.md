# Агрегатор  Новостей с поддержкой комментариев и проверкой на запрещенные слова

состоит из 4 приложений  ![1](https://github.com/AndreyTaradaev/final/assets/123914675/8515868e-918b-485d-bab1-a95835ca93ea)

все приложения имеют поддержку командной строки 
-help , -h -вывод справки по программе и необходимы формат  конфигурационного файла , и переменных среды окружения
-config <файл> -- файл конфигурации в формате JSON, при отсутсвии   настройки по умолчанию ->  пытается загрузить файл config.json ->
                  загружает настройки с переменных окружения  см. -help
-debug, -d  -  включает отладку

для проверки работаспособности подключен к gwcmd веб-интерфейс ("/") ,а также  "/swagger/index.html"
сформирован Dockerfile для проверки необходимо указать в нем переменные для подключения к БД новостей,комментариев ,цензуры
у censorcmd также для проверки есть swagger c проверкой комментария, и добавления запрещенных слов
