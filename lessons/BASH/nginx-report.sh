#!/bin/bash

LOCK_FILE="/tmp/email_log_report.lock"
LOG_FILE="/var/log/nginx/access.log"
REPORT_FILE="/tmp/log_report_$(date +%Y%m%d%H%M%S).txt"
EMAIL="keeper521@yandex.ru"

# Проверка на наличие файла блокировки для предотвращения одновременного выполнения
if [ -f "$LOCK_FILE" ]; then
    echo "Скрипт уже выполняется."
    exit 1
else
    touch "$LOCK_FILE"
fi

# Генерация отчёта
echo "Отчёт о логах за последний час" > "$REPORT_FILE"
echo "=====================================" >> "$REPORT_FILE"

# IP адреса с наибольшим количеством запросов
echo "IP адреса с наибольшим количеством запросов:" >> "$REPORT_FILE"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 >> "$REPORT_FILE"

# Запрашиваемые URL
echo "" >> "$REPORT_FILE"
echo "Запрашиваемые URL с наибольшим количеством запросов:" >> "$REPORT_FILE"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 >> "$REPORT_FILE"

# Ошибки сервера
echo "" >> "$REPORT_FILE"
echo "Ошибки сервера/приложения:" >> "$REPORT_FILE"
awk '$9 ~ /^[45]/ {print $9,$7}' "$LOG_FILE" | sort | uniq -c | sort -nr >> "$REPORT_FILE"

# HTTP статус коды
echo "" >> "$REPORT_FILE"
echo "Коды HTTP ответов:" >> "$REPORT_FILE"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr >> "$REPORT_FILE"

# Отправка отчёта
mail -s "Отчёт о логах за последний час" "$EMAIL" < "$REPORT_FILE"

# Удаление файла блокировки
rm "$LOCK_FILE"

echo "Отчёт отправлен на $EMAIL."
