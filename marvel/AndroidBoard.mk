LOCAL_PATH := $(call my-dir)

# Least specific includes go first, so that they can get
# overridden further down
include $(CLEAR_VARS)

# include the non-open-source counterpart to this file
-include vendor/htc/marvel/AndroidBoardVendor.mk

file := $(TARGET_RECOVERY_ROOT_OUT)/sbin/postrecoveryboot.sh
ALL_PREBUILT += $(file)
$(file) : $(LOCAL_PATH)/postrecoveryboot.sh | $(ACP)
	$(transform-prebuilt-to-target)
