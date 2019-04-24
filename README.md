# [Clip Talk](https://cliptalk.herokuapp.com/)

シンプルなタスク共有グループウェア「Clip Talk」を開発しました。

![トップ](https://user-images.githubusercontent.com/10862638/56632452-cce0fa80-6694-11e9-84a3-2bc56c7d403f.jpg)
![部屋一覧](https://user-images.githubusercontent.com/10862638/56632490-f6018b00-6694-11e9-9631-071bb8998fa0.jpg)
![クリップサンプル](https://user-images.githubusercontent.com/10862638/56632496-fd289900-6694-11e9-8fb7-10819fec470a.jpg)

## 開発に使用した技術

- バックエンド　Ruby/2.6.2
- フロントエンド　JavaScript, sass/3.7.3
- フレームワーク　Ruby on Rails/5.2.2
- データベース　sqlite3/3.6.20 (development), PostgreSQL/11.2 (production)
- バージョン管理　git/1.7.1
- サーバー　heroku/7.22.9
- Gem  
  - フロントエンドフレームワーク　Bootstrap/4.3.1
  - ページネーション　kaminari/1.1.1
  - パスワード暗号化　bcrypt/3.1.12
- エディタ　VSCode
- ターミナル　PowerShell
- ローカル開発環境　Vagrant, VirtualBox
- SSHクライアント　PuTTy
- FTP　Cyberduck, sftp(VSCodeの拡張機能)

## 機能一覧

- グループ機能
  - グループ登録機能
    - グループURL作成機能
    - パスワード暗号化機能(bcrypt)
  - グループ管理者機能
    - 管理者ログイン機能
    - グループ編集機能
    - ユーザー、部屋、クリップ削除機能
  - ゴミ箱機能(削除されたデータを一覧表示)
    - ページネーション機能(kaminari)
    - タブによるリスト表示切替機能(Bootstrap, JavaScript)
- ユーザー機能
  - ユーザー登録機能
    - パスワード暗号化機能(bcrypt)
  - ユーザーログイン機能
  - ユーザー一覧表示機能
    - ページネーション機能(kaminari)
  - ユーザー詳細表示機能
    - タブによるリスト表示切替機能(Bootstrap, JavaScript)
  - ユーザー編集機能
    - 他ユーザーの編集禁止機能
- 部屋機能
  - 部屋作成機能
  - 小部屋作成機能
  - 部屋、小部屋一覧表示機能
    - ページネーション機能(kaminari)
  - 部屋管理者機能
    - 部屋編集機能
    - 部屋削除機能
    - 部屋管理者変更機能
- クリップ(タスク)機能
  - クリップ作成機能
  - クリップ一覧表示機能
    - ページネーション機能(kaminari)
  - クリップ詳細表示機能
    - トーク作成機能
    - トーク一覧表示機能
  - クリップ作成者機能
    - クリップ編集機能
    - クリップ削除機能
    - クリップのステータス変更機能
- その他
  - 未ログインユーザーのアクセス禁止対応
  - 他のグループ画面へのアクセス禁止対応
  - レスポンシブデザイン対応

## 使い方

### 1. グループ登録

「グループ登録」をクリック

![グループ登録](https://user-images.githubusercontent.com/10862638/56633037-74f7c300-6697-11e9-8488-2d334597ded0.jpg)

各項目を入力してください

![新規グループ登録](https://user-images.githubusercontent.com/10862638/56633292-78d81500-6698-11e9-8753-18d9b4916818.jpg)

グループ登録完了です  
この画面のグループURLを、参加させたい人に送信してください。

![グループ作成完了](https://user-images.githubusercontent.com/10862638/56633509-6ad6c400-6699-11e9-9f06-c953df3da05a.jpg)

### 2. ユーザー登録

「ユーザー登録」をクリック

![ユーザー登録](https://user-images.githubusercontent.com/10862638/56633931-16344880-669b-11e9-8a53-7d9db0aacbb7.jpg)

各項目を入力してください

![新規ユーザー登録](https://user-images.githubusercontent.com/10862638/56634178-f6e9eb00-669b-11e9-88b9-6c73bc90e32b.jpg)

ユーザー登録完了です  
これで、「Clip Talk」を使う準備が終わりました！

![ユーザー作成完了](https://user-images.githubusercontent.com/10862638/56634201-12ed8c80-669c-11e9-9a6c-5834ed6447cf.jpg)

### 3. 部屋機能

まずは部屋一覧画面で **部屋** を作成します。  
部屋の中で、共有したいタスクを作成していきます。  
タスクのテーマごとに部屋を作ったり、  
あるいはグループ内のチームごとに部屋を作ったり、  
用途に合わせて部屋を作って、円滑なタスク共有を実現できます。

![部屋サンプル１](https://user-images.githubusercontent.com/10862638/56635471-b771cd80-66a0-11e9-8e3d-147a5bda86d4.jpg)
![部屋サンプル２](https://user-images.githubusercontent.com/10862638/56636140-cfe2e780-66a2-11e9-82ba-7bdac81f54a2.jpg)

「部屋を作る」をクリック

![新規部屋作成](https://user-images.githubusercontent.com/10862638/56637000-7d56fa80-66a5-11e9-8f51-129e428f89c2.jpg)

部屋の名前を決める

![部屋作成画面](https://user-images.githubusercontent.com/10862638/56637130-d6bf2980-66a5-11e9-8f67-659a46e7d70e.jpg)

部屋が作られます

![部屋作成完了](https://user-images.githubusercontent.com/10862638/56637205-05d59b00-66a6-11e9-8bae-e12fc4081fc5.jpg)

部屋の中に **小部屋** を作成することもできます。  
フォルダのように階層的に部屋を組み立てることが可能ですので、  
大規模なグループの場合、組織の階層ごとに部屋を作成することもできますし、  
大型プロジェクトの場合、ラインごとに小部屋を作るといった工夫ができます。

![小部屋サンプル１](https://user-images.githubusercontent.com/10862638/56642043-9665a880-66b1-11e9-875b-85560a370fa7.jpg)
![小部屋サンプル２](https://user-images.githubusercontent.com/10862638/56642744-16404280-66b3-11e9-9cac-f0ac6383c3f3.jpg)

### 4. クリップ機能

部屋を作成したら、部屋の中に共有したいタスクを作成していきましょう。  
「Clip Talk」では、部屋で共有されている各タスクを、  
会議のホワイトボードに書き留められた議題、あるいはブラッシュアップされたアイデアを付箋で留める様になぞらえ、 **クリップ** と呼んでいます。  
クリップされたタスクには、グループメンバーがコメントすることができます。  
このコメント機能を **トーク** と呼びます。

![クリップサンプル１](https://user-images.githubusercontent.com/10862638/56643146-007f4d00-66b4-11e9-81b7-4f3ddfd08958.jpg)
![クリップサンプル２](https://user-images.githubusercontent.com/10862638/56645132-0aa34a80-66b8-11e9-8f5e-f2b4fdba5eaa.jpg)

「クリップ作成」をクリック

![新規クリップ作成](https://user-images.githubusercontent.com/10862638/56645407-96b57200-66b8-11e9-86ed-eb56aab39310.jpg)

クリップのタイトルと内容を作成します

![クリップ作成画面](https://user-images.githubusercontent.com/10862638/56645545-dc723a80-66b8-11e9-9e75-bf146ab9b84b.jpg)

クリップが作られます

![クリップ作成完了](https://user-images.githubusercontent.com/10862638/56645706-265b2080-66b9-11e9-8ff7-d73a137d8424.jpg)
![クリップ詳細](https://user-images.githubusercontent.com/10862638/56645977-9ff30e80-66b9-11e9-8665-6c19341dfc25.jpg)

トークフォームからトークを作成できます

![トークサンプル１](https://user-images.githubusercontent.com/10862638/56646287-3b847f00-66ba-11e9-80e1-91d0e1391b3c.jpg)
![トークサンプル２](https://user-images.githubusercontent.com/10862638/56646415-7be3fd00-66ba-11e9-9b2d-86a305d3dbdc.jpg)

クリップの状況を **ステータス** で確認できます。  
解決していないクリップは、ステータスを<font color="Red">進行中</font>に、  
解決したらクリップのステータスを<font color="Green">完了</font>にして、  
クリップの状況をメンバーが一目で分かるようにしましょう。

![ステータス完了](https://user-images.githubusercontent.com/10862638/56646946-8c48a780-66bb-11e9-8104-1e210c0f6e4e.jpg)

### 5. その他

* 部屋を作成したユーザーが、その部屋の **部屋管理者** になります。  
部屋管理者は、部屋名の編集及び削除を行うことができます。  
さらに、部屋管理者を他のユーザーに変更することも可能です。  
* **クリップ作成者** は、クリップの編集及び削除を行うことができます。  
ステータスの変更はクリップ作成者のみ行えます。  
* 削除した部屋及びクリップは、**ゴミ箱** 画面で確認できます。  
* ヘッダーの「ユーザー」をクリックすると、ユーザー一覧画面に移動します。  
グループに参加している全ユーザーを確認することができます。  
  * ユーザー名をクリックすると、ユーザーの詳細情報を確認できます。  
* ご自身のユーザー詳細画面から、ユーザー情報の編集を行うことができます。  
* **管理者ログイン** していただくことで、グループ管理者機能を使用できます。  
グループ管理者は **グループ編集** からグループ情報の編集を行えます。  
また、不要になったユーザー、部屋、クリップを削除することができます。  
  * 管理者ログインには、グループ登録時のメールアドレス、パスワードが必要です。
