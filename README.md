# MaterialDesign

这是一款用于显示电脑硬件信息的监测模板，类似于电脑机箱副屏，可以实时显示硬件温度和使用率等等。主要用于在系统桌面上显示（类似于游戏加加的桌面监控功能），也可以在机箱副屏上显示（类似于Aida64监控副屏那样）。

![效果图][1]

项目地址：[Github][2]
下载地址：[MaterialDesign_v1.0.zip][3]

原皮肤是来自Aida64平台的Material Design系列模板
原作者链接∶[ThatManOnTheMoon][4]
现在移植到Ranimeter平台上来了，目前只做了一种配色样式。

那么这和Aida64的版本有什么区别呢？我为什么不直接用Aida64呢？

本质上没什么区别功能都差不多。主要是因为Aida64的很多传感器数据识别不到。比如显卡，显存温度转速什么的（我就遇到了，风扇转速识别不到）。所以本皮肤的硬件数据来源换成了HWiNFO，传感器数据相比Aida64更加全面，并且它还是免费的！而且在桌面显示这方面，Rainmeter相比Aida64更加灵活方便（你可以随意拖动窗口，修改大小，更改显示层级）。你完全可以把它当成一个桌面监控软件（比如只在桌面上显示），不用去额外购买一块机箱副屏。

系统硬件要求：
1. 台式电脑
这个模板只适用于台式电脑，笔记本不适用，因为笔记本主板和台式机主板不一样，很多传感器数据都是没有，如果你坚持要用，可以自已尝试一下（你会发现很多数据都没了，基本只剩温度和使用率）。另外就算是台式机主板，也不能太杂牌了，或者太老旧过时的主板。因为部分杂牌寨板或者老主板可能传感器数据都不准，甚至有的传感器也没有。不过只要是近几年装机的新电脑应该都可以获取到数据。

2. 独立显卡
因为模板设计之初就包含了独显数据，不适合用于核显，而且核显还没有GPU风扇数据，如果你还坚持要用，可以用CPU风扇数据替代占位一下。

3. Windows10及以上的操作系统
本皮肤仅限Windows10及以上的操作系统（win7、macos、linux 不适用）

## 安装教程
本次安装配置需要有一定的电脑基础，且配置过程非常麻烦。不过咱都折腾起来美化和监控副屏了，这点困难算什么，生命在于折腾嘛。

需要用到的软件（安装包内已整合好全部的所需软件）:

  - HWiNFO: https://www.hwinfo.com/
  - Rainmeter: https://www.rainmeter.net/

Rainmeter的安装过程全部选择默认选项即可，如果你有C盘焦虑也可以自己更改安装目录，另外注意开机启动选项不要关闭，如关闭后续就没有方法可以打开了。

![Rainmeter安装过程 1][5]
![Rainmeter安装过程 2][6]
![Rainmeter安装过程 3][7]
![Rainmeter安装过程 4][8]

Rainmeter安装完成后，桌面上会出现很多默认的皮肤，如果你喜欢也可以留在桌面上，如需关闭只要在皮肤上右键单击调出菜单选择关闭皮肤即可。

![关闭皮肤][9]

现在安装皮肤，找到解压包内的`.rmskin`文件双击打开，保持默认选项安装即可。安装完成后皮肤会自动显示在桌面上。

![安装皮肤][10]
![皮肤模板][11]

在皮肤上右键单击选择管理皮肤，或者在系统托盘图标中双击打开，都可以调出Rainmeter管理器。
你可以在这里加载、卸载、刷新、编辑皮肤，调整皮肤层级，透明度和其它选项。

![皮肤上右键单击选择管理皮肤][12]
![Rainmeter管理器][13]

目前皮肤是没有数据显示的，还需要去配置一下数据来源。现在先来安装HWiNFO，也是全程默认安装。

![HWiNFO安装过程 1][14]
![HWiNFO安装过程 2][15]
![HWiNFO安装过程 3][16]
![HWiNFO安装过程 4][17]
![HWiNFO安装过程 5][18]
![HWiNFO安装过程 6][19]
![HWiNFO安装过程 7][20]

