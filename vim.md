<div dir="rtl">

# vim

نصب و تنظیمات vim. برای استفاده از تمام ویژگی ها از `NeoVim` استفاده می شود.

## نصب NeoVim
1. دانلود [NeoVim](https://github.com/neovim/neovim)
2. `chmod u+x nvim.appimage`
3. کپی `nvim.appimage` به <span dir="ltr">`/usr/bin/nvim`</span>

## vim-plug
یک برنامه مدیریت افزونه های vim.

نصب:
<div dir="ltr">

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
</div>

تنظیمات:
1. ایجاد فایل `init.vim` در <span dir="ltr">`~/.config/nvim`</span>
2. نوشتن لیست افزونه ها بین <span dir="ltr">`call plug#begin()`</span> و <span dir="ltr">`call plug#end()`</span>
3. اجرای <span dir="ltr">`:PlugInstall`</span> از داخل nvim

## تم دراکولا
1. `Plug 'dracula/vim', { 'as': 'dracula' }`
2. قرار دادن `colorscheme dracula` در انتهای فایل

## NerdTree
1. <span dir="ltr">`Plug 'preservim/nerdtree'`</span>
2. میانبر باز و بسته کردن <span dir="ltr">`nnoremap <C-t> :NERDTreeToggle<CR>`</span>
3. باز کردن nerdtree در حالتی که هیچ فایلی در ابتدا انتخاب نشده است

<div dir="ltr">

```vim
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
```
</div>

4. نمایش وضعیت فایل ها در git: <span dir="ltr">`Plug 'Xuyuanp/nerdtree-git-plugin'`</span>
5. نمایش آیکون فایل ها: <span dir="ltr">`Plug 'ryanoasis/vim-devicons'`</span>
6. رنگ کردن آیکون ها متناسب با نوع آن: <span dir="ltr">`Plug 'tiagofumo/vim-nerdtree-syntax-highlight'`</span>

<div dir="ltr">

```vim
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
```
</div>

7. میانبر باز کردن فایل و split کردن آن:  <span dir="ltr">`Plug 'PhilRunninger/nerdtree-visual-selection'`</span>

## airline
1. <span dir="ltr">`Plugin 'vim-airline/vim-airline'`</span>
2. <span dir="ltr">`Plugin 'vim-airline/vim-airline-themes'`</span>
3. فعال کردن نوار پیمایش بالای صفحه: 
  
<div dir="ltr">

```vim
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='light'
let g:airline#extensions#branch#enabled=1
```
</div>
  
**نکته**: برای بستن هر پنجره از <span dir="ltr">`:bd`</span> استفاده می شود.

## میانبر ها
- ctrl Z, ctrl Y:
<div dir="ltr">

```vim
nnoremap <C-Z> u
nnoremap <C-Y> <C-R>
inoremap <C-Z> <C-O>u
inoremap <C-Y> <C-O><C-R>
```
</div>
  

## تنظیمات کلی
- شماره خط ها: `set number`
- فعال کردن ماوس: `set mouse=a`
- فارسی نویسی: `set termbidi`
- تنظیم tab:
<div dir="ltr">

```vim
set tabstop=2
set shiftwidth=2
set expandtab
```
</div>
  
- بستن خودکار پرانتز و ...: <span dir="ltr">`Plug 'jiangmiao/auto-pairs'`</span>
- ذخیره کردن خودکار: <span dir="ltr">`Plug '907th/vim-auto-save'`</span>

<div dir="ltr">

```vim
let g:auto_save = 1
let g:auto_save_events = ["InsertLeave", "CursorHoldI", "CursorHold"]
let g:auto_save_updateTime = 500
```
</div>
</div>
