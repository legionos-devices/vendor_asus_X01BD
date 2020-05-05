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

ifndef REBELLION_BUILD_TYPE
    REBELLION_BUILD_TYPE := UnRebelized
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)
REBELLION_DATE_YEAR := $(shell date -u +%Y)
REBELLION_DATE_MONTH := $(shell date -u +%m)
REBELLION_DATE_DAY := $(shell date -u +%d)
REBELLION_DATE_HOUR := $(shell date -u +%H)
REBELLION_DATE_MINUTE := $(shell date -u +%M)
REBELLION_BUILD_DATE_UTC := $(shell date -d '$(REBELLION_DATE_YEAR)-$(REBELLION_DATE_MONTH)-$(REBELLION_DATE_DAY) $(REBELLION_DATE_HOUR):$(REBELLION_DATE_MINUTE) UTC' +%s)
REBELLION_BUILD_DATE := $(REBELLION_DATE_YEAR)$(REBELLION_DATE_MONTH)$(REBELLION_DATE_DAY)-$(REBELLION_DATE_HOUR)$(REBELLION_DATE_MINUTE)
REBELLION_PLATFORM_VERSION := 10.0
REBELLION_BASE_EDITION := StarWars_Edition
REBELLION_VERSION_CUSTOM := StarWars-v1.8_
REBELLION_FANBASE_TYPE := StarWars
REBELLION_FANBASE_VERSION := v1.8
BUILD_VERSION := v1.8

ifeq ($(REBELLION_OFFICIAL), true)
   LIST = $(shell cat vendor/rebellion/rebellion.devices)
   FOUND_DEVICE = $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(filter $(CURRENT_DEVICE), $(LIST)), $(CURRENT_DEVICE))
      IS_OFFICIAL=true
      REBELLION_BUILD_TYPE := Rebelized

   # OTA
   $(call inherit-product-if-exists, vendor/rebellion/config/ota.mk)

    endif
    ifneq ($(IS_OFFICIAL), true)
       REBELLION_BUILD_TYPE := UnRebelized
       $(error Device is not official "$(FOUND)")
    endif
endif

TARGET_PRODUCT_SHORT := $(subst rebellion_,,$(REBELLION_BUILD))

REBELLION_VERSION := Rebellion_OS-$(BUILD_VERSION)-$(REBELLION_BASE_EDITION)-$(REBELLION_BUILD)-$(REBELLION_BUILD_DATE)-$(REBELLION_BUILD_TYPE)
REBELLION_VERSION_BASE := Rebellion-OS-$(BUILD_VERSION)-$(REBELLION_BASE_EDITION)-$(REBELLION_BUILD)-$(REBELLION_BUILD_DATE)-$(REBELLION_BUILD_TYPE)
REBELLION_FINGERPRINT := Rebellion/$(REBELLION_PLATFORM_VERSRION)/$(TARGET_PRODUCT_SHORT)/$(REBELLION_BUILD_DATE)

REBELLION_PROPERTIES := \
    ro.rebellion.custom.version=$(REBELLION_VERSION_CUSTOM) \
    ro.rebellion.version=$(REBELLION_VERSION) \
    ro.rebellion.build_date=$(REBELLION_BUILD_DATE) \
    ro.rebellion.build_type=$(REBELLION_BUILD_TYPE) \
    ro.rebellion.fingerprint=$(REBELLION_FINGERPRINT) \
    ro.rebellion.fanbase_type=$(REBELLION_FANBASE_TYPE) \
    ro.rebellion.fanbase_version=$(REBELLION_FANBASE_VERSION) \
    ro.rebel=$(REBEL)