到最后一项选择勾选“仅显示传感器”。先点击设置，进入设置面板，将左侧的启动相关选项勾选和图片中的一样，这里设置的是软件的开机启动，调整好选项后记得点击确定保存设置哦。

![勾选“仅显示传感器”][21]
![设置软件开机启动][22]

现在回到勾选“仅显示传感器”这里，点击开始打开传感器面板，或者点击系统托盘图标也可以打开传感器面板。点击右下角的配置传感器选项。

![回到勾选“仅显示传感器”][23]
![传感器面板-->配置传感器选项][24]

找到“HWiNFO小工具”页面，点击“启用向小工具报告”（一定要点启用，不然数据是读取不到的）。选中你需要的传感器数据，勾选“小工具的报告值”，右侧Index会出现一个ID值，记住这个ID值，后续需要在皮肤中进行配置。（这里只勾选了1个传感器数据作为演示，后续会告诉你有多少个数据需要勾选）

![HWiNFO小工具][25]
![启用向小工具报告][26]
![勾选传感器数据][27]

当你所有的数据勾选完成后，再点击确定以保存设置。

![保存设置][28]

现在回到Rainmeter管理器，选择需要配置的皮肤点击编辑。

![编辑皮肤][29]

这些代码在文件开头就可看到，在`[Variables]`节点下，只有以下这些代码才是可以修改的。

只需要把变量ID和HWiNFO小工具的ID绑定，就可以获取到硬件数据了。（后面会详细说明每种变量怎么修改）

![代码][30]

当你修改配置好变量后，记得在Rainmeter管理器中刷新或者重新加载皮肤，皮肤中的数据才会更新。

![刷新皮肤][31]

至此皮肤安装部分完成，接下来是皮肤配置教程。

## 配置教程

目前一共有6种配置项：

- 硬件名称
- 硬件数据ID
- 硬件上限值（例如温度，功耗上限）
- 盘符（例如C盘，D盘）
- 更新频率
- 缩放比例

### 硬件名称

以下是硬件名称的变量，只需修改成你自已的硬件名称即可，当然你也可以修改成触不可及的高端硬件以满足虚荣心。

```ini
; 硬件名称
CpuName=Intel Core i9-14900KS
GpuName=NVIDIA RTX 4090 
RamName=96GB DDR5 9900MHz
DiskName=SAMSUNG 990PRO 4T
MoboName=ROG Z790 EXTREME
NetName=Intel BE200 WiFi7
```

语法也很简单，只需修改等号右侧的字符就可以了

修改示例：

```ini
CpuName=AMD Ryzen 9 9950X3D
```

### 硬件数据ID

硬件数据ID在代码中的并不是按顺序书写的，所以请认准结尾为`Id`的变量名，这样的变量一共有16个，并且每个都需要配置（ID可以复用，比如两个变量共用同一个ID）

```ini
; CPU使用率ID
CpuUsageId=-1
; CPU温度
CpuTempId=-1
; CPU功率ID
CpuPowerId=-1
; CPU风扇转速ID
CpuFanRpmId=-1

; GPU使用率ID
GpuUsageId=-1
; GPU温度
GpuTempId=-1
; GPU功率ID
GpuPowerId=-1
; GPU风扇转速ID
GpuFanRpmId=-1

; 已用内存ID
MemoryUsedId=-1
; 可用内存ID
MemoryAvailableId=-1
; 内存使用率ID
MemoryLoadId=-1

; 硬盘温度ID
DiskTempId=-1

; 主板VRM温度ID
MoboVrmTempId=-1
; 机箱风扇转速ID
MoboCaseFanRpmId=-1

; 网络下行速率ID
NetDLRateId=-1
; 网络上行速率ID
NetUPRateId=-1
```

默认值ID是-1它不会显示任何数据，只需将默认值改成对应的ID值即可。

修改示例：
```ini
; CPU使用率ID
CpuUsageId=3
```

### 硬件上限值

硬件上限值同样也不按顺序书写，认准结尾是`Cap`的变量名。它的默认值可能太低或者太高，需要你根据自已的硬件情况来调整。

