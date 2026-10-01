# my-nvim-config

---

## 插件

| 插件 | 功能 | 版本 | 更新时间 |
| --- | --- | --- | --- |
| LuaSnip | 代码片段引擎 | 0abc8f39 | 2026-05-19 |
| alpha-nvim | 启动首页（dashboard） | 4ba26e41 | 2026-08-24 |
| bufferline.nvim | 顶部 buffer 标签栏 | v4.9.1 | 2025-01-14 |
| cmp-buffer | 补全源：当前缓冲区里的单词 | b74fab36 | 2025-04-01 |
| cmp-cmdline | 补全源：命令行 | d126061b | 2025-05-18 |
| cmp-nvim-lsp | 补全源：LSP | cbc7b02b | 2025-11-13 |
| cmp-path | 补全源：文件路径 | c6424870 | 2025-07-30 |
| cmp_luasnip | 补全源：代码片段 | 98d9cb5c | 2024-11-04 |
| colorful-winsep.nvim | 窗口分隔线着色 | 6134b5cd | 2026-04-26 |
| conform.nvim | 代码格式化（clang-format / stylua / prettier / shfmt） | 016802de | 2026-08-11 |
| diffview.nvim | git diff 查看器 | 4516612f | 2024-06-13 |
| friendly-snippets | 各语言片段集合（给 LuaSnip 用） | b4d01b0f | 2026-09-10 |
| git-blame.nvim | 行内 git blame | 5c536e2d | 2025-11-05 |
| gitsigns.nvim | 侧栏 git 标记与 hunk 操作 | 070a5d7b | 2026-09-22 |
| indent-blankline.nvim | 缩进参考线 | v3.10.1 | 2026-09-04 |
| kanagawa.nvim | 配色（切换用） | bb85e4bf | 2026-05-10 |
| lazy.nvim | 插件管理器 | 306a0552 | 2025-12-17 |
| lualine.nvim | 状态栏 | 221ce6b2 | 2026-05-31 |
| mason-tool-installer.nvim | 按列表自动安装 mason 工具 | 443f1ef8 | 2026-01-22 |
| mason.nvim | LSP / 格式化工具的包管理器 | 2a6940af | 2026-06-11 |
| neo-tree.nvim | 文件树侧栏 | 020e50ff | 2026-09-27 |
| neogen | 生成 doxygen 注释框架 | 23e7e9f8 | 2026-01-10 |
| neoscroll.nvim | 平滑滚动 | c8d29979 | 2025-12-31 |
| nightfox.nvim | 配色（切换用） | 4dacd3f0 | 2026-07-04 |
| noice.nvim | 命令行 / 消息 / 弹窗 UI | 7bfd9424 | 2025-11-03 |
| nui.nvim | UI 组件库（neo-tree 依赖） | 10fc3618 | 2026-08-21 |
| nvim-autopairs | 括号 / 引号自动配对 | 430522f9 | 2026-08-23 |
| nvim-cmp | 补全引擎 | 2ffe79f1 | 2026-07-10 |
| nvim-colorizer.lua | 颜色值（#RRGGBB）着色 | 72a05f62 | 2026-07-14 |
| nvim-lspconfig | LSP 服务器配置 | 3e8d598d | 2026-09-30 |
| nvim-notify | 通知弹窗 | 8701bece | 2025-09-06 |
| nvim-treesitter | 语法树高亮 / 缩进 / 折叠，parser 管理 | 910fdf6f | 2026-09-30 |
| nvim-web-devicons | 文件类型图标 | 58447c1f | 2026-09-21 |
| plenary.nvim | Lua 工具库（telescope 依赖） | 74b06c6c | 2026-04-10 |
| rainbow-delimiters.nvim | 括号彩虹着色 | 3a0fc08d | 2026-09-04 |
| render-markdown.nvim | markdown 渲染显示 | v8.14.0 | 2026-09-14 |
| smear-cursor.nvim | 光标拖尾动画 | 9f42dd38 | 2026-09-30 |
| telescope-fzf-native.nvim | telescope 的 fzf 排序加速 | b25b749b | 2026-05-06 |
| telescope.nvim | 模糊查找：文件 / 内容 / 符号 / 缓冲区（版本钉在 tag 0.1.8） | 0.1.8 | 2024-05-24 |
| todo-comments.nvim | TODO / FIXME 高亮与检索 | 31e3c38c | 2025-11-10 |
| toggleterm.nvim | 内置终端 | 9a88eae8 | 2025-03-09 |
| tokyonight.nvim | 配色（当前主题，day） | cdc07ac7 | 2026-03-24 |
| which-key.nvim | 前缀键提示 | 3aab2147 | 2025-10-28 |

## Tools

| 脚本 | 用途 | 用法 |
| --- | --- | --- |
| `tools/format-lua.sh` | 用 stylua 格式化 lua/ 下所有配置 | `./tools/format-lua.sh` |
| `tools/install-deps.sh` | 装配置需要的系统包（apt，只装缺的） | `./tools/install-deps.sh [--check]` |
| `tools/upgrade_kitty.sh` | 检查最新稳定版并升级 kitty，目标目录 `~/.local/kitty.app` | `./tools/upgrade_kitty.sh` |
| `tools/upgrade_nvim.sh` | 检查最新稳定版并升级 nvim，目标目录 `/opt/nvim-linux-x86_64` | `./tools/upgrade_nvim.sh` |
