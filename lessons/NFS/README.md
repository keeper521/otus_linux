# NFS, FUSE
* При запуске виртуальной машины командой ```vagrant up``` создаются 2 виртуальные машины: сервер и клиент  
* На сервере расшарена директория ```/srv/share/```  
* На клиенте автоматически монтируется при старте расшареная директория в ```/mnt``` по UDP  
* В шаре находится папка upload с правами на запись  
