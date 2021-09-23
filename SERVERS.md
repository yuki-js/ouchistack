# サーバー構成

## 物理マシン

### マシンスペック

Haswell(AMD は Zen)以降の x86_64 マシン
大量の RAM
できる限り大きい SSD
とてつもなくでかい HDD
Linux
Docker
Docker Swarm
将来的に Kubernetes

### パーティション/ディレクトリルール

- システムディレクトリは最も高速な SSD もしくは別個にドライブを用意する
- 最も高速な SSD から直接ブートできない環境では HDD に/boot を置いて、細工する
- /var/lib/docker を最も高速な SSD にマップ
- /ouchistack-data/hdd/に HDD の専用パーティションをマウント
- /ouchistack-data/ssd/に SSD の専用パーティションをマウント

## イメージ

See [images/README.md](images/README.md)

## コンテナ設定

### ボリューム

以下のディレクトリをあらかじめ各物理ノードに作っておく。パーミッションは 0777

- チェーンデータ等は`/ouchistack-data/hdd/*`へマップ
- 高頻度・高速アクセスを要する場合は`/ouchistack-data/ssd/*`へマップ
