#!/bin/sh
#
# 使い方：./ScreenShotResize.command hogehoge.png
# (pngを一括でリサイズする場合)
# $ ls *.png | xargs -p ./ScreenShotResize.command
#
# 前提条件：実行環境はMac OSX
# 説明：iOS iTunes Connect用スクリーンショットの一括リサイズのシェルスクリプト
# 元画像は、iPhone6で750*1334あれば大丈夫

# カレントディレクトリ変更
cd `dirname $0`

# 出力ディレクトリの生成
outdir="output"
mkdir -p $outdir

# 元のファイル *.png
SRC_FILES=$@
for SRC_FILE in ${SRC_FILES}
do
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

  # 5.5-inch size
  size="2208 1242"
  outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
  sips -z ${size} ${SRC_FILE} --out ${outfile}

  # 4.7-inch size
  size="1334 750"
  outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
  sips -z ${size} ${SRC_FILE} --out ${outfile}

  # 4.0-inch size
  size="1096 640"
  outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
  sips -z ${size} ${SRC_FILE} --out ${outfile}

  # 3.5-inch size
  size="920 640"
  outfile="${outdir}/${BASE_NAME}_${size// /x}.${SUFFIX}"
  sips -z ${size} ${SRC_FILE} --out ${outfile}

done

