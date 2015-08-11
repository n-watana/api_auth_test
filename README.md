# api_auth_test

## 準備

```
$ bundle install
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed # ログインID/パスワードが test/test というユーザが作られる
$ bundle exec rails s
```

## 動き

```
localhost:3000/index.html
```

にアクセス。
このindex.html はifm での最初のページを想定。

ログインID、パスワードにそれぞれ test/test を入れると、

```
POST /api/auth
```

に非同期アクセスし、レスポンスヘッダーに

```
X-Access-Token: XXXXXXXXXXXXXX
```

のようにAPIアクセス用のトークンを取得できるので、
そのトークンを今度はリクエストヘッダーに

```
X-Access-Token: XXXXXXXXXXXXXX
```

のようにセットして、

```
GET /api/users
```

にアクセスして、レスポンスボディ(JSON)をそのまま画面表示。

/api/users では、リクエストヘッダ(X-Access-Token) の値から
AccessToken をクエリしてユーザを特定しています。
AccessToken が見つからなかったり、期限切れだと 401 となります。

