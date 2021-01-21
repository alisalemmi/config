<div dir="rtl">

# فایل های تنظیمات برنامه های مختلف

### از eslint و prettier تا zsh 😎

در این repository فایل های تنظیمات
و راهنمای نصب برنامه های مختلف
قرار داده خواهد شد. این برنامه ها در دسته های زیر قرار می گیرند.

<br />
<br />

# git

## gitignore

فایل هایی که نباید توسط گیت بررسی شوند را مشخص می کند
<br />
<br />

---
## husky

ایجاد hook برای git. برای مرتب کردن کد ها
قبل از commit استفاده می شود.

نصب:

<div dir="ltr">

```shell
npm i husky -D
npm i pretty-quick -D
```
</div>

از pretty-quick برای مرتب کردن استفاده می شود.

تنظیمات:
کد های زیر را به فایل
`package.json`
اضافه کنید

<div dir="ltr">

```json
{
  "husky": {
    "hooks": {
      "pre-commit": "pretty-quick --staged"
    }
  }
}
```
</div>

# lint and format

## eslint

نمایش خطا ها، پیشنهاد ها و ...

نصب:

<div dir="ltr">

```shell
npm i eslint -g
```
</div>

بعد از نصب با دستور
`eslint --init`
فایل تنظیمات اولیه ساخته می شود

* با نصب افزونه eslint برای vscode می توان از آن
در vscode استفاده کرد

* می توان با انجام تنظیماتی که در فایل پیوست آورده شده eslint را با prettier هماهنگ کرد

بسته هایی که برای تنظیمات eslint باید نصب شوند:
<div dir="ltr">

```
eslint-config-airbnb-base
eslint-config-prettier
eslint-plugin-import
eslint-plugin-prettier
```
</div>

---
## prettier

مرتب کردن کد های نوشته شده. prettier از بیش تر زبان ها پشتیبانی می کند

نصب:

<div dir="ltr">

```shell
npm i prettier -D
```
</div>

برای پشتیبانی از pug باید پلاگین 
<span dir="ltr">`@prettier/plugin-pug`</span>
نصب شود

</div>
