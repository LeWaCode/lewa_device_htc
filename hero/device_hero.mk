#
# Copyright (C) 2008 The Android Open Source Project
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

DEVICE_PACKAGE_OVERLAYS := device/htc/hero/overlay

# Passion uses high-density artwork where available
PRODUCT_LOCALES += mdpi

# Publish that we support the live wallpaper feature.
PRODUCT_COPY_FILES += \
    packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml
    
PRODUCT_COPY_FILES += \
    device/htc/hero/vold.fstab:system/etc/vold.fstab

# Don't set /proc/sys/vm/dirty_ratio to 0 when USB mounting
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vold.umsdirtyratio=20

# proprietary side of the device
$(call inherit-product-if-exists, vendor/htc/hero/device_hero-vendor.mk)

# No zram in kernel, so use ramzswap for compcache
PRODUCT_COPY_FILES += \
    device/htc/hero/prebuilt/12compcache:system/etc/init.d/12compcache \
    device/htc/hero/prebuilt/rzscontrol:system/xbin/rzscontrol

PRODUCT_PACKAGES += \
    librs_jni \
    hero-keypad.kcm \
    sensors.hero \
    lights.hero \
    gralloc.msm7k \
    copybit.msm7k \
    gps.hero \
    wlan_loader \
    tiwlan.ini \
    dhcpcd.conf \
    VoiceDialer \
    libOmxCore \
    libOmxVidEnc \
    libmm-omxcore

# Install the features available on this device.
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

PRODUCT_COPY_FILES += \
    device/htc/hero/init.hero.rc:root/init.hero.rc \
    device/htc/hero/ueventd.hero.rc:root/ueventd.hero.rc

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/hero/hero-keypad.kl:system/usr/keylayout/hero-keypad.kl \
    device/htc/hero/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl
    
# GSM APN list
PRODUCT_COPY_FILES += \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# media configuration xml file
PRODUCT_COPY_FILES += \
    device/htc/hero/media_profiles.xml:/system/etc/media_profiles.xml

# Kernel Targets
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/htc/hero/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

KERNEL_NAME := 2.6.29.6-flykernel-12a

PRODUCT_COPY_FILES += \
    device/htc/hero/modules/modules.dep.bb:system/lib/modules/$(KERNEL_NAME)/modules.dep.bb \
    device/htc/hero/modules/modules.order:system/lib/modules/$(KERNEL_NAME)/modules.order \
    device/htc/hero/modules/ip_gre.ko:system/lib/modules/$(KERNEL_NAME)/net/ipv4/ip_gre.ko \
    device/htc/hero/modules/wlan.ko:system/lib/modules/$(KERNEL_NAME)/drivers/net/wireless/tiwlan1251/wlan.ko \
    device/htc/hero/modules/hid-dummy.ko:system/lib/modules/$(KERNEL_NAME)/drivers/hid/hid-dummy.ko \
    device/htc/hero/modules/ramzswap.ko:system/lib/modules/$(KERNEL_NAME)/drivers/staging/ramzswap/ramzswap.ko \
    device/htc/hero/modules/cifs.ko:system/lib/modules/$(KERNEL_NAME)/fs/cifs/cifs.ko \
    device/htc/hero/modules/fuse.ko:system/lib/modules/$(KERNEL_NAME)/fs/fuse/fuse.ko \
    device/htc/hero/modules/wlan.ko:system/lib/modules/wlan.ko

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)
