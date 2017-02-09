# Layers 介绍

这个目录用来存放的 Layers 或 topics  

## Layer 与 Topic

Topic 存在在 `layer-vim/layers/` 下, 以 `+` 为前缀  
layer 存放在 `layer-vim/layers/` 下 或 `layer-vim/layers/${topic}/` 下  

### Layer 

Layer 是一个概念, 主要是为了聚合, 体现一种职能, 你可以想像一下计算机网络中应用层, 传输层的概念  
Vim 的配置本身就像千层糕一样, 可以进行叠加, 一层一层的, 感觉还是蛮形象的  

`layer-vim` 中的一个 layer 是针对某方面的 vim 插件以及相关配置,键绑定的集合  
具体可以体现为一个目录. 并包含下面几个文件:  

| Layer Component | Description | 加载 |
| --------------- | ----------- | -------- |
| README.md | 当前 layer 的介绍 | - |
| packgaes.vim | 当前 layer 的所需的一些插件 | layer-vim 自动加载 |
| config.vim | 支持当前 layer 插件的配置 | layer-vim 自动加载 |
| keybindings.vim | 当前 layer 键绑定 | 需要在 `config.vim` 中手动引入<br>`source ./keybindings.vim`|


### Topic

一个 Topic 就是一系列 Layer 的集合, 即一个包含多个 Layer 的目录  
比如处理不同编程语言的 Layer 可以放在 `+lang` 的目录下  

Topic 的命名必须以 `+` 为前缀, 否则被认为一个 layer  

## 已有 layers

待添加...
