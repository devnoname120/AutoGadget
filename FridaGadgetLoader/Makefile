ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FridaGadgetLoader

FridaGadgetLoader_FILES = Tweak.xm
FridaGadgetLoader_CFLAGS = -fobjc-arc
FridaGadgetLoader_EXTRA_FRAMEWORKS = CydiaSubstrate

FRIDA_VERSION = 16.7.13
FRIDA_GADGET = frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib
FRIDA_URL = https://github.com/frida/frida/releases/download/$(FRIDA_VERSION)/$(FRIDA_GADGET).xz

internal-stage::
    # AutoFLEX-ähnlicher Download-Mechanismus
    $(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/usr/lib$(ECHO_END)
    $(ECHO_NOTHING)curl -L $(FRIDA_URL) | xz -d > $(THEOS_STAGING_DIR)/usr/lib/FridaGadget.dylib$(ECHO_END)
    $(ECHO_NOTHING)codesign -f -s "Apple Development" $(THEOS_STAGING_DIR)/usr/lib/FridaGadget.dylib$(ECHO_END)

include $(THEOS_MAKE_PATH)/tweak.mk
