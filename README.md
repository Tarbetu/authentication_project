# Authentication Project
With this template, you can build an authorization system with Grant and Role models.

The authentication part is mostly taken from [here.](https://stevepolito.design/blog/rails-authentication-from-scratch)

It behaves like a single page application but there is no JavaScript code.

# Yetkinlendirme Projesi
Bu taslak ile birlikte Grant (Yetki) ve Role (Rol) modelleri ile bir yetkilendirme sistemi hazırlayabilirsiniz. 
Çoğunlukla buradan inceleyerek yaptım: [Rails Authentication From Strach](https://stevepolito.design/blog/rails-authentication-from-scratch)

Tıpkı tek sayfalık bir uygulama (SPA) gibi çalışmakta ancak hiç JavaScript kullanılmadı.

# Tools/Kullanılan araçlar
- Redis
- Bootstrap
- Turbo (Hotwired)

# Installation
Nothing special. Just check the `db/seeds.rb` file.

# Caveats
There is some features depends on the four grants. (Read, Write, Manage Users and "Delete And Edit Others")
If you going to remove the "Posts Controller", you can safely remove these grants except "Manage Users"
You can see the `db/seeds.rb" file.

And there is minor problems in the Control Roles/Grants modal.
