################################################################################
#
# mytest
#
################################################################################

MYTEST_VERSION = 1.0
MYTEST_SITE = $(TOPDIR)/mytest
MYTEST_SOURCE = "apps modules"
MYTEST_SITE_METHOD = local
MYTEST_LICENSE = GPLv3+
MYTEST_LICENSE_FILES = COPYING

MYTEST_MODULE_SUBDIRS = modules
MY_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED) KERNEL_DIR=$(LINUX_DIR)

define MYTEST_EXTRACT_CMDS
	cp -a $(TOPDIR)/$(MYTEST_SOURCE) $(@D)
endef

define MYTEST_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D)/apps all
endef

define MYTEST_INSTALL_TARGET_CMDS
	for app in $(shell ls $(@D)/apps/build); do \
		$(INSTALL) -D -m 0755 $(@D)/apps/build/$$app $(TARGET_DIR)/usr/bin; \
	done
	$(INSTALL) -D -m 0755 $(@D)/apps/udbgd $(TARGET_DIR)/usr/bin
endef

$(eval $(kernel-module))
$(eval $(generic-package))
