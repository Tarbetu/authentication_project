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
$argadd app/controllers/roles_controller.rb
set stal=2
tabnew
tabnew
tabnew
tabrewind
edit app/controllers/roles_controller.rb
argglobal
balt app/views/roles/_result.html.erb
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
let s:l = 62 - ((43 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 62
normal! 09|
tabnext
edit app/models/role.rb
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
split
1wincmd k
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
exe '1resize ' . ((&lines * 39 + 24) / 48)
exe '2resize ' . ((&lines * 5 + 24) / 48)
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
let s:l = 34 - ((33 * winheight(0) + 19) / 39)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 34
normal! 032|
wincmd w
argglobal
enew
balt app/models/role.rb
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
wincmd w
exe '1resize ' . ((&lines * 39 + 24) / 48)
exe '2resize ' . ((&lines * 5 + 24) / 48)
tabnext
edit app/models/user.rb
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
let s:l = 126 - ((14 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 126
normal! 012|
tabnext
edit app/views/posts/index.html.erb
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
exe 'vert 1resize ' . ((&columns * 31 + 47) / 94)
exe 'vert 2resize ' . ((&columns * 62 + 47) / 94)
argglobal
enew
file NERD_tree_5
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
wincmd w
argglobal
balt app/views/posts/_post.html.erb
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
let s:l = 1 - ((0 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 31 + 47) / 94)
exe 'vert 2resize ' . ((&columns * 62 + 47) / 94)
tabnext 3
set stal=1
badd +41 app/views/shared/_navbar.html.erb
badd +0 app/controllers/roles_controller.rb
badd +63 app/views/shared/_control_panel.html.erb
badd +25 app/views/layouts/application.html.erb
badd +0 NERD_tree_13
badd +3 app/views/roles/_result.html.erb
badd +1 app/views/roles/_err_message.html.erb
badd +80 app/controllers/posts_controller.rb
badd +20 config/routes.rb
badd +26 app/models/role.rb
badd +1 app/views/roles/edit.html.erb
badd +1 app/views/roles/new.html.erb
badd +1 app/views/roles/_form.html.erb
badd +1 app/views/users/edit.html.erb
badd +1 app/views/users/new.html.erb
badd +1 app/views/users/show.html.erb
badd +16 app/views/posts/_form.html.erb
badd +1 app/views/posts/edit.html.erb
badd +1 config.ru
badd +65 app/controllers/users_controller.rb
badd +1 app/views/roles/_ok_message.html.erb
badd +1 tmp/cache/assets/sprockets/v4.0.0/Uj/Uj7JMd9KnDseBt1A1_sOfYXnThZORGOvfXcs-EZ0WmU.cache
badd +1 app/views/shared/_user_actions.html.erb
badd +63 app/views/users/_user.html.erb
badd +4 app/views/shared/_search.html.erb
badd +1 app/views/posts/_post.html.erb
badd +7 app/views/posts/index.html.erb
badd +1 app/views/posts/show.html.erb
badd +0 app/models/user.rb
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
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
