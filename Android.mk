LOCAL_PATH := $(call my-dir)
LOCAL_ASSETS_TEMP_PATH := $(call intermediates-dir-for,APPS,OmsBackend,,COMMON)/assets

include $(CLEAR_VARS)
LOCAL_PREBUILT_STATIC_JAVA_LIBRARIES := \
    apache-commons-io:libs/commons-io-2.5.jar \
    zipsigner:libs/zipsigner-lib-1.17.jar \
    zipio:libs/zipio-lib-1.8.jar \
    kellinwood-logging-android:libs/kellinwood-logging-android-1.4.jar \
    kellinwood-logging-lib:libs/kellinwood-logging-lib-1.1.jar \
    kellinwood-logging-log4j:libs/kellinwood-logging-log4j-1.0.jar

include $(BUILD_MULTI_PREBUILT)

# DEVICE AAPT
ifneq ($(SDK_ONLY),true)
include $(CLEAR_VARS)
LOCAL_MODULE := aapt
LOCAL_CFLAGS := -DAAPT_VERSION=\"$(BULD_NUMBER_FROM_FILE)\"
LOCAL_CFLAGS += -Wall -Werror
AAPT_PATH := ../../../frameworks/base/tools/aapt
LOCAL_SRC_FILES := $(AAPT_PATH)/Main.cpp \
    $(AAPT_PATH)/AaptAssets.cpp \
    $(AAPT_PATH)/AaptConfig.cpp \
    $(AAPT_PATH)/AaptUtil.cpp \
    $(AAPT_PATH)/AaptXml.cpp \
    $(AAPT_PATH)/ApkBuilder.cpp \
    $(AAPT_PATH)/Command.cpp \
    $(AAPT_PATH)/CrunchCache.cpp \
    $(AAPT_PATH)/FileFinder.cpp \
    $(AAPT_PATH)/Images.cpp \
    $(AAPT_PATH)/Package.cpp \
    $(AAPT_PATH)/pseudolocalize.cpp \
    $(AAPT_PATH)/Resource.cpp \
    $(AAPT_PATH)/ResourceFilter.cpp \
    $(AAPT_PATH)/ResourceIdCache.cpp \
    $(AAPT_PATH)/ResourceTable.cpp \
    $(AAPT_PATH)/SourcePos.cpp \
    $(AAPT_PATH)/StringPool.cpp \
    $(AAPT_PATH)/WorkQueue.cpp \
    $(AAPT_PATH)/XMLNode.cpp \
    $(AAPT_PATH)/ZipEntry.cpp \
    $(AAPT_PATH)/ZipFile.cpp
LOCAL_C_INCLUDES += bionic
LOCAL_SHARED_LIBRARIES := \
    libandroidfw \
    libpng \
    libutils \
    liblog \
    libcutils \
    libexpat \
    libbase \
    libz
LOCAL_STATIC_LIBRARIES := libexpat_static
LOCAL_MODULE_PATH := $(LOCAL_ASSETS_TEMP_PATH)
include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_STATIC_JAVA_LIBRARIES := \
    android-support-v7-appcompat \
    android-support-v4 \
    theme-core \
    apache-commons-io \
    zipsigner \
    zipio \
    kellinwood-logging-android \
    kellinwood-logging-lib \
    kellinwood-logging-log4j

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_RESOURCE_DIR := \
    $(LOCAL_PATH)/res \
    frameworks/support/v7/appcompat/res \
    frameworks/opt/theme-core/res

LOCAL_ASSET_DIR := $(LOCAL_ASSETS_TEMP_PATH) $(LOCAL_PATH)/assets
LOCAL_PROGUARD_ENABLED := disabled
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_PACKAGE_NAME := OmsBackend
LOCAL_AAPT_FLAGS := --auto-add-overlay \
    --extra-packages android.support.v7.appcompat:com.slimroms.themecore

include $(BUILD_PACKAGE)
