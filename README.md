# Azure CycleCloud用テンプレート:OSS PBS Default

[Azure CycleCloud](https://docs.microsoft.com/en-us/azure/cyclecloud/) はMicrosoft Azure上で簡単にCAE/HPC/Deep Learning用のクラスタ環境を構築できるソリューションです。

![Azure CycleCloudの構築・テンプレート構成](https://raw.githubusercontent.com/hirtanak/osspbsdefault/master/AzureCycleCloud-OSSPBSDefault.png "Azure CycleCloudの構築・テンプレート構成")

Azure CyceCloudのインストールに関しては、[こちら](https://docs.microsoft.com/en-us/azure/cyclecloud/quickstart-install-cyclecloud) のドキュメントを参照してください。

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

![OSS PBS Default テンプレート構成](https://raw.githubusercontent.com/hirtanak/osspbsdefault/master/OSSPBSDefaultDiagram.png "OSS PBS Default テンプレート構成")

OSS PBS Defaultテンプレートインストール方法

前提条件: テンプレートを利用するためには、Azure CycleCloud CLIのインストールと設定が必要です。詳しくは、 [こちら](https://docs.microsoft.com/en-us/azure/cyclecloud/install-cyclecloud-cli) の文書からインストールと展開されたAzure CycleCloudサーバのFQDNの設定が必要です。

1. テンプレート本体をダウンロード
2. 展開、ディレクトリ移動
3. cyclecloudコマンドラインからテンプレートインストール 
   - tar zxvf cyclecloud-OSSPBSDefault.tar.gz
   - cd cyclecloud-OSSPBSDefault
   - cyclecloud project upload azure-storage
   - cyclecloud import_template -f templates/osspbsdefault.txt
4. 削除したい場合、 cyclecloud delete_template osspbsdefault コマンドで削除可能

***
Copyright Hiroshi Tanaka, hirtanak@gmail.com, @hirtanak . All rights reserved.
Use of this source code is governed by MIT license that can be found in the LICENSE file.
