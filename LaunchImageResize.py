# -*- coding: utf-8 -*-
# 使い方：python ./LaunchImageResize.py portrait hogehoge.png
# 前提条件：実行環境はMac OSX
# 説明：iOS 起動（スプラッシュ）（縦・横）画面専用の一括リサイズスクリプト
# 【注意】：元画像は、iPad Pro 12.9 inchで縦画面の場合、2048*2732、横画面の場合、2732*2048を前提とする

import argparse
import subprocess
import os

class LaunchImageResize(object):
    #----------------------------------------------------------------------
    # スプラッシュ画面
    #----------------------------------------------------------------------
    # 次のファイルを一括生成したい
    # 640 x 960   - 3.5 inch Retina
    # 640 x 1136  - 4.0 inch Retina
    # 750 x 1334  - 4.7 inch Retina
    # 1242 x 2208 - 5.5 inch Retina たて
    # 2208 x 1242 - 5.5 inch Retina よこ
    # 1125 x 2436 - iPhone X (5.8 inch Super Retina) たて
    # 2436 x 1125 - iPhone X (5.8 inch Super Retina) よこ
    # 1242 x 2688 - iPhone Xs Max (6.5 inch Super Retina) たて
    # 2688 x 1242 - iPhone Xs Max (6.5 inch Super Retina) よこ
    # 768 x 1024  - iPad 1x たて
    # 1536 x 2048 - iPad 汎用の 2x たて
    # 1668 x 2224 - iPad Pro 10.5 たて
    # 2048 x 2732 - iPad Pro 12.9 たて
    # 1024 x 768  - iPad 1x よこ
    # 2048 x 1536 - iPad 汎用の 2x よこ
    # 2224 x 1668 - iPad Pro 10.5 よこ
    # 2732 x 2048 - iPad Pro 12.9 よこ

    # Portrait sizes array [[width, height]]
    PORTRAIT_SIZES = [
        [640, 960],
        [640, 1136],
        [750, 1334],
        [1242, 2208],
        [1125, 2436],
        [1242, 2688],
        [768, 1024],
        [1536, 2048],
        [1668, 2224],
        [2048, 2732]
    ]

    # Landscape sizes array [[width, height]]
    LANDSCAPE_SIZES = [
        [2208, 1242],
        [2436, 1125],
        [2688, 1242],
        [1024, 768],
        [2048, 1536],
        [2224, 1668],
        [2732, 2048]
    ]

    def __init__(self, args):
        # Get argument parse options
        self.args = args
        # 出力ディレクトリの生成
        self.outdir = "output"
        subprocess.run(["mkdir", "-p", self.outdir])

    def checkfile(self):
        ret = False
        src_file = self.args.src_file
        isSrcFile = os.path.isfile(src_file) 
        if isSrcFile is False:
            print("{}が見つかりません！".format(src_file))            
        else:
            name, ext = os.path.splitext(os.path.basename(src_file))
            self.base_file_name = name
            self.base_file_ext = ext
            ret = True
        return ret

    def resize(self, sizes):
        for size in sizes:
            w = str(size[0])
            h = str(size[1])
            src_file = self.args.src_file
            outfile = "{}/{}_{}x{}{}".format(self.outdir, self.base_file_name, w, h, self.base_file_ext)
            print(outfile)
            # sips -z 960 640 iHaiku_app_icon_1024.png --out ./output/tmp.png
            subprocess.run(["sips", "-z", h, w, src_file, "--out", outfile])
    
    def portrait(self):
        print('--- Start Resize portrait ---')
        ret = self.checkfile()
        if ret is True:
            self.resize(self.PORTRAIT_SIZES)
        else:
            print("checkfile() error.")
        print('--- Finish Resize portrait ---')

    def landscape(self):
        print('--- Start Resize landscape ---')
        ret = self.checkfile()
        if ret is True:
            self.resize(self.LANDSCAPE_SIZES)
        else:
            print("checkfile() error.")
        print('--- Finish Resize landscape ---')

def run(args):
    try:
        clazz = LaunchImageResize(args)
        getattr(clazz, args.command)()
    except Exception as e:
        print(e)

if __name__ == '__main__':
        
    # Set parser
    parser = argparse.ArgumentParser(description='iOS 起動（スプラッシュ）（縦・横）画面専用の一括リサイズスクリプト。')
    # 主要コマンド
    command_list = ['portrait', 'landscape']
    command_help = 'portrait: 縦画面用にリサイズする'
    command_help += '| landscape: 横画面用にリサイズする'
    parser.add_argument('command', type=str, choices=command_list, help=command_help)
    parser.add_argument('src_file', type=str, help="【注意】：元画像は、iPad Pro 12.9 inchで縦画面の場合、2048*2732、横画面の場合、2732*2048を前提とする。")

    args = parser.parse_args()
    # Get start
    run(args)
