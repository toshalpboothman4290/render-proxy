FROM python:3.11-slim

# tinyproxy + ابزارها
RUN apt-get update && apt-get install -y tinyproxy curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# نصب وابستگی‌ها
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt && pip install -U yt-dlp

# کپی کدها
COPY . .

# کانفیگ tinyproxy (فایل رو کنار Dockerfile بذار)
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

# پراکسی لوکال
EXPOSE 8888
ENV PYTHONUNBUFFERED=1

# اجرای همزمان tinyproxy و بات
CMD sh -c "tinyproxy -c /etc/tinyproxy/tinyproxy.conf & python -u Download_Chi.py"
