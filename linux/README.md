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
</div>
