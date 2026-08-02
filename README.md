# ActionsBuildOpenWRT

使用 GitHub Actions 自动编译 OpenWrt 固件。

## 支持的设备

| 工作流 | 说明 |
| --- | --- |
| `build-360t7.yml` | 360 T7 |
| `build-arm64v8.yml` | ARMv8 通用 |
| `build-r2s.yml` | NanoPi R2S |
| `build-rac2v1k.yml` | 京东云 RAC2V1K |
| `build-x86_64.yml` | x86_64 通用 |

## 功能特性

- 自动检测上游 [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede) 源码更新并触发编译（`update-checker.yml`）
- 内置自定义 feeds：ssr-plus (helloworld)、cupsd、集客 AC、应用过滤、OpenClash、Luci
- 默认设置：主机名 `DMWRT`、默认 IP `192.168.2.1`、中文简体、design 主题、空密码

## 使用方法

1. Fork 本仓库
2. 在 `Actions` 页面选择对应的构建工作流，点击 `Run workflow` 手动触发，或等待自动更新检测
3. 构建完成后固件会自动上传到 GitHub Release（保留最新 3 个）

> 注意：自动触发构建需要配置 `ACTIONS_TRIGGER_PAT` secrets（仓库访问令牌）。
