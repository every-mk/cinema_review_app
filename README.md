# シネマレビュー

## なぜ作ったのか
映画が好きなのですが、映画レビューサイトを見ると評価の星幾つというのが曖昧な定義で余り参考にならないので、具体的にまた観たいのか観たくないのかで評価するサイトが欲しかったので作りました。

## こだわりポイント
- 評価の「また観たい」,「忘れた頃に観たい」,「もう観たくない」のいずれかを選択する事で映画を観たくなるかどうかがはっきりすると思います。
- レビュー内容がネタバレする場合は隠し文字として扱い、文字を範囲選択することで表示することができます。

* Ruby version 2.7.2

* System dependencies heroku

* Configuration
- Adminは映画と著名人の管理を行う。
- Userは映画と著名人の内容を閲覧する事ができる。
- Userは映画のレビューをする事ができる。
- 検索フォームにて映画タイトルまたは著名人を検索する事ができる。

* User views(一部)
[root](docs/cinema_index.png)
[cinema検索](docs/cinema_search.png)
[cinema詳細](docs/cinema_show.png)
[cinema詳細(ネタバレ表示)](docs/cinema_show_open_spoiler.png)

* Admin Views(一部)
[admin](docs/admin_index.png)
[cinema作成](docs/cinema_new.png)
[celebrity作成](docs/celebrity_new.png)

* Database relation
[DB間の関係](docs/erd.pdf)

* Database creation
$ rails db:create

* Database initialization
$ rails db:create:reset

* How to run the test suite
$ rails exec rubocop
$ rails exec rspec

* Services (job queues, cache servers, search engines, etc.)
- google chrome

* Deployment instructions
$ rails db:create
$ rails server
