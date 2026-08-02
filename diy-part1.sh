#!/bin/bash

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# ssr-plus
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git' ./feeds.conf.default
# cupsd
sed -i '$a src-git cups https://github.com/sirpdboy/luci-app-cupsd.git' ./feeds.conf.default
# 集客AC
sed -i '$a src-git gecoosac https://github.com/bleach1991/openwrt-gecoosac.git' ./feeds.conf.default
# 应用过滤
sed -i '$a src-git OpenAppFilter https://github.com/destan19/OpenAppFilter.git' ./feeds.conf.default
# USB移动数据网络
sed -i '$a src-git usbmodem https://github.com/1391959853/luci-app-usbmodem.git' ./feeds.conf.default
