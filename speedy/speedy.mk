#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# The gps config appropriate for this device
PRODUCT_COPY_FILES += \
    device/htc/speedy/gps.conf:system/etc/gps.conf

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

PRODUCT_COPY_FILES += \
    device/htc/speedy/init.speedy.rc:root/init.speedy.rc \
    device/htc/speedy/ueventd.speedy.rc:root/ueventd.speedy.rc

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/speedy/speedy-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.clientidbase=android-sprint-us \
	ro.com.google.locationfeatures=1 \
	ro.cdma.home.operator.numeric=310120 \
	ro.cdma.home.operator.alpha=Sprint \
	ro.setupwizard.enable_bypass=1 \
        dalvik.vm.lockprof.threshold=500 \
        dalvik.vm.dexopt-flags=m=y

DEVICE_PACKAGE_OVERLAYS += device/htc/speedy/overlay

PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml

PRODUCT_PACKAGES += \
    lights.speedy \
    gps.speedy \
    sensors.speedy 

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/speedy/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/htc/speedy/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/htc/speedy/keychars/speedy-keypad.kcm.bin:system/usr/keychars/speedy-keypad.kcm.bin \
    device/htc/speedy/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl\
    device/htc/speedy/keylayout/speedy-keypad.kl:system/usr/keylayout/speedy-keypad.kl \
    device/htc/speedy/keylayout/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    device/htc/speedy/keylayout/qwerty.kl:system/usr/keylayout/qwerty.kl

# Firmware
PRODUCT_COPY_FILES += \
    device/htc/speedy/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/speedy/firmware/BCM4329B1_002.002.023.0511.0538.hcd:system/etc/firmware/BCM4329B1_002.002.023.0511.0538.hcd \
    device/htc/speedy/firmware/default.acdb:system/etc/firmware/default.acdb \
    device/htc/speedy/firmware/default_mfg.acdb:system/etc/firmware/default_mfg.acdb \
    device/htc/speedy/firmware/default_org.acdb:system/etc/firmware/default_org.acdb \
    device/htc/speedy/firmware/fw_bcm4329.bin:system/vendor/firmware/fw_bcm4329.bin \
    device/htc/speedy/firmware/fw_bcm4329_apsta.bin:system/vendor/firmware/fw_bcm4329_apsta.bin \
    device/htc/speedy/firmware/vidc_720p_command_control.fw:system/etc/firmware/vidc_720p_command_control.fw \
    device/htc/speedy/firmware/vidc_720p_h263_dec_mc.fw:system/etc/firmware/vidc_720p_h263_dec_mc.fw \
    device/htc/speedy/firmware/vidc_720p_h264_dec_mc.fw:system/etc/firmware/vidc_720p_h264_dec_mc.fw \
    device/htc/speedy/firmware/vidc_720p_h264_enc_mc.fw:system/etc/firmware/vidc_720p_h264_enc_mc.fw \
    device/htc/speedy/firmware/vidc_720p_mp2_dec_mc.fw:system/etc/firmware/vidc_720p_mp2_dec_mc.fw \
    device/htc/speedy/firmware/vidc_720p_mp4_dec_mc.fw:system/etc/firmware/vidc_720p_mp4_dec_mc.fw \
    device/htc/speedy/firmware/vidc_720p_mp4_enc_mc.fw:system/etc/firmware/vidc_720p_mp4_enc_mc.fw \
    device/htc/speedy/firmware/vidc_720p_vc1_dec_mc.fw:system/etc/firmware/vidc_720p_vc1_dec_mc.fw \
    device/htc/speedy/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    device/htc/speedy/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw 



# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# speedy uses high-density artwork where available
PRODUCT_LOCALES += hdpi

PRODUCT_COPY_FILES += \
    device/htc/speedy/vold.fstab:system/etc/vold.fstab \
    device/htc/speedy/apns-conf.xml:system/etc/apns-conf.xml

# Kernel modules
#PRODUCT_COPY_FILES += \

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/speedy/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

PRODUCT_COPY_FILES += \
    device/htc/speedy/modules/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/speedy/modules/sequans_sdio.ko:system/lib/modules/sequans_sdio.ko 

PRODUCT_COPY_FILES += \
    device/htc/speedy/prebuilt/libcryp98.so:system/lib/libcryp98.so

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

$(call inherit-product, build/target/product/full_base.mk)

# common msm7x30 configs
$(call inherit-product, device/htc/msm7x30-common/msm7x30.mk)

# media profiles and capabilities spec
$(call inherit-product, device/htc/speedy/media_a1026.mk)

# htc audio settings
$(call inherit-product, device/htc/speedy/media_htcaudio.mk)

$(call inherit-product-if-exists, vendor/htc/speedy/speedy-vendor.mk)

PRODUCT_NAME := htc_speedy
PRODUCT_DEVICE := speedy
