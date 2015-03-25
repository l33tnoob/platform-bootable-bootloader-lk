#
# Copyright (C) 2009-2011 The Android-x86 Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
ifneq ($(strip $(MTK_EMULATOR_SUPPORT)),yes)
ifneq ($(strip $(MTK_PROJECT_NAME)),)


ifneq ($(filter /% ~%,$(TARGET_OUT_INTERMEDIATES)),)
BOOTLOADER_OUT := $(TARGET_OUT_INTERMEDIATES)/BOOTLOADER_OBJ
else
BOOTLOADER_OUT := $(PWD)/$(TARGET_OUT_INTERMEDIATES)/BOOTLOADER_OBJ
endif

BOOTLOADER_ROOT_DIR := $(PWD)
TARGET_BOOTLOADER := $(PRODUCT_OUT)/lk.bin 
TARGET_LOGO       := $(PRODUCT_OUT)/logo.bin

.PHONY: clean-lk lk
clean-lk:
	$(hide) rm -f $(TARGET_BOOTLOADER) $(TARGET_LOGO)

$(BOOTLOADER_OUT):
	mkdir -p $(BOOTLOADER_OUT)

# Top level for eMMC variant targets
$(TARGET_BOOTLOADER): clean-lk | $(BOOTLOADER_OUT)
	@$(MAKE) -C bootable/bootloader/lk MTK_TARGET_PROJECT=$(MTK_TARGET_PROJECT) BOOTLOADER_OUT=$(BOOTLOADER_OUT) ROOTDIR=$(BOOTLOADER_ROOT_DIR) $(LK_PROJECT)
	@cp -rf $(BOOTLOADER_OUT)/build-$(LK_PROJECT)/lk.bin $(TARGET_BOOTLOADER)
	@cp -rf $(BOOTLOADER_OUT)/build-$(LK_PROJECT)/logo.bin $(PRODUCT_OUT)/logo.bin

lk: $(TARGET_BOOTLOADER) | $(BOOTLOADER_OUT)

droidcore: $(TARGET_BOOTLOADER) 

droid: check-lk-config
check-mtk-config: check-lk-config
check-lk-config:
	python device/mediatek/build/build/tools/check_kernel_config.py -c $(MTK_TARGET_PROJECT_FOLDER)/ProjectConfig.mk -l bootable/bootloader/lk/project/$(LK_PROJECT).mk -p $(MTK_PROJECT_NAME)

endif
endif

