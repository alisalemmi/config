<div dir='rtl'>

# &rlm;nvim

برای داشتن امکانات یک ویرایش گر کامل از
neovim
استفاده می کنیم.

## نصب

</div>

```sh
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt install neovim
```

<div dir='rtl'>

## تنظیم به عنوان پیش فرض

</div>

```sh
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
```

<div dir='rtl'>

# &rlm;vim-plug

برنامه ای برای مدیریت افزونه های vim.

## نصب

</div>

```sh
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

<div dir='rtl'>

# تنظیمات

برای تنظیم nvim
برای همه کاربران باید تنظیمات را در مسیر
<span dir='ltr'>`/etc/xdg/nvim/sysinit.vim`</span>
قرار داد. 

تنظیمات در فایل های
[editor.vim](/vim/editor.vim) و
[shortcut.vim](/vim/shortcut.vim)
و پوشه
[plugins](/vim/plugins)
قرار گرفته اند.

</div>
