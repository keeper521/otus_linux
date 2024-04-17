#!/bin/bash

# Конфигурация скрипта
LOCK_FILE="/tmp/email_log_report.lock"
LOG_FILE="/var/log/nginx/access.log"
REPORT_FILE="/tmp/log_report_$(date +%Y%m%d%H%M%S).txt"
TIMESTAMP_FILE="/tmp/email_log_report.timestamp"
EMAIL="keeper521@yandex.ru"

# Создание файла блокировки для предотвращения одновременного запуска
if [ -f "$LOCK_FILE" ]; then
    echo "Скрипт уже выполняется."
    exit 1
else
    touch "$LOCK_FILE"
fi

# Получение времени последнего запуска, если оно есть
if [ -f "$TIMESTAMP_FILE" ]; then
    LAST_RUN=$(cat "$TIMESTAMP_FILE")
else
    LAST_RUN=$(date --date="1 hour ago" +"[%d/%b/%Y:%H:%M:%S")
fi

# Обновление времени последнего запуска скрипта
NOW=$(date +"[%d/%b/%Y:%H:%M:%S")
echo "$NOW" > "$TIMESTAMP_FILE"

# Удаление лишнего символа в дате
LAST=$(echo "$LAST_RUN" | sed 's/\[//g')
NOW_DATA=$(echo "$NOW" | sed 's/\[//g')

# Начало создания отчета
echo "Отчёт о логах с $LAST  по $NOW_DATA" > "$REPORT_FILE"
echo "=====================================" >> "$REPORT_FILE"

# Извлечение и анализ данных из файла логов
echo "IP адреса с наибольшим количеством запросов:" >> "$REPORT_FILE"
awk -v last_run="$LAST_RUN" -v now="$NOW" '$4 > last_run && $4 < now {print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "URL с наибольшим количеством запросов:" >> "$REPORT_FILE"
awk -v last_run="$LAST_RUN" -v now="$NOW" '$4 > last_run && $4 < now {print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Ошибки сервера/приложения:" >> "$REPORT_FILE"
awk -v last_run="$LAST_RUN" -v now="$NOW" '$4 > last_run && $4 < now && $9 ~ /^[45]/ {print $9,$7}' "$LOG_FILE" | sort | uniq -c | sort -nr >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "Коды HTTP ответов:" >> "$REPORT_FILE"
awk -v last_run="$LAST_RUN" -v now="$NOW" '$4 > last_run && $4 < now {print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr >> "$REPORT_FILE"

# Отправка отчёта
mail -s "Отчёт о логах с $LAST по $NOW_DATA" "$EMAIL" < "$REPORT_FILE"

# Удаление файла блокировки
rm "$LOCK_FILE"

echo "Отчёт отправлен на $EMAIL."
