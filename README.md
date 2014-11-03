# 栞


## 説明

Amazon ランキングを取得しDB等に保存するツール群です。

主目的はアニメ作品のDVD/BDのランキングの履歴の保存です。

動作にはShangriLa-APIサーバー(アニメ作品情報管理サーバー)が必要です（一部のツールを除く）。


## 事前準備

Amazon APIを利用するためAmazonの開発者登録が必要になります。

## 設定

conf/conf.json.sampleをconf/conf.jsonにコピーして適切な値を記述してください


## その他注意事項

macではbundle install中にAmazonのrubyモジュールが利用しているnokogiriのインストールで失敗します。

以下を参考にインストールしてください。

http://qiita.com/t_732_twit/items/a7956a170b1694f7ffc2

