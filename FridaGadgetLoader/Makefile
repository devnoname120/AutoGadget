ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0

FRIDA_VERSION = 16.7.13
GADGET_URL = https://github.com/frida/frida/releases/download/$(FRIDA_VERSION)/frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib.xz

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FridaGadgetLoader

FridaGadgetLoader_FILES = Tweak.xm
FridaGadgetLoader_CFLAGS = -fobjc-arc
FridaGadgetLoader_EXTRA_FRAMEWORKS = CydiaSubstrate Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	curl -L $(GADGET_URL) -o frida-gadget.xz || (echo "Download failed"; exit 1)
	xz -d frida-gadget.xz
	mv frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib FridaGadget.dylib
	codesign -f -s "Apple Development" FridaGadget.dylib
	mkdir -p $(THEOS_STAGING_DIR)/usr/lib
	cp FridaGadget.dylib $(THEOS_STAGING_DIR)/usr/lib/
