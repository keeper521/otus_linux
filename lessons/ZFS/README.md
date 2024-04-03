# ZFS
## Определить алгоритм с наилучшим сжатием:
* ### Определить какие алгоритмы сжатия поддерживает zfs (gzip, zle, lzjb, lz4), cоздать 4 файловых системы на каждой применить свой алгоритм сжатия
  ![1](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/gzip%2C%20zle%2C%20lzjb%2C%20lz4.JPG) 
* ### Для сжатия использовать либо текстовый файл, либо группу файлов
  ![download](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/download.JPG)  
## 2. Определить настройки пула. С помощью команды zfs import собрать pool ZFS. 
  ![import](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/import.JPG) 
### Командами zfs определить настройки:  
* размер хранилища, тип pool, значение recordsize, какое сжатие используется и
  какая контрольная сумма используется
  ![detail](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/detail.JPG)  
## 3. Работа со снапшотами:
* ## скопировать файл из удаленной директории
  ![copy](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/copy.JPG)  
* ## восстановить файл локально. zfs receive
  ![restore](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/restore.JPG)  
* ## найти зашифрованное сообщение в файле secret_message
  ![secret](https://github.com/keeper521/otus_linux/blob/main/lessons/ZFS/file/secret.JPG)  
