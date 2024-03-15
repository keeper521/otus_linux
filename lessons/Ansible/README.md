### Роль Ansible по установке nginx
* Host установки прописывается в [hosts](https://github.com/keeper521/otus_linux/edit/main/lessons/Ansible/hosts)
* Переменные пропианы в [main](https://github.com/keeper521/otus_linux/blob/main/lessons/Ansible/nginx/vars/main.yml)
* Запускается командой: ```ansible-playbook nginx-install.yaml -i hosts```
