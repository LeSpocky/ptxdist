# -*-makefile-*-
#
# Copyright (C) 2021 by Christian Melki <christian.melki@t2data.com>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_LINUX_FIRMWARE) += linux-firmware

#
# Paths and names
#
LINUX_FIRMWARE_VERSION	:= 20220708
LINUX_FIRMWARE_MD5	:= a4389b0cfb921ad5209d8ddbed7f7548
LINUX_FIRMWARE		:= linux-firmware-$(LINUX_FIRMWARE_VERSION)
LINUX_FIRMWARE_SUFFIX	:= tar.gz
LINUX_FIRMWARE_URL	:= $(call ptx/mirror, KERNEL, kernel/firmware/$(LINUX_FIRMWARE).$(LINUX_FIRMWARE_SUFFIX))
LINUX_FIRMWARE_SOURCE	:= $(SRCDIR)/$(LINUX_FIRMWARE).$(LINUX_FIRMWARE_SUFFIX)
LINUX_FIRMWARE_DIR	:= $(BUILDDIR)/$(LINUX_FIRMWARE)
LINUX_FIRMWARE_DEVPKG	:= NO
LINUX_FIRMWARE_LICENSE	:= proprietary

# Order: find -type f \( -name "*LICENSE*" -o -name "*LICENCE*" \)
LINUX_FIRMWARE_LICENSE_FILES := \
	file://LICENCE.xc4000;md5=0ff51d2dc49fce04814c9155081092f0 \
	file://LICENCE.iwlwifi_firmware;md5=2ce6786e0fc11ac6e36b54bb9b799f1b \
	file://LICENSE.dib0700;md5=f7411825c8a555a1a3e5eab9ca773431 \
	file://LICENCE.adsp_sst;md5=615c45b91a5a4a9fe046d6ab9a2df728 \
	file://LICENCE.cadence;md5=009f46816f6956cfb75ede13d3e1cee0 \
	file://LICENSE.amd-ucode;md5=3c5399dc9148d7f0e1f41e34b69cf14f \
	file://LICENSE.atmel;md5=aa74ac0c60595dee4d4e239107ea77a3 \
	file://LICENCE.fw_sst_0f28;md5=6353931c988ad52818ae733ac61cd293 \
	file://LICENSE.amphion_vpu;md5=2bcdc00527b2d0542bd92b52aaec2b60 \
	file://LICENCE.cw1200;md5=f0f770864e7a8444a5c5aa9d12a3a7ed \
	file://LICENCE.moxa;md5=1086614767d8ccf744a923289d3d4261 \
	file://LICENCE.NXP;md5=58bb8ba632cd729b9ba6183bc6aed36f \
	file://LICENSE.i915;md5=2b0b2e0d20984affd4490ba2cba02570 \
	file://LICENSE.ice_enhanced;md5=f305cfc31b64f95f774f9edd9df0224d \
	file://LICENSE.qcom;md5=164e3362a538eb11d3ac51e8e134294b \
	file://LICENCE.ibt_firmware;md5=fdbee1ddfe0fb7ab0b2fcd6b454a366b \
	file://LICENCE.ueagle-atm4-firmware;md5=4ed7ea6b507ccc583b9d594417714118 \
	file://LICENCE.ene_firmware;md5=ed67f0f62f8f798130c296720b7d3921 \
	file://LICENCE.qla2xxx;md5=505855e921b75f1be4a437ad9b79dff0 \
	file://LICENSE.sdma_firmware;md5=51e8c19ecc2270f4b8ea30341ad63ce9 \
	file://LICENCE.qla1280;md5=d6895732e622d950609093223a2c4f5d \
	file://LICENSE.ipu3_firmware;md5=38fe8238c06bf7dcfd0eedbebf452c3b \
	file://LICENCE.go7007;md5=c0bb9f6aaaba55b0529ee9b30aa66beb \
	file://LICENCE.mediatek;md5=7c1976b63217d76ce47d0a11d8a79cf2 \
	file://LICENCE.cavium_liquidio;md5=ff2c835a7bb99e8e9048ab13b94e43eb \
	file://LICENCE.kaweth;md5=b1d876e562f4b3b8d391ad8395dfe03f \
	file://LICENCE.Marvell;md5=28b6ed8bd04ba105af6e4dcd6e997772 \
	file://LICENSE.QualcommAtheros_ar3k;md5=b5fe244fb2b532311de1472a3bc06da5 \
	file://LICENCE.xc5000c;md5=12b02efa3049db65d524aeb418dd87ca \
	file://LICENCE.xc5000;md5=1e170c13175323c32c7f4d0998d53f66 \
	file://LICENCE.open-ath9k-htc-firmware;md5=1b33c9f4d17bc4d457bdb23727046837 \
	file://LICENCE.nvidia;md5=4428a922ed3ba2ceec95f076a488ce07 \
	file://LICENCE.e100;md5=ec0f84136766df159a3ae6d02acdf5a8 \
	file://LICENCE.ralink_a_mediatek_company_firmware;md5=728f1a85fd53fd67fa8d7afb080bc435 \
	file://LICENCE.ti-keystone;md5=3a86335d32864b0bef996bee26cc0f2c \
	file://LICENSE.amd-sev;md5=e750538791a8be0b7249c579edefb035 \
	file://LICENSE.amdgpu;md5=44c1166d052226cb2d6c8d7400090203 \
	file://LICENCE.agere;md5=af0133de6b4a9b2522defd5f188afd31 \
	file://LICENCE.siano;md5=4556c1bf830067f12ca151ad953ec2a5 \
	file://LICENCE.broadcom_bcm43xx;md5=3160c14df7228891b868060e1951dfbc \
	file://LICENCE.rtlwifi_firmware.txt;md5=00d06cfd3eddd5a2698948ead2ad54a5 \
	file://LICENCE.ralink-firmware.txt;md5=ab2c269277c45476fb449673911a2dfd \
	file://LICENSE.QualcommAtheros_ath10k;md5=cb42b686ee5f5cb890275e4321db60a8 \
	file://LICENCE.cavium;md5=c37aaffb1ebe5939b2580d073a95daea \
	file://LICENSE.amlogic_vdec;md5=dc44f59bf64a81643e500ad3f39a468a \
	file://LICENCE.microchip;md5=db753b00305675dfbf120e3f24a47277 \
	file://LICENSE.radeon;md5=68ec28bacb3613200bca44f404c69b16 \
	file://LICENCE.cnm;md5=93b67e6bac7f8fec22b96b8ad0a1a9d0 \
	file://LICENCE.wl1251;md5=ad3f81922bb9e197014bb187289d3b5b \
	file://LICENCE.via_vt6656;md5=e4159694cba42d4377a912e78a6e850f \
	file://LICENCE.chelsio_firmware;md5=819aa8c3fa453f1b258ed8d168a9d903 \
	file://LICENSE.hfi1_firmware;md5=5e7b6e586ce7339d12689e49931ad444 \
	file://LICENSE.Lontium;md5=4ec8dc582ff7295f39e2ca6a7b0be2b6 \
	file://LICENCE.rockchip;md5=5fd70190c5ed39734baceada8ecced26 \
	file://LICENCE.it913x;md5=1fbf727bfb6a949810c4dbfa7e6ce4f8 \
	file://LICENCE.OLPC;md5=5b917f9d8c061991be4f6f5f108719cd \
	file://LICENCE.qat_firmware;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
	file://LICENSE.ice;md5=742ab4850f2670792940e6d15c974b2f \
	file://LICENCE.myri10ge_firmware;md5=42e32fb89f6b959ca222e25ac8df8fed \
	file://LICENCE.Netronome;md5=4add08f2577086d44447996503cddf5f \
	file://LICENCE.phanfw;md5=954dcec0e051f9409812b561ea743bfa \
	file://LICENCE.ca0132;md5=209b33e66ee5be0461f13d31da392198 \
	file://LICENCE.Abilis;md5=b5ee3f410780e56711ad48eadc22b8bc \
	file://LICENCE.atheros_firmware;md5=30a14c7823beedac9fa39c64fdd01a13 \
	file://LICENCE.ti-connectivity;md5=c5e02be633f1499c109d1652514d85ec \
	file://LICENCE.r8a779x_usb3;md5=4c1671656153025d7076105a5da7e498 \
	file://LICENCE.cypress;md5=48cd9436c763bf873961f9ed7b5c147b \
	file://wfx/LICENCE.wf200;md5=4d1beff00d902c05c9c7e95a5d8eb52d \
	file://LICENSE.nxp_mc_firmware;md5=9dc97e4b279b3858cae8879ae2fe5dd7 \
	file://LICENCE.IntcSST2;md5=9e7d8bea77612d7cc7d9e9b54b623062 \
	file://LICENCE.ti-tspa;md5=d1a0eb27d0020752040190b9d51ad9be

