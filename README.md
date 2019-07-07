# 概要
deviseを使わないでログインする仕組みをrails tutorialを見て作ってみる
- https://railstutorial.jp/

# いろいろメモ

## has_secure_password
- セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるようになる。
- 2つのペアの仮想的な属性 (passwordとpassword_confirmation) が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される
- authenticateメソッドが使えるようになる (引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド) 。
- この魔術的なhas_secure_password機能を使えるようにするには、1つだけ条件があります。それは、モデル内にpassword_digestという属性が含まれていることです。
- 扱うには`gem 'bcrypt'`が必要

## Userのremember_tokenカラム
- ブラウザを閉じてもログインを維持するために使用している

## 現在の位置を保存、復元
- 今回は実装を省いたがログイン後に現在のURLを復元する機能もある
- https://railstutorial.jp/chapters/updating-showing-and-deleting-users?version=4.0

```ruby
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
```
