ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0
THEOS_DEVICE_IP = 127.0.0.1 -p 2222

FRIDA_VERSION = 16.2.1
GADGET_URL = https://github.com/frida/frida/releases/download/$(FRIDA_VERSION)/frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib.xz

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FridaGadgetLoader

FridaGadgetLoader_FILES = Tweak.xm
FridaGadgetLoader_CFLAGS = -fobjc-arc
FridaGadgetLoader_EXTRA_FRAMEWORKS = CydiaSubstrate
FridaGadgetLoader_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
    # Download and prepare FridaGadget
    wget $(GADGET_URL) -O frida-gadget.xz
    xz -d frida-gadget.xz
    mv frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib FridaGadget.dylib
    codesign -f -s "Apple Development" FridaGadget.dylib
    mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries
    cp FridaGadget.dylib $(THEOS_STAGING_DIR)/usr/lib/FridaGadget.dylib
