ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),marvel)
include $(call all-named-subdir-makefiles, liblights libsensors)
endif
