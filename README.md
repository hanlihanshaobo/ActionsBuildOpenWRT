# ActionsBuildOpenWRT

使用 GitHub Actions 自动编译 OpenWrt 固件。

## 配置文件与目标设备

| 配置文件 | 实际目标设备 |
| --- | --- |
| `R2S.config` | NanoPi R2S (rockchip/armv8) |
| `jdc-ax1800pro.config` | 京东云 AX1800 Pro (qualcommax/ipq60xx/jdcloud_re-ss-01) |

## 构建工作流

| 工作流 | 用途 |
| --- | --- |
| `build-r2s.yml` | 构建 NanoPi R2S 固件（使用 `R2S.config`） |
| `build-ax1800.yml` | 构建京东云 AX1800 Pro 固件（使用 `jdc-ax1800pro.config`） |
| `update-checker.yml` | 每周五检查上游 [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede) 更新，有更新时自动触发上述构建 |

## 功能特性

- 自动检测上游 [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede) 源码更新并触发编译（`update-checker.yml`）
- 内置自定义 feeds：ssr-plus (helloworld)、cupsd、集客 AC、应用过滤；OpenClash 随 lede 自带的 luci feed 提供
- 默认设置：主机名 `DMWRT`、默认 IP `192.168.2.1`、中文简体、design 主题、空密码

## 使用方法

1. Fork 本仓库
2. 在 `Actions` 页面选择对应的构建工作流，点击 `Run workflow` 手动触发，或等待自动更新检测
3. 构建完成后固件会自动上传到 GitHub Release（保留最新 3 个）

> 注意：
> - 自动更新检测使用默认 `GITHUB_TOKEN` 触发，无需额外配置 secrets。
> - 已移除 360t7 / arm64v8 / rac2v1k / x86_64 等引用缺失配置文件的工作流，如需构建对应设备需先补充对应的 `.config` 文件并新建工作流。
