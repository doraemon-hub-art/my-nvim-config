《简单的VIM上手》
可以先输出一期简单的使用体验，我现在已经使用一周多了， 逐渐的慢慢上手了。
先掌握基本的按键，然后根据需要去学习更多的键位操作。

======================= 补充

- 主题: https://vimcolorschemes.com/i/trending/b.dark

======================= VIM
Ctrl + h j k l 切换左右侧缓冲区
leader + ff 快速打开文件
- 注意 tab 选择时多选，需要Ctrl + j k 上下移动

leader + fw 全局搜索文件中的内容
leader + b 会提示 缓冲区窗口相关

wq/q + a 都是将命令作用与当前打开的所有窗口


===================== 光标移动
- 光标移动，hjkl用于微调，效率太低；
	- 按单词跳转；
		- w 向后跳转到下一个单词开头；
		- b 向前跳转到上一个单词开头；
		- e 向后跳转到下一个单词末尾；
	- 翻页跳转；
		- Ctrl + d 向下翻半屏；
		- Ctrl + u 向上翻半屏； 
	- 绝对位置跳转；
		- Ctrl + o 上一个位置；
		- Ctrl + i 下一个位置；

====================== 代码相关

- leader + / 注释当前行；
	- 选中后同理；
- doxygen插件；
	- leader d + f 文件说明头;
	- leader d + g 函数注释说明;
- leader l + a， 根据函数声明生成函数定义；	

- CMAKE 插件,正常模式下:
	- CMakeGenerate 相当于cmake ..
	- CMakeBuild 相当于 make -j14
	- copen 编译信息；
- C++ LSP 依赖:
	- cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ...
	
- 函数定义实现跳转，正常模式下 g d；

- 文本替换，在变量/函数名上 leader l + r；
	- 文本框中输入新名字 + 回车即可完成替换；

- 显示 Outline / Symbols 面板:
	- leader + l S;
	- Ctrl + k 在面板上移动，对应的代码窗口可以直接调转到对应为止；

====================== 文字操作
v模式 ---> h j k l ---> y 复制
v模式 ---> x 剪贴
v模式 ---> p 粘贴
命令模式下 ---> ggdG 清空所有文件

====================== 窗口操作
- Ctrl + w v 当前窗口查分到右侧
  - leader + ff 搜到文件后 Ctrl + v 同样右侧分屏打开
- Ctrl + 方向键，调整当前焦点所在的窗口大小

在已打开的缓冲区中指定切换
- leader + fb 加 Ctrl + j/k 

在一打开的缓冲区中滚动切换
- ] + b 

- 分屏和聚焦某一分屏，聚集之后切不回来；
  - Ctrl + w, o;
====================== 终端
- leader + tf 浮动窗口打开，退出编辑模式后重复按键退出；
- leader + tv 右侧垂直打开， Ctrl + h j k l 可以切换回缓冲区；
	- Ctrl + / 加 Ctrl + n，终端退出编辑模式；
- 使用 toggleterm.nvim 插件；
	- F7 可以快速隐藏打开终端；

====================== 其他
Ctrl + page up/dow ubuntu terminal窗口切换
Ctrl + shift + n 新建一个独立的terminal

Leader + S l加载上一次的工作区

- leader + tt，性能监控；

- TODO
	- leader + s T ，查看 TODO 和 NOTE 标记的内容；
 
====================== 非核心
i 模式下，连续按两次 j 退出编辑模式
（可以找一下astro vim默认自带的一些设置都在哪	）

H 关闭文件目录树隐藏文件

- 快速切换主题：
	- leader + ft；

- :AstroReload 重新加载插件；

====================== 小操作
大写都用Shift实现，而不是大写键，比如查找的N n切换
大写锁定键切换为ESC
切换按键映射 gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"
还原 gsettings reset org.gnome.desktop.input-sources xkb-options


====================== 辅助工具
- 窗口项目多开 Tabby，用于开多个终端；	
- avante ai修改意见；
  - ct (Choose Theirs)：接收 AI 的修改（使用 AI 的代码）；
  - co (Choose Ours)：拒绝 AI 的修改（保留你原来的代码）；
  - cb (Choose Both)：两者都选（同时保留，通常用于合并）；
  - c0 (Choose None)：两者都不选；
