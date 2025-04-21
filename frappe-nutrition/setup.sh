#!/bin/bash

# Tên site và app
SITE_NAME=nutrition.local
APP_NAME=frappe_nutrition

# Kiểm tra bench
if ! command -v bench &> /dev/null; then
    echo "❌ Lỗi: bench không được cài đặt."
    exit 1
fi

# Kiểm tra MySQL/MariaDB
if ! systemctl is-active --quiet mysql; then
    echo "❌ Lỗi: MySQL/MariaDB không chạy. Khởi động: sudo systemctl start mysql"
    exit 1
fi

echo "👉 Tạo site: $SITE_NAME"
bench new-site $SITE_NAME --admin-password admin123 --mariadb-user-host-login-scope='%'

if [ $? -eq 0 ]; then
    echo "👉 Cài app: $APP_NAME"
    bench --site $SITE_NAME install-app $APP_NAME
    echo "✅ Hoàn tất. Chạy: bench start"
else
    echo "❌ Lỗi khi tạo site. Kiểm tra MySQL."
    exit 1
fi