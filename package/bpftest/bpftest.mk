################################################################################
#
# bpf-test
#
################################################################################

BPFTEST_VERSION = 1.0
BPFTEST_SITE = $(TOPDIR)/../bpftest
BPFTEST_SOURCE = "apps modules"
BPFTEST_SITE_METHOD = local
BPFTEST_LICENSE = GPLv3+
BPFTEST_LICENSE_FILES = COPYING

BPFTEST_MODULE_SUBDIRS = modules
BPF_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED) KERNEL_DIR=$(LINUX_DIR)

define BPFTEST_EXTRACT_CMDS
	cp -a $(TOPDIR)/$(BPFTEST_SOURCE) $(@D)
endef

define BPFTEST_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/apps all
endef

define BPFTEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/apps/hello $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0755 $(@D)/apps/setjmp $(TARGET_DIR)/usr/bin
endef

$(eval $(kernel-module))
$(eval $(generic-package))
