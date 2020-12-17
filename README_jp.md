# scopetopmove.vim #

このプラグインはC/C++のファイルを編集時にカーソルを関数先頭へ移動させるものです.<br>
デフォルトの [[ か ]] コマンドは ":help [[" or ":help ]]"で確認してください.<br>
ex) :help ]]
```sh
]] [count] sections forward or to the next '{' in the first column.
```

もし C/C++ のコーディング規約で以下の例を使用しているならデフォルト機能で補えます.<br>
```sh
void Function()
{
}
```
ただし,以下の用な別のコーディング規約の場合はサポートされません.<br>
```sh
void Function() {
}
```

## 注意 ##
このプラグインはデフォルトの [[ と ]] を上書きします.

## インストール ##
それぞれの".vim"ファイルをautoloadディレクトリとpluginディレクトにコピーします.

## 使用方法 ##
```sh
[[ か ]] をコマンドモード時に入力します.
```
