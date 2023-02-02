# Event Log Monitor

Monitoring Event Log Solution Based on Intersystems IRIS Platform

#### Description

This scheme is used to monitor the IRIS platform event log related information, including the event log list, log details, log type proportion, Top7 component with the highest number of logs, and the waveform of the number of logs in the past 7 days.

#### Installation deployment

##### 1.Create namespace

Create a namespace named IRISLOG in the management portal

![image-20230202115641533](img\image-20230202115641533.png)

##### 2.Import Code

In Studio, open the IRISLOG namespace, Tools ->Import Local, Import IRISLOG.xml file

![image-20230202150213232](img\image-20230202150213232.png)

##### 3.Initialize data

After importing the code successfully, execute the following command statement in Terminal, where "F: glo" is the file storage path, which can be changed according to the actual path

Command statement：

do ##class(IRISLOG.InitalData).Run("F:\glo")

Wait a few minutes to see the message that the Global import succeeded.

![image-20230202140100764](img\image-20230202140100764.png)

##### 4.Configure Web Application

REST Interface configuration

Configure through the management portal: System Administration -->Security -->Applications -->Web Applications.

Click "New Web Application", the configuration information is as shown below, and click "Save"

![image-20230202140526378](img\image-20230202140526378.png)

Select %All for application role and click "Save"

![image-20230202140708670](img\image-20230202140708670.png)

##### 5.Show Effect

Download the front-end code package dist. Double-click to open index.html under the dist package to see the following page

![image-20230202141744648](img\image-20230202141744648.png)

The URL is configured as the IP and port of IRISLOG. Click Send to see the specific log information

![image-20230202141930171](img\image-20230202141930171.png)

Click "Jump" to configure IRISLOG namespace address, as shown in the figure

![image-20230202142651513](img\image-20230202142651513.png)

You can jump to the IRIS message viewing interface. If you are prompted not to log in, enter the IRIS account password to log in

![image-20230202142842439](img\image-20230202142842439.png)



# 事件日志监控

基于Intersystems IRIS平台监控事件日志解决方案

#### 概述

此方案用于监控IRIS平台事件日志相关信息，包括事件日志列表、日志详细信息、日志类型占比、日志数量最高组件Top7、近7天内日志数量波形图。

#### 安装部署

##### 1.创建命名空间

在管理门户中创建名为IRISLOG的命名空间

![image-20230202115641533](D:\Backup\A-TEST\irislog\img\image-20230202115641533.png)

##### 2.导入代码

在Studio中，打开IRISLOG命名空间，Tools-->Import Local...，导入IRISLOG.xml文件

![image-20230202150213232](D:\Backup\A-TEST\irislog\img\image-20230202150213232.png)

##### 3.初始化数据

导入代码成功后，在Terminal中执行下面命令语句，其中"F:\glo"为文件存放路径，可以根据实际路径进行更改

命令语句：

do ##class(IRISLOG.InitalData).Run("F:\glo")

等待几分钟可以看到Global导入成功的信息。

![image-20230202140100764](D:\Backup\A-TEST\irislog\img\image-20230202140100764.png)

##### 4.配置Web应用程序

REST接口配置

通过管理门户配置：系统管理-->安全-->应用程序-->Web应用程序。

点击“新建Web应用程序”，配置信息如下图所示，点击“保存”

![image-20230202140526378](D:\Backup\A-TEST\irislog\img\image-20230202140526378.png)

应用程序角色选择%All，点击“保存”



![image-20230202140708670](D:\Backup\A-TEST\irislog\img\image-20230202140708670.png)

##### 5.效果展示

下载前端代码包dist，双击打开dist包下的index.html可看到如下页面

![image-20230202141744648](D:\Backup\A-TEST\irislog\img\image-20230202141744648.png)

URL配置为IRISLOG的ip和端口，点击发送可以看到日志具体信息

![image-20230202141930171](D:\Backup\A-TEST\irislog\img\image-20230202141930171.png)

点击“跳转”，配置IRISLOG命名空间地址，如图所示

![image-20230202142651513](D:\Backup\A-TEST\irislog\img\image-20230202142651513.png)

即可跳转到IRIS消息查看界面，如果提示未登录，输入IRIS账号密码登录即可

![image-20230202142842439](img\image-20230202142842439.png)