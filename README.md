# layer-vim
An elegant solution to organize vim plugins and resources  

	 _                                 _
	| | __ _ _   _  ___ _ __    __   _(_)_ __ ___
	| |/ _` | | | |/ _ \ '__|___\ \ / / | '_ ` _ \
	| | (_| | |_| |  __/ | |_____\ V /| | | | | | |
	|_|\__,_|\__, |\___|_|        \_/ |_|_| |_| |_|
			 |___/

## 快速安装

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/MwumLi/layer-vim/master/install.sh)"
    # 或
    sh -c "$(wget -qO- https://raw.githubusercontent.com/MwumLi/layer-vim/master/install.sh)"

## 手动安装和更新

1. 克隆到本地: `git clone git@github.com:MwumLi/layer-vim.git ~/.layer-vim`  
2. 建立软链接: `ln -sf ~/.layer-vim/init.vim ~/.vimrc`
3. 建立用户定制文件: `cp ~/.layer-vim/template/layervim.vim ~/.layervim`  
4. 建立项目 vim 配置文件(如果你的项目需要定制的不同的格式和配置):  

        cp ~/.layer-vim/template/project-layervim.vim yourProjectRoot/.layervim

## 引入外部 layer 仓库

加载外部 layer 仓库，配置环境变量 `LAYERVIM_LAYERS_PATH`:  

	export LAYERVIM_LAYERS_PATH=$HOME/.vim/layers

自动安装外部 layer 仓库, 配置环境变量 `LAYERVIM_LAYERS_REPO_URI`, 比如:  

	export LAYERVIM_LAYERS_REPO_URI='https://github.com/MwumLi/ifmicro-layers.git'

## 介绍

layer-vim 是一套优雅的的 vim 配置方案, 整个架构基于 Layer 的概念  
所谓优雅, 可以理解为简约而美观, 并且易于扩展  

是一套优雅的组织 vim 插件和资源的解决方案  
如果你时常感觉 vim 配置杂乱无章, 那么你值得拥有 layer-vim  

因为我本意是打造一个以 Layer 为基础的 vim 配置架子, 让大家可以良好的组织自己的 vim 配置,并不想提供任何 vim 配置  

但是为了做个示例, 我特意增加了一个 Topic : `+layervim`, 用来展示一个 Topic 以及 Layer 的编写  
这份配置也会构造一个简单,有效的 vim 的配置  

## 用户配置文件

用户配置文件就是 `~/.layervim`,一般情况下安装完毕会自己产生, 或者你可以 copy `~/.layer-vim/template/layervim.vim`:  

    UserLayers() 函数用来启用已有 layer, 禁用部分插件
    UserInit() 函数是插件快捷键前缀的定义, `<Leader>` 和 `<LocalLeader>` 的定义
    UserConfig() 函数是vim 的选项配置

## 项目配置文件

1. 在 `~/.layervim` 的 `g:layervim_project_root` 添加你的项目根目录的路径  
2. 项目配置文件就是项目根目录下的 `.layervim`,可以从 `~/.layer-vim/template/project-layervim.vim`复制  

        ProjectLayers() 函数用来启用已有 layer, 禁用部分插件
        ProjectConfig() 函数用来设置该项目下打开 vim 的选项配置

## Layer 和 Topic

layer-vim 的基础是 Layer, layer 这个概念并没有什么高深的东西, 不过是为了让你的 vim 插件及配置井然有序, 便于管理和修改而已  

每一个 layer 可以是一种功能处理的集合, 在 layer-vim 中体现为 `~/.layer-vim/layers/` 下的一个非以 `+` 开头的文件夹或者 topic 文件夹下的子文件夹(topic 就是 `~/.layer-vim /layers/` 下的一个以 `+` 开头的文件夹)  
一个 layer 文件夹下包含三个文件:  

| Layer Component | Description |
| --------------- | ----------- |
| README.md | 当前 layer 的介绍 |
| packages.vim |  支持该 layer 所需的一些插件 |
| config.vim | 当前 layer 的配置信息(包括插件的配置选项)|

在 layer 的基础, 又提出 topic 的概念,即主题, 也是类似, 是更进一步的分类, 比如 `+lang/` 可以包含
各种编程语言的处理 layer  
topic 是 `~/.layer-vim/layers/` 下的以 `+` 开头的文件夹, 包含多个 layer  

### 启用已有 layer

在 layer-vim 的用户配置文件 `~/.layervim` 的 `UserLayers()` 里启用 Layer  
比如有 `~/.layer-vim/layers/better-defaults`, 则在 `UserLayers()` 下添加:  

    Layer 'better-defaults'

比如有 `~/.layer-vim/layers/+layer-vim/basic`, 这是主题下有个层, 则在 `UserLayers()` 下添加:  

    Layer '+layer-vim/basic'


> 不存在的 layer 会被忽略, 所以不用担心添加了不存在的 layer

### 禁用部分插件

和启用 layer 一样, 在 `UserLayers()` 下添加:  

    Exclude 'vim-airline/vim-airline'

那么就会禁用插件 `vim-airline/vim-airline`  

### 插件安装,卸载,升级

layer-vim 底层是对  vim-plug 命令的封装, 因此 vim-plug 的命令都可以使用, 具体见: [vim-plug][vim-plug]  

还有封装的一些命令:  

    # 查看已经启用的 Layer
    :LayerStatus

    # 安装已经增强的插件, 和 PlugInstall 一样
    :LayerInstall

    # 清理禁用的插件
    :LayerClean

## Todo

- [x] support layer: add Layer in `~/.layer-vim`  
- [x] support topic: add topic in `~/.layer-vim/layers`  
- [x] support project configuration: `cp ~/.layer-vim/template/project-layervim.vim projectRoot/.layervim`  
- [X] add basic layer  
- [X] support add the whole topic: `Topic "+layervim"`  
- [X] support external layer: You can maintain your own layer repository  


## 致谢

下面这些项目都使我受益, 对此表示感谢  

* [liuchengxu/space-vim][liuchengxu/space-vim]  
  我从此项目了解 Layer , 感觉非常惊喜, space-vim 提供一套 Layer 的方案以及众多 [Layers][space-vim-layer], layer-vim 就是从此项目提取并进行改进, 因此 layer 结构和 layer-vim 一样, 你可以从这里获取你想要的层或者给你构造自己的 layer 提供灵感  

* [vim-plug][vim-plug]  
  Layer 的核心实现是基于 vim-plug 之上的  

* [spf13-vim](https://github.com/spf13/spf13-vim)  
   一个星级很高的 vim 配置,之前我也是根据此配置构建自己的 vim 配置, 直到知道了 layer  

* [spacemacs]: https://github.com/syl20bnr/spacemacs  
  Emacs 基于 Layer 的配置方案, 并包括众多优秀的 Emacs 配置  

* [使用脚本编写 Vim 编辑器，第 1 部分: 变量、值和表达式]: http://www.ibm.com/developerworks/cn/linux/l-vim-script-1/  

[liuchengxu/space-vim]:  https://github.com/liuchengxu/space-vim
[space-vim-layer]: https://github.com/liuchengxu/space-vim/tree/master/layers
[spacemacs]: https://github.com/syl20bnr/spacemacs
[vim-plug]:https://github.com/junegunn/vim-plug
