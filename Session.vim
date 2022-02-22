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
edit test/controllers/active_sessions_controller_test.rb
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
balt test/controllers/confirmations_controller_test.rb
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
let s:l = 42 - ((41 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 42
normal! 08|
wincmd w
argglobal
if bufexists("app/controllers/active_sessions_controller.rb") | buffer app/controllers/active_sessions_controller.rb | else | edit app/controllers/active_sessions_controller.rb | endif
if &buftype ==# 'terminal'
  silent file app/controllers/active_sessions_controller.rb
endif
balt app/controllers/sessions_controller.rb
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
let s:l = 19 - ((18 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 021|
wincmd w
exe 'vert 1resize ' . ((&columns * 95 + 95) / 190)
exe 'vert 2resize ' . ((&columns * 94 + 95) / 190)
tabnext 1
badd +79 test/controllers/passwords_controller_test.rb
badd +78 test/controllers/users_controller_test.rb
badd +13 app/controllers/passwords_controller.rb
badd +0 app/controllers/users_controller.rb
badd +1 app/views/passwords/edit.html.erb
badd +74 app/models/user.rb
badd +60 app/controllers/concerns/authentication.rb
badd +33 app/views/users/edit.html.erb
badd +1 app/views/users/new.html.erb
badd +10 config/routes.rb
badd +32 app/controllers/sessions_controller.rb
badd +18 test/test_helper.rb
badd +1 test/fixtures/users.yml
badd +12 app/models/active_session.rb
badd +28 test/models/active_session_test.rb
badd +1 app/models/current.rb
badd +11 db/schema.rb
badd +7 app/views/user_mailer/password_reset.html.erb
badd +3 app/views/user_mailer/password_reset.text.erb
badd +58 test/controllers/confirmations_controller_test.rb
badd +22 app/controllers/confirmations_controller.rb
badd +4 app/views/user_mailer/confirmation.html.erb
badd +3 app/views/user_mailer/confirmation.text.erb
badd +0 app/views/confirmations/new.html.erb
badd +106 test/controllers/sessions_controller_test.rb
badd +2 app/views/sessions/create.html.erb
badd +1 app/views/sessions/destroy.html.erb
badd +1 app/views/sessions/new.html.erb
badd +1 -p
badd +23 test/controllers/active_sessions_controller_test.rb
badd +4 test/controllers/greeter_controller_test.rb
badd +8 app/controllers/active_sessions_controller.rb
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
