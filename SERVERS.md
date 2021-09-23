# サーバー構成

## 物理マシン

### マシンスペック
Haswell(AMDはZen)以降のx86_64マシン
大量のRAM
できる限り大きいSSD
とてつもなくでかいHDD
Linux
Docker
Docker Swarm
将来的にKubernetes

### パーティション/ディレクトリルール

- システムディレクトリは最も高速なSSDもしくは別個にドライブを用意する
- 最も高速なSSDから直接ブートできない環境ではHDDに/bootを置いて、細工する
- /var/lib/dockerを最も高速なSSDにマップ
- /ouchistack-data/hdd/にHDDの専用パーティションをマウント
- /ouchistack-data/ssd/にSSDの専用パーティションをマウント

## イメージ

See [images/README.md](images/README.md)

## コンテナ設定

### ボリューム

- チェーンデータ等は`/ouchistack-data/hdd/*`へマップ
- 高頻度・高速アクセスを要する場合は`/ouchistack-data/ssd/*`へマップ

