# 简介
主要实现双目标定和视差图及点云显示，其中
1. stereo_calib.cpp 主要是实现了双目标定，stereo_calib.xml给出了用于标定的图像集合，标定结束后会产生 extrinsics.yml 和 intrinsics.yml
2. stereo_match.cpp 主要功能是输入左右目图像，显示视差图和对应点云

# 编译和运行
## 编译
如果没有build文件夹，则：
```
$ mkdir build & cd build
$ rm -rf *
$ cmake ..
$ make
```
## 运行
标定双目摄像头，首先得准备包含有棋盘格的图像集合，
```
$ ./stereo_calib -w 8 -h 6 ../stereo_calib.xml
```
其中， -w表示长方向棋盘格内点个数，-h表示宽方向棋盘格内点个数，stereo_calib.xml中保存用于标定的图像集合地址。
例如：
```
<?xml version="1.0"?>
<opencv_storage>
<imagelist>
"/home/turtlebot/Project_qzw/UnderWaterRobot/calibrate_stereo/20110101/left/left01.jpg"
"/home/turtlebot/Project_qzw/UnderWaterRobot/calibrate_stereo/20110101/right/right01.jpg"
"/home/turtlebot/Project_qzw/UnderWaterRobot/calibrate_stereo/20110101/left/left02.jpg"
"/home/turtlebot/Project_qzw/UnderWaterRobot/calibrate_stereo/20110101/right/right02.jpg"
</imagelist>
</opencv_storage>
```
尖括号中是说明文字，不用修改。双引号中为图像地址，需要根据实际情况修改。

显示视差图和对应点云，前两个输入为左右目图像，后面两个参数文件是标定时生成的。
```
$ ./stereo_match ../20110101/1-01.jpg ../20110101/2-01.jpg -i intrinsics.yml -e extrinsics.yml
```

> 这两个程序均来自opencv的例子程序

> 两个程序更多参数均可以通过-h查看

# 代码更新和编译
```
$ git pull
$ cd build & rm -rf *
$ cmake ..
$ make
```
