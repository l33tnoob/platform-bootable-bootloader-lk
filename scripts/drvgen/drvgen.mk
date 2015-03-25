ifndef DRVGEN_OUT
DRVGEN_OUT := $(BUILDDIR)
endif

DRVGEN_FILE_LIST := $(DRVGEN_OUT)/inc/cust_kpd.h \
		    $(DRVGEN_OUT)/inc/cust_eint.h \
		    $(DRVGEN_OUT)/inc/cust_gpio_boot.h \
		    $(DRVGEN_OUT)/inc/cust_gpio_usage.h \
		    $(DRVGEN_OUT)/inc/cust_adc.h \
		    $(DRVGEN_OUT)/inc/cust_power.h \
		    $(DRVGEN_OUT)/inc/pmic_drv.h

ifneq ($(MTK_PLATFORM),mt8127)
  DRVGEN_FILE_LIST += $(DRVGEN_OUT)/inc/cust_eint_md1.h
endif

ifeq ($(MTK_PLATFORM),mt6752)
  DRVGEN_FILE_LIST += $(DRVGEN_OUT)/inc/cust_eint_md2.h \
		    $(DRVGEN_OUT)/inc/cust_i2c.h \
		    $(DRVGEN_OUT)/inc/cust_clk_buf.h
endif

ifeq ($(MTK_PLATFORM),mt6595)
  DRVGEN_FILE_LIST += $(DRVGEN_OUT)/inc/cust_i2c.h \
		    $(DRVGEN_OUT)/inc/cust_clk_buf.h \
		    $(DRVGEN_OUT)/inc/cust_gpio_suspend.h \
		    $(DRVGEN_OUT)/inc/cust_eint.dtsi
endif

ifeq ($(MTK_PLATFORM),mt8127)
  DRVGEN_FILE_LIST += $(DRVGEN_OUT)/inc/cust_eint_ext.h
endif

PRIVATE_CUSTOM_KERNEL_DCT:= $(if $(CUSTOM_KERNEL_DCT),$(CUSTOM_KERNEL_DCT),dct)
DRVGEN_TOOL := $(PWD)/scripts/dct/DrvGen
DWS_FILE := $(PWD)/target/$(TARGET)/dct/$(PRIVATE_CUSTOM_KERNEL_DCT)/codegen.dws
DRVGEN_OUT_PATH := $(DRVGEN_OUT)/inc

$(DRVGEN_OUT)/inc/cust_kpd.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) kpd_h

$(DRVGEN_OUT)/inc/cust_eint.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) eint_h

$(DRVGEN_OUT)/inc/cust_gpio_boot.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) gpio_boot_h

$(DRVGEN_OUT)/inc/cust_gpio_usage.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) gpio_usage_h

$(DRVGEN_OUT)/inc/cust_adc.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) adc_h

$(DRVGEN_OUT)/inc/cust_eint_md1.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) md1_eint_h

$(DRVGEN_OUT)/inc/cust_power.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) power_h

$(DRVGEN_OUT)/inc/pmic_drv.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) pmic_h

$(DRVGEN_OUT)/inc/cust_i2c.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) i2c_h

$(DRVGEN_OUT)/inc/cust_clk_buf.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) clk_buf_h

$(DRVGEN_OUT)/inc/cust_eint_md2.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) md2_eint_h

$(DRVGEN_OUT)/inc/cust_gpio_suspend.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) suspend_h

$(DRVGEN_OUT)/inc/cust_eint_ext.h: $(DRVGEN_TOOL) $(DWS_FILE)
	@mkdir -p $(dir $@)
	@$(DRVGEN_TOOL) $(DWS_FILE) $(DRVGEN_OUT_PATH) eint_ext_h

