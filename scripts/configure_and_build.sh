#!/usr/bin/env bash
set -euo pipefail

: "${ANDROID_NDK:?ANDROID_NDK is required}"
: "${ANDROID_API:=24}"
: "${ANDROID_ABI:=arm64-v8a}"
: "${PYTHON_VERSION:=3.13}"
: "${PYTHON_INCLUDE_DIR:?PYTHON_INCLUDE_DIR is required}"
: "${PYTHON_LIBRARY:?PYTHON_LIBRARY is required}"
: "${PYTHON3_EXECUTABLE:?PYTHON3_EXECUTABLE is required}"
: "${PYTHON_PACKAGES_PATH:=/data/data/com.termux/files/usr/lib/python3.13/site-packages}"
: "${TERMUX_PREFIX:?TERMUX_PREFIX is required}"
: "${BUILD_DIR:=build}"
: "${INSTALL_PREFIX:=$PWD/out/install}"

mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake ../opencv \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_TOOLCHAIN_FILE="$ANDROID_NDK/build/cmake/android.toolchain.cmake" \
  -DANDROID_ABI="$ANDROID_ABI" \
  -DANDROID_PLATFORM="android-${ANDROID_API}" \
  -DANDROID_STL=c++_shared \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  -DOPENCV_EXTRA_MODULES_PATH="$PWD/../opencv_contrib/modules" \
  -DBUILD_opencv_java=OFF \
  -DBUILD_opencv_js=OFF \
  -DBUILD_ANDROID_PROJECTS=OFF \
  -DBUILD_ANDROID_EXAMPLES=OFF \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_DOCS=OFF \
  -DBUILD_JPEG=ON \
  -DBUILD_PNG=ON \
  -DBUILD_TIFF=ON \
  -DBUILD_WEBP=ON \
  -DWITH_QT=OFF \
  -DWITH_GTK=OFF \
  -DWITH_OPENGL=OFF \
  -DWITH_V4L=OFF \
  -DWITH_FFMPEG=OFF \
  -DWITH_GSTREAMER=OFF \
  -DWITH_IPP=OFF \
  -DWITH_TBB=OFF \
  -DWITH_OPENMP=OFF \
  -DBUILD_LIST=core,imgproc,imgcodecs,python3 \
  -DBUILD_opencv_python2=OFF \
  -DBUILD_opencv_python3=ON \
  -DOPENCV_PYTHON3_INSTALL_PATH="$PYTHON_PACKAGES_PATH" \
  -DPYTHON3_EXECUTABLE="$PYTHON3_EXECUTABLE" \
  -DPYTHON3_INCLUDE_DIR="$PYTHON_INCLUDE_DIR" \
  -DPYTHON3_LIBRARY="$PYTHON_LIBRARY" \
  -DPYTHON3_PACKAGES_PATH="$PYTHON_PACKAGES_PATH"

cmake --build . --parallel
cmake --install .

echo "Build complete: $INSTALL_PREFIX"
