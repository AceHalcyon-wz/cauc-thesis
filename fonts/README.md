# 字体文件

本目录包含模板所需的中文字体和英文字体文件，用于确保不同操作系统下排版效果一致。

## 字体列表

| 文件名 | 字体名称 | 用途 |
|--------|---------|------|
| simsun.ttf | 宋体 | 正文默认字体 |
| simhei.ttf | 黑体 | 标题、页眉 |
| kaiti.ttf | 楷体 | 摘要关键词标签 |
| lisu.ttf | 隶书 | 封面标题 |
| times.ttf | Times New Roman | 英文正文 |
| timesbd.ttf | Times New Roman Bold | 英文粗体 |
| timesi.ttf | Times New Roman Italic | 英文斜体 |
| timesbi.ttf | Times New Roman Bold Italic | 英文粗斜体 |
| simfang.ttf | 仿宋 | 代码/等宽字体（可选，缺失时回退至宋体） |
| sRGB_IEC61966-2-1_black_scaled.icc | sRGB ICC 色彩配置文件 | PDF/A 模式色彩管理 |

## Overleaf 使用

上传字体文件至 Overleaf 时需注意：

- 文件名必须使用**小写**（如 `simsun.ttf`，而非 `SimSun.ttf`）
- Overleaf 文件系统区分大小写，文件名不匹配会导致字体加载失败
- 请确保本目录中的所有字体文件完整上传

## 字体回退

若 `fonts/` 目录缺失或字体文件不完整，模板会自动回退至系统字体：

- Windows：SimSun、SimHei、KaiTi、LiSu、Times New Roman
- macOS：需手动安装对应中文字体
- Linux：需安装 `fonts-wqy-microhei` 或其他中文字体包

回退时编译日志中会出现警告信息。
