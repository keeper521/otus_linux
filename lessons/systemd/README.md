# Инициализация системы. Systemd 
### 1. Написать service, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова (файл лога и ключевое слово должны задаваться в /etc/sysconfig или в /etc/default).
![1](https://github.com/keeper521/otus_linux/blob/main/lessons/systemd/files/1.JPG)  
![watchlog_found](https://github.com/keeper521/otus_linux/edit/main/lessons/systemd/files/watchlog_found.JPG)  

### 2. Установить spawn-fcgi и переписать init-скрипт на unit-файл (имя service должно называться так же: spawn-fcgi).
![install](https://github.com/keeper521/otus_linux/edit/main/lessons/systemd/files/install.JPG)  
![run_unit](https://github.com/keeper521/otus_linux/edit/main/lessons/systemd/files/run_unit.JPG)  

### 3. Дополнить unit-файл httpd (он же apache2) возможностью запустить несколько инстансов сервера с разными конфигурационными файлами.
![httpd](https://github.com/keeper521/otus_linux/edit/main/lessons/systemd/files/httpd.JPG)
