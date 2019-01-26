#!/bin/sh
# iOS用タブバーボタンなどの一括リサイズのシェルスクリプト

# カレントディレクトリ変更
cd `dirname $0`

# 出力ディレクトリの生成
outdir="output"
mkdir -p $outdir

# 元のファイル *.png
SRC_FILE=$1
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

size=22
outfile="${outdir}/${BASE_NAME}_${size}.${SUFFIX}"
sips -Z ${size} ${SRC_FILE} --out ${outfile}

size=44
outfile="${outdir}/${BASE_NAME}_${size}.${SUFFIX}"
sips -Z ${size} ${SRC_FILE} --out ${outfile}

size=66
outfile="${outdir}/${BASE_NAME}_${size}.${SUFFIX}"
sips -Z ${size} ${SRC_FILE} --out ${outfile}

