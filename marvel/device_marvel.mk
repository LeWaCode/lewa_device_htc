# Copyright (C) 2009 The Android Open Source Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit for AGPS
$(call inherit-product, device/common/gps/gps_cn_supl.mk)

# Inherit vendor
$(call inherit-product-if-exists, vendor/htc/marvel/marvel-vendor.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

# media profiles and capabilities spec
$(call inherit-product, device/htc/marvel/media_a1026.mk)

# overlay
DEVICE_PACKAGE_OVERLAYS := device/htc/marvel/overlay

# product
PRODUCT_NAME := generic_marvel
PRODUCT_DEVICE := marvel

## (1) First, the most specific values, i.e. the aspects that are specific to GSM
#PRODUCT_LOCALES := zh_CN zh_TW en_US
PRODUCT_LOCALES := zh_CN en_US zh_TW

# Add LDPI assets, in addition to MDPI
PRODUCT_LOCALES += mdpi

# Kernel modules
ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/marvel/prebuilt/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# added by ioz9 for lewafm 2012.03.27
PRODUCT_PACKAGES += \
    librs_jni \
    lights.marvel \
    gralloc.msm7k \
    libOmxCore \
    copybit.msm7k \
    sensors.marvel \
    gps.marvel \
    com.android.future.usb.accessory \
    LeWaFM \
    Torch

# Prebuilt Modules
PRODUCT_COPY_FILES += \
    device/htc/marvel/prebuilt/ansi_cprng.ko:system/lib/modules/ansi_cprng.ko \
    device/htc/marvel/prebuilt/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/marvel/prebuilt/cifs.ko:system/lib/modules/cifs.ko \
    device/htc/marvel/prebuilt/gan-eth.ko:system/lib/modules/gan-eth.ko \
    device/htc/marvel/prebuilt/oprofile.ko:system/lib/modules/oprofile.ko \
    device/htc/marvel/prebuilt/scsi_wait_scan.ko:system/lib/modules/scsi_wait_scan.ko \
    device/htc/marvel/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/marvel/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/marvel/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin \


#    device/htc/marvel/prebuilt/kineto_gan.ko:system/lib/modules/kineto_gan.ko \
#    device/htc/marvel/prebuilt/nls_utf8.ko:system/lib/modules/nls_utf8.ko \
#    device/htc/marvel/prebuilt/tun.ko:system/lib/modules/tun.ko \

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/marvel/key/marvel-keypad.kl:system/usr/keylayout/marvel-keypad.kl \
    device/htc/marvel/key/marvel-keypad.kcm.bin:system/usr/keychars/marvel-keypad.kcm.bin \
    device/htc/marvel/key/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \

# init
PRODUCT_COPY_FILES += \
    device/htc/marvel/ueventd.marvel.rc:root/ueventd.marvel.rc\
    device/htc/marvel/init.marvel.rc:root/init.marvel.rc \

# permissions
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \

# vold
PRODUCT_COPY_FILES += \
    device/htc/marvel/vold.fstab:system/etc/vold.fstab \

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/marvel/media_profiles.xml:system/etc/media_profiles.xml \

# apns-conf.xml
#PRODUCT_COPY_FILES += \
#    device/common/apn/apns-conf.xml:system/etc/apns-conf.xml

# Copy bootanimation
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/mdpi/media/bootanimation.zip:system/media/bootanimation.zip \

# copy default lockscreen theme by shenqi 2011-12-29
PRODUCT_COPY_FILES += \
    lewa/frameworks/lockscreen/HVGA/lockscreen.zip:/system/media/lockscreen.zip \
    lewa/frameworks/theme/HVGA/default.lwt:/system/media/default.lwt \

# ril
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/libhtc_ril.so \
    ro.ril.enable.dtm=1 \
    ro.ril.hsdpa.category=20 \
    ro.ril.hsupa.category=6 \
    ro.ril.disable.fd.plmn.prefix=23402,23410,23411,23420 \
    ro.ril.def.agps.mode=2 \
    ro.ril.hsxpa=2 \
    ro.ril.gprsclass=12 \
    mobiledata.interfaces=rmnet0,rmnet1,rmnet2,gprs,ppp0,pdp0,eth0 \

# wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=eth0 \
    wifi.supplicant_scan_interval=120 \

# display
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=160 \
    qemu.sf.lcd_density=160 \
    ro.opengles.version=131072 \

# Default network type.
# 0 => WCDMA preferred.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=0 \

# For emmc phone storage
PRODUCT_PROPERTY_OVERRIDES += \
    ro.phone_storage=0 \

# settings
PRODUCT_PROPERTY_OVERRIDES += \
    settings.display.autobacklight=1 \
    settings.display.brightness=143 \
    persist.service.mount.playsnd=0 \
    ro.com.google.locationfeatures=1 \
    ro.setupwizard.mode=OPTIONAL \
    ro.setupwizard.enable_bypass=1 \
    net.bt.name=Android \
    ro.config.sync=yes \

# added by ioz9 for tweak Media
PRODUCT_PROPERTY_OVERRIDES += \
    ro.media.dec.aud.wma.enabled=1 \
    ro.media.dec.vid.wmv.enabled=1 \

# dalvik tweaks by ioz9
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.lockprof.threshold=500 \
    dalvik.vm.dexopt-flags=m=y \
    dalvik.vm.heapsize=48m \
    dalvik.vm.execution-mode=int:jit \
    dalvik.vm.dexopt-data-only=1 \

# added by ioz9 for lewa swapper
PRODUCT_PROPERTY_OVERRIDES += \
    ro.lewa.swapper.part_path=/dev/block/mmcblk0p3 \

# performance tweaks by ioz9
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.hw=1 \
    ro.sf.hwrotation=0 \
    windowsmgr.max_events_per_sec=120 \
    debug.composition.type=gpu \
    video.accelerate.hw=1 \
    debug.performance.tuning=1 \
