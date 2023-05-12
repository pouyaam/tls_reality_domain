# TLS Domain for Reality - Ubuntu Version

سلام

ازاونجایی که حال نداشتم دامینی که با پروتوکل Reality کار کنه پیدا کنم، گفتم ببینم میشه خودم دامین راه بندازم که آخرش رسیدم به این پروژه کوچیک

شما کافیه یک دامین اول خریداری کنید و داخل یک DNS Solution مثل Cloudflare تعریفش کنید،‌لزومی نداره پراکسی هم فعال باشه

سپس داخل سرور خودتون دستور زیر رو بزنید تا اسکریپت نصب دانلود و اجرا بشه

``` bash
wget -N --no-check-certificate https://raw.githubusercontent.com/pouyaam/tls_reality_domain/main/installer.sh && chmod +x installer.sh && bash installer.sh
```

سپس اسکریپت از شما یک ایمیل و دامین که تعریف کردید رو میخواد، ایمیل میتونه هرچیزی باشه ولی دامین همین دامینی که تعریف کردید که میخواین روش TLS 1.3 فعال بشه باید باشه

بعدش اسکریپت شروع میکنه نصب و کانفیگ Nginx و در نهایت همه چی آمادس :) 
