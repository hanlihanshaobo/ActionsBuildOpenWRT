### 🚀 **固件构建完成通知**

#### 📦 **设备信息**
| 项目       | 内容         |
|------------|--------------|
| **设备型号** | \`${DEVICE_NAME}\` |
| **构建时间** | ${TIME_NOW}  |
| **访问IP**   | 192.168.2.1  |
| **访问密码** | 无           |

#### 🔗 **下载链接**

##### **WebDAV 目录**
[点击进入 WebDAV 下载目录](${CLEAN_URL})

##### **Releases 目录**
[点击进入 Releases 下载目录](https://github.com/${{ github.repository }}/releases/download/${{ steps.tag.outputs.release_tag }}/${{ env.DEVICE_NAME }}_${{ env.FILE_DATE }}.bin)

#### ✅ **上传完成**
固件已成功上传至 WebDAV 和 Releases，您可以直接点击链接下载使用。

---

⚡ **构建状态：** [成功]  
🕒 **构建时间：** ${TIME_NOW} (北京时间)  
🔒 **安全上传：** 已加密上传至 WebDAV 和 Releases
