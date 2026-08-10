#!/bin/bash

# gecoosac 官方源 lwb1978/gecoosac-core 已删除，改用镜像 hxlls/gecoosac-core（二进制哈希一致）
#sed -i 's#lwb1978/gecoosac-core#hxlls/gecoosac-core#g' feeds/gecoosac/gecoosac/Makefile

# # ipq60xx factory.bin 内核填充 12MiB→6MiB，适配 0:HLOS 为 6MiB 的设备（否则 U-Boot 刷机工具拒绝）
# sed -i 's/pad-to 12288k/pad-to 6144k/' target/linux/qualcommax/image/ipq60xx.mk

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# 设置空密码
sed -i '/s\/root::0:0:99999:7:::/s/^/##/' package/lean/default-settings/files/zzz-default-settings
sed -i '/s\/root:::0:99999:7:::/s/^/##/' package/lean/default-settings/files/zzz-default-settings


sed -i '/exit 0/i \
# 设置默认主题为 design\n\
uci set luci.main.mediaurlbase="\/luci-static\/design"\n\
# 设置默认语言为中文简体\n\
uci set luci.main.lang="zh_cn"\n\
# 设置主机名\n\
uci set system.@system[0].hostname="DMWRT"\n\
# 设置默认 IP 地址\n\
uci set network.lan.ipaddr="192.168.2.1"\n\
uci commit\n\
' package/lean/default-settings/files/zzz-default-settings
