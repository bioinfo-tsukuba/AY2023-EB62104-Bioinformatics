

# 演習B：FAQ

<!-- ## `.ipynb`ファイルのダウンロード・アップロードする方法
1. GitHub の tumor_communication.ipynb のページまで行きます
	- https://github.com/bioinfo-tsukuba/20210207-EB62104-Bioinformatics/blob/main/%E6%BC%94%E7%BF%92A/tumor_communication.ipynb
2. Raw というボタンを押すと、ファイルの中身が直接ブラウザに表示されます
	- URL例: https://raw.githubusercontent.com/bioinfo-tsukuba/20210207-EB62104-Bioinformatics/main/%E6%BC%94%E7%BF%92A/tumor_communication.ipynb
3. ２通りの方法があります
	- a: 一旦ファイルを自分のコンピューターに保存して、JupyterHubにアップロード
	- b: jupyterHubのターミナルで wget で URL から直接ダウンロード -->


<!-- ### 基本課題A-3 ですが、 outer_join と書いてあるのは full_join の誤りでした

・関数名は `full_join()` でした
・manaba で修正しました https://manaba.tsukuba.ac.jp/ct/course_1318532_rptadmpreview_1855392
・GitHub でも修正しました https://github.com/bioinfo-tsukuba/20210207-EB62104-Bioinformatics/tree/main/%E6%BC%94%E7%BF%92A -->

<!-- ### 基本課題 A-3 は行数のみを提出してください

基本課題 A-3 は行数のみを提出してください（コードは提出しません） -->
<!-- 
### 基本課題A-5 の提出方法を変更します (PDFではなくHTML)

- PDF としていましたが、 HTML (.html) でダウンロードし、manabaで提出してください
- PDF出力がノートブック大きい場合にエラーに出るための措置です -->


### 4.テーブルの読み込みで、headを実行してTSVかCSVか確かめるとありますが、headを実行してもいろいろ文字が出てきてどこを見ればいいかわかりません…

簡易的には、

- コンマで区切られていなければ CSV ではない
- 一方で、半角スペースではなくタブっぽい間の空き方だったら、TSV

あとは例えば、 `awk` というコマンドを使う方が確実かもしれません

```bash
# １行目にタブが含まれていたら１行目が出力される → TSV
$ awk 'NR==1 && /\t/{print}' data/GSE59831_processed_data_FPKM.txt

# １行目にコンマが含まれていたら１行目が出力される → CSV
$awk 'NR==1 && /,/{print}' data/GSE59831_processed_data_FPKM.txt
```

### `!is.na()` の話

- JOIN で NA などの欠損値が出ることがあります
- 欠損値が邪魔な場合に除くには、まずどれが欠損値かを調べる必要があります
- `is.na()` は欠損値であれば TRUE、そうでなければ FALSEを返します
- `!` がつくと TRUE/FALSE を逆転させます。
  - `! (WT1>100)` は `(WT1<=100)` と同じ意味です
- なので、 `!is.na(列名)` は ある列の値が欠損値 （NA） **でない** 行ならばTRUE、 NAならばFALSEを返します

```R
# human が NA でないの行だけにする
fpkm_epi_tumor_human %<>% filter(!is.na(human))

# human が NA でないの行だけにする (上と同じ意味)
fpkm_epi_tumor_human %<>% filter(! is.na(human))
```

### `library(magrittr)`, `%<>%` の話

- `magrittr` パッケージが使える
- 例えば `%<>%` が使える。これはパイプの結果を戻して代入すること

```R
df1_selected <- select(df1, mice_gene_symbol, WT1)

# 以下の３つは同じ意味
df1_selected %<>% fitler(WT1 > 100)

df1_selected %<>% 
    fitler(WT1 > 100)

df1_selected %>%
    fitler(WT1 > 100) -> df1_selected
```

### バックスラッシュ ( ` ) の話

・Rでは文字列を " (ダブルクオート） もしくは ' （シングルクオート）で囲みます
・一方、tidyverse では列名を " や ' で囲まずに、そのまま書きます
・ところが、列名に半角スペースやカッコが含まれているとうまくいかない。その場合ににはバッククオート（`）で列名を囲むと「そのままの列名」としてRに解釈してもらえる

```R
# この例では  log2(fold_change)  をバッククオートで囲んでいる
deg_macrophage %<>% select(gene_id, value_1, value_2, `log2(fold_change)`, p_value, q_value)

# 注意：バッククオートを外すとうまくいかなくなる
deg_macrophage %<>% select(gene_id, value_1, value_2, log2(fold_change), p_value, q_value)
```

### `%in%` について

- `%in%` は、あるベクトルの要素が別のベクトルの要素に含まれているかを返す演算子です
- `a %in% b` で、aとbがそれぞれベクトルの時、aの各要素が b に含まれるかどうかを（aの長さの分だけ） TRUEもしくはFALSEで返します

```R
a <- c("A", "W", "Z") 

b <- c("A", "B", "C", "X", "Y", "Z")

# a の "A", "Z" は b に含まれるが、"W" は含まれないので、
# 順に TRUE FALSE TRUE が出力される
a %in% b
```

```R
# `From %in% deg_macrophage_tumor_human$human` は
# From の各要素が deg_macrophage_tumor_human$human に含まれるなら TRUE、 
# そうでないなら FALSE を返す
dflr %>% 
    mutate(ligand_up_in_tumor_macrophage = From %in% deg_macrophage_tumor_human$human) 
```


### Rに組み込みの作図関数について

#### ヒストグラムを描く `hist()`

- `hist()` は第一引数で数値の列を与えると、そのヒストグラムを描きます

#### プロットを描く `plot()`

- `plot()` は様々なプロットを描ける関数です
- 例えば、 `plot(x, y)` と x と y が同じ長さの数値列の場合、散布図を描くことができます

### `filter()` でコンマ（`,`）で繋ぐのは

- `&` でつないだのと同じ意味になります
- 以下の２つは同じ意味です

```R
filter(`log2(fold_change)` > log2(1.5) & q_value < 0.1) 
```

```R
filter(`log2(fold_change)` > log2(1.5), q_value < 0.1) 
```
