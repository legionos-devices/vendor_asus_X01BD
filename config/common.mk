# Copyright (C) 2020 Rebellion-OS
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

 include vendor/rebellion/config/version.mk

PRODUCT_BRAND ?= Rebellion-OS

$(call inherit-product-if-exists, external/motorola/faceunlock/config.mk)

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/rebellion/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/rebellion/prebuilt/common/bin/50-base.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-base.sh

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/rebellion/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/rebellion/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh
endif

# Bootanimation
$(call inherit-product, vendor/rebellion/config/bootanimation.mk)

# Gapps
ifeq ($(WITH_GAPPS),true)
include vendor/gapps/config.mk
else

ifeq ($(TARGET_USE_JELLY),true)
PRODUCT_PACKAGES += \
    Jelly
endif

# Markup libs
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/lib/libsketchology_native.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libsketchology_native.so \
    vendor/rebellion/prebuilt/common/lib64/libsketchology_native.so:$(TARGET_COPY_OUT_SYSTEM)/lib64/libsketchology_native.so

PRODUCT_PACKAGES += \
    MarkupGoogle

# Turbo
PRODUCT_PACKAGES += \
    turbo.xml \
    privapp-permissions-turbo.xml
endif

ifeq ($(TARGET_USE_GCAM),true)
PRODUCT_PACKAGES += \
    Gcam
endif

# Hidden API whitelist
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/permissions/rebellion-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/rebellion-hiddenapi-package-whitelist.xml

# priv-app permissions
PRODUCT_COPY_FILES += \
    vendor/rebellion/config/permissions/privapp-permissions-google_prebuilt.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-google_prebuilt.xml \
    vendor/rebellion/prebuilt/common/etc/permissions/privapp-permissions-rebellion.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-rebellion.xml \
    vendor/rebellion/prebuilt/common/etc/permissions/privapp-permissions-rebellion-product.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-rebellion-product.xml \
    vendor/rebellion/config/permissions/privapp-permissions-livedisplay.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-livedisplay.xml

PRODUCT_PACKAGES += \
    privapp-permissions-wellbeing.xml

# Enforce privapp-permissions whitelist
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.control_privapp_permissions=enforce

DEVICE_PACKAGE_OVERLAYS += \
    vendor/rebellion/overlay/common \
    vendor/rebellion/overlay/dictionaries

# Power whitelist
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/permissions/rebellion-power-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/rebellion-power-whitelist.xml

# Custom Rebellion packages
PRODUCT_PACKAGES += \
    CustomDoze \
    Terminal \
    LatinIME \
    Lawnchair \
    LiveWallpapers \
    LiveWallpapersPicker \
    Stk \
    ViaBrowser \
    RetroMusicPlayer \
    TurboPrebuilt \
    Recorder \
    WeatherClient \
    GalleryGoPrebuilt \
    GBoardPrebuilt \
    PixelThemesStub2019 \
    ExactCalculator \
    TouchGestures \
    StitchImage

# Weather
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/permissions/org.pixelexperience.weather.client.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/org.pixelexperience.weather.client.xml \
    vendor/rebellion/prebuilt/common/etc/permissions/default-permissions/org.pixelexperience.weather.client.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/default-permissions/org.pixelexperience.weather.client.xml

# Dex preopt
PRODUCT_DEXPREOPT_SPEED_APPS += \
    SystemUI

# Extra packages
PRODUCT_PACKAGES += \
    libjni_latinimegoogle

# Pixel sysconfig
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/sysconfig/pixel.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/pixel.xml

# Extra tools
PRODUCT_PACKAGES += \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    mkfs.f2fs \
    fsck.f2fs \
    fibmap.f2fs \
    mkfs.ntfs \
    fsck.ntfs \
    mount.ntfs \
    7z \
    bash \
    bzip2 \
    curl \
    lib7z \
    powertop \
    pigz \
    tinymix \
    unrar \
    unzip \
    vim \
    rsync \
    zip

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/rebellion/config/permissions/backup.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/backup.xml

# Some permissions
PRODUCT_COPY_FILES += \
    vendor/rebellion/config/permissions/privapp-permissions-custom.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-custom.xml

# init.d support
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/init.d/00banner:$(TARGET_COPY_OUT_SYSTEM)/etc/init.d/00banner

# Rebellion-specific init files
$(foreach f,$(wildcard vendor/rebellion/prebuilt/common/etc/init/*.rc),\
    $(eval PRODUCT_COPY_FILES += $(f):$(TARGET_COPY_OUT_SYSTEM)/etc/init/$(notdir $f)))

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/rebellion/prebuilt/common/media/LMspeed_508.emd:$(TARGET_COPY_OUT_SYSTEM)/media/LMspeed_508.emd \
    vendor/rebellion/prebuilt/common/media/PFFprec_600.emd:$(TARGET_COPY_OUT_SYSTEM)/media/PFFprec_600.emd

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/lib/content-types.properties:$(TARGET_COPY_OUT_SYSTEM)/lib/content-types.properties

# Fix Dialer
PRODUCT_COPY_FILES +=  \
    vendor/rebellion/prebuilt/common/etc/sysconfig/dialer_experience.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/dialer_experience.xml

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Vendor_045e_Product_0719.kl

# Media
PRODUCT_GENERIC_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# Needed by some RILs and for some gApps packages
PRODUCT_PACKAGES += \
    librsjni \
    libprotobuf-cpp-full

# Charger images
PRODUCT_PACKAGES += \
    charger_res_images

# ThemeOverlays
include packages/overlays/Themes/themes.mk

#OmniJaws
PRODUCT_PACKAGES += \
    OmniJaws \
    WeatherIcons

# OmniStyle
PRODUCT_PACKAGES += \
    OmniStyle \

# ThemePicker
PRODUCT_PACKAGES += \
    ThemePicker \
    WallpaperPicker2

# Recommend using the non debug dexpreopter
USE_DEX2OAT_DEBUG ?= false

# Allow overlays to be excluded from enforcing RRO
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/rebellion/overlay

# Lawnchair
PRODUCT_COPY_FILES += \
    vendor/rebellion/prebuilt/common/etc/permissions/privapp-permissions-lawnchair.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-lawnchair.xml \
    vendor/rebellion/prebuilt/common/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/lawnchair-hiddenapi-package-whitelist.xml 

# APN
PRODUCT_PACKAGES += \
    apns-conf.xml

#Telephony
$(call inherit-product, vendor/rebellion/config/telephony.mk)

# Include Rebellion theme files
include vendor/rebellion/themes/backgrounds/themes.mk

# Fonts
include vendor/rebellion/prebuilt/common/fonts/fonts.mk
