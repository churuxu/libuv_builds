#/bin/bash

TAG_VER=$1

if [ "$TAG_VER" == "" ]; then
  echo "usage make tag_version"
  echo "  tag_version like 1.7.0"
  exit 1
fi

DIR_NAME=libuv-${TAG_VER}
TAG_NAME=v${TAG_VER}
TAG_URL=https://github.com/libuv/libuv/archive/${TAG_NAME}.zip

if [ ! -f ${TAG_NAME}.zip ]; then
  echo download source ...
  curl -fsSL -o ${TAG_NAME}.zip ${TAG_URL} || exit 1
fi

if [ ! -d ${DIR_NAME} ]; then
  echo unzip source ...
  unzip -o ${TAG_NAME}.zip || exit 1
fi

[ ! -d ${DIR_NAME}/jni ] && mkdir ${DIR_NAME}/jni
cp -f Android.mk      ${DIR_NAME}/jni/Android.mk      || exit 1
cp -f Application.mk  ${DIR_NAME}/jni/Application.mk  || exit 1

cd ${DIR_NAME}/jni

NDKCMD=ndk-build
if [ -d ${NDK_HOME} ]; then
  NDKCMD=${NDK_HOME}/ndk-build
fi
${NDKCMD} || exit 1

cd ..
cd ..
zip -r libuv_android.zip ${DIR_NAME} -i ${DIR_NAME}/libs/*/* ${DIR_NAME}/include/* ${DIR_NAME}/LICENSE  || exit 1