```ini
; CPU温度上限（单位：ºC）
CpuTempCap=100
; CPU风扇转速上限（单位： RPM）
CpuFanRpmCap=1500
; CPU功率上限（单位：W）
CpuPowerCap=150

; GPU温度上限（单位：ºC）
GpuTempCap=100
; GPU风扇转速上限（单位： RPM）
GpuFanRpmCap=3000
; GPU功率上限（单位：W）
GpuPowerCap=150

; 硬盘温度上限（单位：ºC）
DiskTempCap=100
```

只接受一个纯数字的值，不需要带单位。

修改示例：

```ini
; CPU温度上限（单位：ºC）
CpuTempCap=115
```

### 盘符

盘符配置项`DiskDrive`，允许设定一个或多少盘符。通过配置变量可以实现，只单独计算一个硬盘分区的空间，或者组合多个盘符的空间一起计算（这个组合功能就算硬盘被分成了好几个分区，也能计算出一块硬盘整体的空间）。

```ini
; 需要监测的硬盘盘符（可以组合多个盘符）
DiskDrive=C
```

修改示例：

它有两种语法情况：
- 只监测一个盘符空间

  ```ini
  DiskDrive=C
  ```

- 同时监测多个盘符（最多26个）
  
  ```ini
  DiskDrive=C,D,E,F
  ```

如需监测多个盘符，需要使用**英文逗号符(,)**来分割，结尾处不需要逗号。

### 更新频率

更新频率配置项`UpdateIntv`和`DiskUpdateIntv`，是用于控制数据的更新频率，更新频率越高，性能占用也就越多。默认更新频率的占用已经算是比较低的了，一般来说不需要修改。

```ini
; 更新频率 默认值：2秒
UpdateIntv=2
; 硬盘空间相关数据 更新频率 默认值：60秒
DiskUpdateIntv=60
```

如果你一定要调整更新频率，那么修改时注意以下几点：

- 建议更新频率的最小值不要低于1秒，频繁的更新数据会占用大量的系统资源，浪费性能造成系统卡顿。

- 如果修改了更新频率，则也需要调整HWiNFO的更新频率，并保持同步。因为HWiNFO的默认更新频率也是2秒，如果将`UpdateIntv`修改成1秒，那么每间隔1秒就会获取到重复的数据。你需要将HWiNFO更新频率设置成相同频率，才能实时的更新数据。相反如果是要调慢更新频率，并同时调慢HWiNFO的更新频率也会进一步降低系统资源的占用，避免性能浪费。

### 缩放比例

缩放比例配置项`ScaleFactor`是用于控制整个皮肤窗口等比例缩放的关键参数。

因为整个皮肤用的是矢量元素绘制的，理论上它可以无限大，你可以根据使用需要自由调整大小。

大小范围（ 1 ~ 无限）（可以有小数），并只接受一个纯数字的值

```ini
; 窗口大小缩放系数 （范围 1 ~ 无限）
ScaleFactor=1
```

修改示例：

```ini
ScaleFactor=1.2
```

  [1]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3770092562.png
  [2]: https://github.com/xiao-cheng-zi/MaterialDesign
  [3]: https://github.com/xiao-cheng-zi/MaterialDesign/releases/download/v1.0/MaterialDesign_v1.0.zip
  [4]: https://forums.aida64.com/profile/48674-thatmanonthemoon/
  [5]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1866730957.png
  [6]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1557877393.png
  [7]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/534932228.png
  [8]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/28836781.png
  [9]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1685707739.png
  [10]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2948421839.png
  [11]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2363795026.png
  [12]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1726987258.png
  [13]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2316680445.png
  [14]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1411933858.png
  [15]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3968159416.png
  [16]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/899610709.png
  [17]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2220887765.png
  [18]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3139008184.png
  [19]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2260140464.png
  [20]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/184794930.png
  [21]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2093293440.png
  [22]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3924551894.png
  [23]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1708547721.png
  [24]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3296763053.png
  [25]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/167974867.png
  [26]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2629946273.png
  [27]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2780117078.png
  [28]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/1859671146.png
  [29]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/2959788619.png
  [30]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/3240733456.png
  [31]: https://github.com/xiao-cheng-zi/MaterialDesign/blob/main/Images/937425507.png
