# opencv-android-headless

给 Android Termux 准备的 OpenCV headless 构建脚手架。

**明确目标：在安卓 Termux 的 Python 3.13 环境里可运行，至少做到 `import cv2`。**

## 当前定位

这不是直接复用 `opencv-python-headless` 官方 manylinux wheel。
原因是官方预编译 wheel 面向 Linux/glibc，不能直接用于 Android/Termux。

这里提供的是：

- 一个可维护的 GitHub Actions 构建流程
- 一个围绕 **Termux + Python 3.13** 目标收敛的 OpenCV 构建起点
- 尽量 headless 的 CMake 配置
- 产物归档为 Actions artifact

## 设计原则

- 优先做 **Python 3.13 的 `import cv2` 可用**
- 优先支持 **Android aarch64 / Termux**
- 尽量禁用高成本 GUI / 多媒体依赖
- 先保守求稳，再逐步加模块

## 关键现实约束

要让 `cv2` 真正在 Termux 的 Python 3.13 中加载成功，必须同时满足：

- Android ABI 正确（这里默认 aarch64 / `arm64-v8a`）
- Android API level 合适
- Python 3.13 头文件、libpython、site-packages 路径与目标环境一致
- OpenCV Python 扩展模块的编译配置与目标 Python ABI 一致

也就是说，**不能拿 Ubuntu runner 自带的 Python 3.12/3.13 开发头直接当成 Termux Python 3.13 的 ABI 代表。**

## 产物说明

初版仓库的目标产物是：

- Android/Termux 目标的 `cv2*.so` 候选产物
- 构建日志
- OpenCV 安装目录归档

后续可以继续扩展成：

- 更完整的 Python wheel 打包
- termux package 风格目录
- 额外的 contrib 模块

## 当前阶段

这个仓库现在是 **第一阶段脚手架**，不是已经验证通过的最终成品。
当前最重要的难点是：**让 Python 3.13 绑定真正对齐 Termux 目标 ABI。**

## 建议验证路径

1. 先用 workflow 验证 OpenCV core 的 Android 交叉编译链路
2. 再补 Termux / Python 3.13 目标头文件与库来源
3. 最后在真实 Termux Python 3.13 环境里做 `import cv2` smoke test
