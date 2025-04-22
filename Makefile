ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FridaGadgetLoader

FridaGadgetLoader_FILES = Tweak.xm
FridaGadgetLoader_CFLAGS = -fobjc-arc
FridaGadgetLoader_EXTRA_FRAMEWORKS = CydiaSubstrate

FRIDA_VERSION = 16.2.1
GADGET_URL = https://github.com/frida/frida/releases/download/$(FRIDA_VERSION)/frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib.xz

before-all::
	@curl -L $(GADGET_URL) | xz -d > FridaGadget.dylib
	@codesign -f -s "Apple Development" FridaGadget.dylib

after-install::
	install.exec "echo '{
	  \"interaction\": {
	    \"type\": \"listen\",
	    \"address\": \"127.0.0.1\",
	    \"port\": 27042
	  }
	}' > /usr/lib/frida-gadget.config.json"

include $(THEOS_MAKE_PATH)/tweak.mk
