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

### ディレクトリルール

- システムディレクトリは最も高速なSSDもしくは別個にドライブを用意する
- 最も高速なSSDから直接ブートできない環境ではHDDに/bootを置いて、細工する
- /var/lib/dockerを最も高速なSSDにマップ
- /ouchistack-data/hdd/をHDDにマップ
- /ouchistack-data/ssd/をSSDにマップ

## イメージ

See [images/README.md](images/README.md)

## コンテナ設定

### ボリューム

- チェーンデータ等は`/ouchistack-data/hdd/*`へ
- チェーンデータ等は`/ouchistack-data/hdd/*`へ