LINUX_FIRMWARE_SELECTED_LICENSES := $(call remove_quotes, $(PTXCONF_LINUX_FIRMWARE_SELECTED_LICENSES))
ifneq ($(LINUX_FIRMWARE_SELECTED_LICENSES),)
LINUX_FIRMWARE_LICENSE_FILES := $(filter $(addsuffix %,$(addprefix file://,$(LINUX_FIRMWARE_SELECTED_LICENSES))),$(LINUX_FIRMWARE_LICENSE_FILES))
endif

LINUX_FIRMWARE_SELECTED_FIRMWARES = $(call remove_quotes, $(PTXCONF_LINUX_FIRMWARE_SELECTED_FIRMWARES))

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

LINUX_FIRMWARE_CONF_TOOL	:= NO

$(STATEDIR)/linux-firmware.compile:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/linux-firmware.targetinstall:
	@$(call targetinfo)

	@$(call install_init, linux-firmware)
	@$(call install_fixup, linux-firmware,PRIORITY,optional)
	@$(call install_fixup, linux-firmware,SECTION,base)
	@$(call install_fixup, linux-firmware,AUTHOR,"Christian Melki <christian.melki@t2data.com>")
	@$(call install_fixup, linux-firmware,DESCRIPTION,missing)

ifneq ($(LINUX_FIRMWARE_SELECTED_FIRMWARES),)
	@$(foreach firmware, $(LINUX_FIRMWARE_SELECTED_FIRMWARES), \
		$(call install_glob, linux-firmware, 0, 0, -, \
			/lib/firmware, $(firmware),, n)$(ptx/nl))
endif

	@$(call install_finish, linux-firmware)

	@$(call touch)

# vim: syntax=make
