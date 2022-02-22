let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Genel/rails/authentication_project
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd test/controllers/users_controller_test.rb
edit test/controllers/passwords_controller_test.rb
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe 'vert 2resize ' . ((&columns * 94 + 95) / 190)
argglobal
balt test/controllers/users_controller_test.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 97 - ((25 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 97
normal! 024|
wincmd w
argglobal
if bufexists("app/controllers/passwords_controller.rb") | buffer app/controllers/passwords_controller.rb | else | edit app/controllers/passwords_controller.rb | endif
if &buftype ==# 'terminal'
  silent file app/controllers/passwords_controller.rb
endif
balt app/controllers/users_controller.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 34 - ((33 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 34
normal! 05|
wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe 'vert 2resize ' . ((&columns * 94 + 95) / 190)
tabnext 1
badd +1 test/controllers/passwords_controller_test.rb
badd +78 test/controllers/users_controller_test.rb
badd +34 app/controllers/passwords_controller.rb
badd +6 app/controllers/users_controller.rb
badd +1 app/views/passwords/edit.html.erb
badd +74 app/models/user.rb
badd +16 app/controllers/concerns/authentication.rb
badd +33 app/views/users/edit.html.erb
badd +1 app/views/users/new.html.erb
badd +10 config/routes.rb
badd +1 app/controllers/sessions_controller.rb
badd +2 test/test_helper.rb
badd +6 test/fixtures/users.yml
badd +12 app/models/active_session.rb
badd +28 test/models/active_session_test.rb
badd +1 app/models/current.rb
badd +11 db/schema.rb
badd +7 app/views/user_mailer/password_reset.html.erb
badd +3 app/views/user_mailer/password_reset.text.erb
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFc
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
