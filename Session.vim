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
set stal=2
tabnew
tabnew
tabnew
tabrewind
edit config/routes.rb
argglobal
balt app/models/user.rb
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
let s:l = 13 - ((12 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 13
normal! 037|
tabnext
edit app/models/user.rb
argglobal
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
let s:l = 23 - ((22 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 029|
tabnext
edit app/models/concerns/authentication.rb
argglobal
balt app/models/active_session.rb
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
let s:l = 47 - ((33 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 47
normal! 080|
tabnext
edit app/controllers/active_sessions_controller.rb
argglobal
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
let s:l = 10 - ((9 * winheight(0) + 23) / 47)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 05|
tabnext 1
set stal=1
badd +13 config/routes.rb
badd +1 app/models/user.rb
badd +25 app/controllers/confirmations_controller.rb
badd +1 README.md
badd +3 app/views/confirmations/new.html.erb
badd +2 .solargraph.yml
badd +11 app/views/users/new.html.erb
badd +4 app/views/users/_form_errors.html.erb
badd +59 app/controllers/users_controller.rb
badd +3 db/migrate/20220219171518_create_users.rb
badd +5 db/migrate/20220219174005_add_confirmation_and_password_columns_to_users.rb
badd +1 app/views/static_pages/index.html.erb
badd +3 app/controllers/static_pages_controller.rb
badd +1 app/controllers/greeter_controller.rb
badd +1 test/controllers/confirmations_controller_test.rb
badd +15 app/mailers/user_mailer.rb
badd +1 app/views/user_mailer/confirmation.html.erb
badd +3 app/views/user_mailer/confirmation.text.erb
badd +71 config/environments/development.rb
badd +1 app/models/current.rb
badd +47 app/models/concerns/authentication.rb
badd +5 app/controllers/application_controller.rb
badd +36 app/controllers/sessions_controller.rb
badd +9 app/views/sessions/new.html.erb
badd +7 app/views/user_mailer/password_reset.html.erb
badd +3 app/views/user_mailer/password_reset.text.erb
badd +67 app/controllers/passwords_controller.rb
badd +1 yapılacaklar.txt
badd +37 .gitignore
badd +3 app/views/passwords/new.html.erb
badd +1 app/views/passwords/edit.html.erb
badd +33 app/views/users/edit.html.erb
badd +2 db/migrate/20220220100400_add_remember_token_to_users.rb
badd +6 db/migrate/20220220104516_create_active_sessions.rb
badd +49 config/environments/production.rb
badd +5 app/views/users/_active_session.html.erb
badd +8 app/models/active_session.rb
badd +23 app/controllers/active_sessions_controller.rb
badd +8 db/migrate/20220220120106_move_remember_token_from_users_to_active_sessions.rb
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFc
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
