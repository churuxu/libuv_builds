
LOCAL_PATH := $(call my-dir)

uv_src_dir := $(LOCAL_PATH)/..

uv_includes := $(uv_src_dir)/include $(uv_src_dir)/src $(uv_src_dir)/src/unix

uv_sources := \
    $(uv_src_dir)/src/fs-poll.c \
    $(uv_src_dir)/src/inet.c \
    $(uv_src_dir)/src/threadpool.c \
    $(uv_src_dir)/src/uv-common.c \
    $(uv_src_dir)/src/version.c \
    $(uv_src_dir)/src/unix/android-ifaddrs.c \
    $(uv_src_dir)/src/unix/async.c \
    $(uv_src_dir)/src/unix/core.c \
    $(uv_src_dir)/src/unix/dl.c \
    $(uv_src_dir)/src/unix/fs.c \
    $(uv_src_dir)/src/unix/getaddrinfo.c \
    $(uv_src_dir)/src/unix/getnameinfo.c \
    $(uv_src_dir)/src/unix/linux-core.c \
    $(uv_src_dir)/src/unix/linux-inotify.c \
    $(uv_src_dir)/src/unix/linux-syscalls.c \
    $(uv_src_dir)/src/unix/loop-watcher.c \
    $(uv_src_dir)/src/unix/loop.c \
    $(uv_src_dir)/src/unix/pipe.c \
    $(uv_src_dir)/src/unix/poll.c \
    $(uv_src_dir)/src/unix/process.c \
    $(uv_src_dir)/src/unix/proctitle.c \
    $(uv_src_dir)/src/unix/pthread-fixes.c \
    $(uv_src_dir)/src/unix/signal.c \
    $(uv_src_dir)/src/unix/stream.c \
    $(uv_src_dir)/src/unix/tcp.c \
    $(uv_src_dir)/src/unix/thread.c \
    $(uv_src_dir)/src/unix/timer.c \
    $(uv_src_dir)/src/unix/tty.c \
    $(uv_src_dir)/src/unix/udp.c \



include $(CLEAR_VARS)
LOCAL_CFLAGS := -DOS=android -pthread
LOCAL_MODULE := uv
LOCAL_SRC_FILES := $(uv_sources)
LOCAL_C_INCLUDES := $(uv_includes)
LOCAL_EXPORT_C_INCLUDES := $(uv_includes)

include $(BUILD_SHARED_LIBRARY)




