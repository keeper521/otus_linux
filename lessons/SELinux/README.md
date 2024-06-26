# SELinux  
## 1. Запустить nginx на нестандартном порту 3-мя разными способами:  
* ### переключатели setsebool;  
  ![setsebool1](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/setsebool1.JPG)  
  ![setsebool2](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/setsebool2.JPG)  
  ![return](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/return.JPG)  
* ### добавление нестандартного порта в имеющийся тип;  
  ![semanage1](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/semanage1.JPG)  
  ![semanage2](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/semanage2.JPG)  
  ![return2](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/return2.JPG)  
* ### формирование и установка модуля SELinux.  
  ![semodule1](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/semodule1.JPG)  
  ![semodule2](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/semodule2.JPG)  
  ![semodule3](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/semodule3.JPG)  

## 2. Обеспечить работоспособность приложения при включенном selinux.  
* ### Пытаемся изменить настройки на клиенте  
  ![fail1](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/fail1.JPG)  
* ### Смотрим проблему по логам SELinux, находим проблему на сервере в контексте безопасности  
  ![1](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/1.JPG)
* ### Убеждаемся в наличии проблемы на сервере с контекстом безопасности
  ![5](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/5.JPG)  
* ### Меняем на сервере тип контекста безопасности для каталога /etc/named  
  ![4](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/4.JPG)  
* ### Меняем настройки на клиенте после изменений на сервере  
  ![2](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/2.JPG)  
* ### Проверяем после перезагрузки  
  ![3](https://github.com/keeper521/otus_linux/blob/main/lessons/SELinux/files/3.JPG) 
