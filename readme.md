# 代码说明

---

## 说明

本C语言词法分析器借助flex完成，要在Linux环境下进行编译运行，且需安装flex和clang。

我在完成该词法分析器时的环境为：

* Ubuntu 19.10
* flex 2.6.4
* clang 9.0.0-2

理论上讲只要是Unix Like的系统都可以使用，甚至于Windows 10 + WSL的环境亦可，因时间有限，没有做更多的测试。

至于编译器不一定必须使用clang，任何一个C++编译器都可以胜任，只是这里我习惯与使用clang。

实现的C语言词法分析器可以识别[C11](https://zh.cppreference.com/w/c/keyword)源代码。

## 编译

为了编译方便，我写了一个[shell程序](./run.sh)来辅助编译，可以在命令行中执行该脚本进行编译。

需要注意的是，如果使用的编译器不是clang，请修改脚本中对应部分的代码。

首次运行前请给到权限：

```shell
chmod +x ./run.sh
```

运行脚本进行编译

```shell
./run.sh
```

如果没有任何错误提示，则编译成功，将会在目录中生成`lex.out`文件。

## 运行

可以直接运行`lex.out`进行使用，根据提示选择详细信息输出或者简略信息输出：

```shell
./lex.out
```

推荐使用重定向文件进行输入输出，事实上，目录中就给出了一个用来测试的输入文件`test.c`.

需要注意的是，输入文件应为以下两种格式之一：

```C
/*detail*/
#include <stdio.h>
...
```

```C
/*breif*/
#include <stdio.h>
...
```

运行下列任一命令进行使用：

```shell
./run.sh < test.c > out.txt
```

```shell
./run.sh < test.c
```

## 声明

本程序代码作者为陈留阳，在2020年04月23日完成编写。

仓库地址为[https://github.com/cliuyang/C-language-lexical-analyzer](https://github.com/cliuyang/C-language-lexical-analyzer)

遵循[MIT](./LICENSE)许可协议。
