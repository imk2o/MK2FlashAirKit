# MK2FlashAirKit

MK2FlashAirKitは[FlashAir API](https://flashair-developers.com/ja/documents/api/)を用い、FlashAirのデータへのアクセスを容易にするライブラリです。

## Requirements

* iOS 8.0 以上
* Xcode 7.3 以上

## Install

### Carthage

> TODO

## Usage

本ライブラリは[APIKit](https://github.com/ishkawa/APIKit)をベースに実装しています。

### FileList

指定ディレクトリ配下にあるフォルダ・ファイル一覧を取得するには`FileListRequest`を使用します。

```
import APIKit
import MK2FlashAirKit

let request = FileListRequest(directory: "/PATH/TO/DIR")
Session.sendRequest(request) { [weak self] (result) in
    switch result {
    case .Success(let response):
        let items = response.fileListItems    // [FileListItem]
    case .Failure(let error):
        print("Error: \(error)")
    }
}
```

#### FileListItem

`FileListItem`より、以下のプロパティにてファイルの情報を取得できます。

* `fileName`: ファイル名
* `size`: ファイルサイズ
* `attributes`: ファイル属性
* `date`: ファイル作成日時
* `isDirectory`: ディレクトリか？
* `path`: ファイルパス
* `fileURL`: ファイルのURL
* `thumbnailURL`: サムネイル画像のURL

### 情報の取得

様々な情報を取得するリクエストを提供しています。

* `FileCountRequest`: 指定ディレクトリのファイル数を取得
* `IsUpdatedRequest`: ファイルの追加・変更の有無を取得
* `GetUpdatedTimeRequest`: ファイルの追加・変更からの経過時間を取得
* `GetSSIDRequest`: SSIDを取得
* `GetNetworkPasswordRequest`: ネットワークパスワードの取得
* `GetMACAddressRequest`: MACアドレスの取得
* `GetFirmwareVersionRequest`: ファームウェアバージョンの取得
* `GetWLANAwakeningModeRequest`: 無線LAN起動モードの取得
* `GetWLANTimeoutRequest`: 無線LANタイムアウトの取得
* `GetAppInfoRequest`: AppInfoの取得
* `IsUploadableRequest`: アップロード可否の取得
* `GetStorageInfoRequest`: ストレージ容量の取得

### 設定の変更

`ConfigRequest`で`Values`パラメータの指定により、FlashAirの設定を変更することができます。なお変更を行うと、FlashAirとの接続が切断される場合があります。

* `timeout`: 無線LANタイムアウト時間の変更
* `appInfo`: AppInfoの変更
* `wlanAwakeningMode`: 無線LAN起動モードの変更
* `networkKey`: ネットワークパスワードの変更
* `ssid`: SSIDの変更
* `networkKeyForBridgeMode`: ブリッジモードにおける接続先ネットワークパスワードの変更
* `ssidForBridgeMode`: ブリッジモードにおける接続先SSIDの変更
* `ciPath`: CIPathの変更

## License

The MIT License.
