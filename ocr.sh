#!/bin/env bash
# Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip
# consult the https://blog.csdn.net/weixin_39949673/article/details/111116693

#you can only scan one character at a time
SCR="/tmp/临时文件/screenshot"
DATA=$(date "+%Y-%m-%d-%H:%M:%S")

####take a shot what you wana to OCR to text
# 截图文件名
picture="$SCR/ocr-$DATA.png"
# 执行截图命令
gnome-screenshot -a -f "$picture"
# 将宽度和高度信息添加到文件名中
new_picture="$SCR/ocr-$DATA-$(identify -format "%wx%h" "$picture").png"
mv "$picture" "$new_picture"
# echo "$new_picture"

####increase the png
mogrify -modulate 100,0 -resize 400% "$new_picture"
#should increase detection rate

# 需要删除空白换行请使用此语句 并注释上一句（行首加#!
result=$(
    tesseract -l eng+chi_sim "$new_picture" stdout |
        # 需要删除空白换行请使用此语句，不然注释掉
        sed '$d;s/ //g'
)

# 输出到剪贴板
echo -n "$result" | xclip -selection clipboard

#弹窗提示OCR结束
notify-send "$result"
exit
