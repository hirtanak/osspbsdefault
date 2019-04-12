# Azure CycleCloud用テンプレート:OSS PBS Default

[Azure CycleCloud](https://docs.microsoft.com/en-us/azure/cyclecloud/) はMicrosoft Azure上で簡単にCAE/HPC/Deep Learning用のクラスタ環境を構築できるソリューションです。

![Azure CycleCloudの構築・テンプレート構成](画像URL "Azure CycleCloudの構築・テンプレート構成")

Azure CyceCloudのインストールに関しては、[こちら] (https://docs.microsoft.com/en-us/azure/cyclecloud/quickstart-install-cyclecloud) のドキュメントを参照してください。

CAE/HPCアプリケーションをインストールするためのベースライン用のテンプレートになっています。
以下の構成、特徴を持っています。

1. OSS PBSジョブスケジューラをMasterノードにインストール
2. H16r (Haswell 16コア FDR)を想定したテンプレート、イメージ
	 - OpenLogic CentOS 7.4 HPC を利用 
	 - HB/HCに関しては、変更が必要な可能性があり
3. Masterノードに512GB * 2 のNFSストレージサーバを提供
	 - Executeノード（計算ノード）からNFSをマウント
4. MasterノードのIPアドレスを固定設定
	 - 一旦停止後、再度起動した場合にアクセスする先のIPアドレスが変更されない

![OSS PBS Default テンプレート構成](画像URL "OSS PBS Default テンプレート構成")

OSS PBS Defaultテンプレートインストール方法

1. テンプレート本体をダウンロード
2. 展開、ディレクトリ移動
3. cyclecloudコマンドラインからテンプレートインストール 
   - [cyclecloud-OSSPBSDefault]$ cyclecloud import_template -f templates/osspbsdefault.txt

***
Copyright Hiroshi Tanaka, hirtanak@gmail.com, @hirtanak . All rights reserved.
Use of this source code is governed by MIT license that can be found in the LICENSE file.
