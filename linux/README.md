<div dir='rtl'>

# &rlm;linux

در این راهنما اقداماتی که باید بعد از نصب لینوکس انجام داد
به طور کامل توضیح داده شده است. دستورات این متن براساس توزیع
ubuntu
نوشته شده اند.

# &rlm;shell

راهنمای نصب و استفاده از
zsh در
[این فایل](/shell/zsh/README.md)
قرار دارد.

# نام سرور

1. تغییر نام فعلی سرور: <span dir='ltr'>`hostname <name>`</span>
2. تعیین نام سرور بعد از هر بار روشن شدن: ویرایش فایل
   <span dir='ltr'>`/etc/hostname`</span>
3. تنظیم DNS
   محلی: قرار دادن نام سرور (هم با دامنه و هم بی دامنه) در فایل
   <span dir='ltr'>`/etc/hosts`</span>

# ساعت

</div>

```sh
sudo timedatectl set-timezone Asia/Tehran
```

<div dir='rtl'>

# &rlm;ssh

## کلید

تولید جفت کلید در سمت کاربر و قرار دادن کلید عمومی آن در فایل
<span dir='ltr'>`~/.ssh/authorized_keys`</span>
در سمت سرور.

## تنظیمات

ویرایش فایل
<span dir='ltr'>`/etc/ssh/sshd_config`</span>
برای تغییر port، محدود کردن ورود root و جلوگیری از ورود با رمز عبور.

</div>

```
Port 1234
PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
```

<div dir='rtl'>

# ویرایشگر متن

ویرایش فایل ها با استفاده از
[vim](/vim)
که مانند یک ویرایشگر حرفه ای تنظیم شده است.

# &rlm;node js

</div>

```sh
curl -fsSL https://deb.nodesource.com/setup_<version>.x | sudo -E bash -
sudo apt install nodejs
```

<div dir='rtl'>

# &rlm;nginx

</div>

```sh
sudo apt install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
```

<div dir='rtl'>

قبل از استفاده مطمئن شوید که فایروال به درستی تنظیم شده است.

## مدیریت دسترسی ها

فایل های مربوط به nginx در مسیر
<span dir='ltr'>`/var/www/`</span>
قرار گرفته و مالک آن ها کاربر `www-data` است.
`www-data` همان کاربری است که nginx را اجرا می کند.

برای ایجاد یک دامنه جدید باید مراحل زیر را انجام داد.

### 1. ایجاد کاربر

به ازای هر دامنه یک کاربر وجود دارد.
ایم کاربر یک کاربر سیستمی است که
قابلیت وارد شدن نداشته و پوشه خانه ی آن
<span dir='ltr'>`/var/www/<domain>`</span>
است. به همراه این کاربر باید یک گروه به همان نام
ساخته شود. از این گروه برای مدیریت دسترسی nginx
استفاده می شود.

</div>

```sh
sudo adduser --system --group --home /var/www/<domain> --gecos '<domain>' <domain>
```

<div dir='rtl'>

### 2. دادن دسترسی به nginx

داده های هر دامنه محدود به خودش بوده و
سایر کاربران به آن هیچ دسترسی ای ندارند.
برای این که nginx بتواند به داده ها دسترسی داشته باشد
آن را عضو گروه آن دامنه می کنیم.

</div>

```sh
sudo adduser www-data <domain>
```

<div dir='rtl'>

### 3. مالکیت

برای کارکرد صحیح nginx
باید مالک و گروه همه فایل ها را برابر کاربر جدید قرار داد.

</div>

```sh
sudo chown -R <domain>:<domain> /var/www/<domain>
```

<div dir='rtl'>

### 4. سطح دسترسی

همه فایل ها باید دسترسی 640 و پوشه ها 750 داشته باشند.
با این روش سایر کاربران به فایل ها هیچ دسترسی ای ندارند و
تنها خود کاربر می تواند آن ها را مشاهده و ویرایش کند.
برای اینکه nginx بتواند فایل ها را بخواند تنها دسترسی
خواندن را به گروه می دهیم.

</div>

```sh
sudo chmod -R u=rwX,g=rX,o= /var/www/<domain>
```

<div dir='rtl'>

### 5. سطح دسترسی فایل های جدید

سطح دسترسی فایل ها و پوشه های جدید را می توان با استفاده از
acl
تعیین کرد.

</div>

```sh
sudo setfacl -d -m u::rwx,g::rx,o::- /var/www/<domain>
```

<div dir='rtl'>

با وجود اینکه مجوز اجرا توسط acl
داده شده ولی این مجوز تنها برای پوشه ها اعمال می شود
و فایل ها مجوز اجرایی نخواهند داشت.
چون در لینوکس به صورت پیش فرض مجوز اجرا از فایل های جدید
گرفته می شود و این مجوز تنها روی پوشه ها اثر دارد.

### 6. گروه فایل های جدید

فعال کردن بیت SGID برای پوشه domain
باعث می شود گروه فایل ها و پوشه های جدیدی که در آن ساخته می شوند
برابر با گروه خودش باشد. همچنین این کار باعث می شود بیت SGID
برای پوشه های جدید فعال شود. بنابراین این خاصیت برای پوشه های
درونی نیز برقرار خواهد بود.

</div>

```sh
sudo chmod g+s /var/www/<domain>
```
