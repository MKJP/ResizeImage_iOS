#!/bin/sh
#
# 使い方：./IconResize.command hogehoge.png
# 前提条件：実行環境はMac OSX
# 説明：iOS アイコン専用の一括リサイズのシェルスクリプト
# 元画像は、iPhone6で1024*1024を前提とする

# カレントディレクトリ変更
cd `dirname $0`

# 出力ディレクトリの生成
outdir="output"
mkdir -p $outdir

# 元のファイル *.png
SRC_FILE=$1
echo "${SRC_FILE}"

if [ ! -f ${SRC_FILE} ]; then
 echo "${SRC_FILE}が見つかりません。"
 exit
else
  if [[ ${SRC_FILE} =~ ^(.+)\.(.+)$ ]]; then
    # システム固定で結果が次の変数に格納される
    echo ${BASH_REMATCH[0]}
    echo ${BASH_REMATCH[1]}
    echo ${BASH_REMATCH[2]}
  fi
fi

BASE_NAME=${BASH_REMATCH[1]}
SUFFIX=${BASH_REMATCH[2]}
#----------------------------------------------------------------------
# iTunes Artwork アイコン
#----------------------------------------------------------------------
#iTunesArtwork.png    : 512x512
size="512"
outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
sips -Z ${size} ${SRC_FILE} --out ${outfile}
#iTunesArtwork@2x.png : 1024x1024
size="1024"
outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
cp -f ${SRC_FILE} ${outfile}
#iTunesArtwork@3x.png : 1536x1536
# 省略

#----------------------------------------------------------------------
# アプリアイコン
#----------------------------------------------------------------------
# 次のファイルを一括生成したい
#Icon-29.png          : 29x29
#Icon-29@2x.png       : 58x58
#Icon-29@3x.png       : 87x87
#Icon-40.png          : 40x40
#Icon-40@2x.png       : 80x80
#Icon-40@3x.png       : 120x120
#Icon-50.png          : 50x50
#Icon-50@2x.png       : 100x100
#Icon-50@3x.png       : 150x150
#Icon-57.png          : 57x57
#Icon-57@2x.png       : 114x114
#Icon-57@3x.png       : 171x171
#Icon-60.png          : 60x60
#Icon-60@2x.png       : 120x120
#Icon-60@3x.png       : 180x180
#Icon-72.png          : 72x72
#Icon-72@2x.png       : 144x144
#Icon-72@3x.png       : 216x216
#Icon-76.png          : 76x76
#Icon-76@2x.png       : 152x152
#Icon-76@3x.png       : 228
#Icon-Small-50.png    : 50x50
#Icon-Small-50@2x.png : 100x100
#Icon-Small-50@3x.png : 150x150
#Icon-Small.png"      : 29x29
#Icon-Small@2x.png    : 58x58
#Icon-Small@3x.png    : 87x87
#Icon.png             : 57x57
#Icon@2x.png          : 114x114
#Icon@3x.png          : 171x171
#Icon-120.png         : 120x120
SIZES="29 58 87 40 80 120 50 100 150 57 114 171 60 120 180 72 144 216 76 152 228 167" 

for SIZE in ${SIZES}
do
  outfile="${outdir}/${BASE_NAME}_${SIZE// /x}.${SUFFIX}"
  sips -Z ${SIZE} ${SRC_FILE} --out ${outfile}
done

