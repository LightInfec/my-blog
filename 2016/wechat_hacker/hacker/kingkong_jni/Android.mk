
LOCAL_PATH := $(call my-dir)

# Should run "ndk-build clean"
# When this file changed
export RELEASE_VERSION := true

export ENABLE_PNG_FIXER := true
export ENABLE_FREAK_FIXER := false

allMakeFile :=


# Java Hook
allMakeFile	 += $(LOCAL_PATH)/JavaHook/Dalvik.mk


LOCAL_MODULE:= libwechatCrashForJni   


include $(allMakeFile)
