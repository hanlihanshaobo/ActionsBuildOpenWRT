#!/bin/bash

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# ssr-plus
sed -i '$a src-git helloworld https://github.com/fw876/helloworld.git' ./feeds.conf.default
# cupsd
sed -i '$a src-git cups https://github.com/sirpdboy/luci-app-cupsd.git' ./feeds.conf.default
# 集客AC
sed -i '$a src-git gecoosac https://github.com/lwb1978/openwrt-gecoosac.git' ./feeds.conf.default
# 应用过滤
sed -i '$a src-git OpenAppFilter https://github.com/destan19/OpenAppFilter.git' ./feeds.conf.default
# openclash
sed -i '$a src-git openclash https://github.com/vernesong/OpenClash.git' ./feeds.conf.default
# luci
sed -i '$a src-git luci https://github.com/coolsnowwolf/luci' ./feeds.conf.default
# 注释luci
sed -i '3 s/^/#/' ./feeds.conf.default
