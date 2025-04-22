FINALPACKAGE=1

# INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64
# THEOS_PACKAGE_SCHEME=roothide
TARGET = iphone:clang:latest:15.0
include $(THEOS)/makefiles/common.mk

TARGET_CC = xcrun -sdk iphoneos clang
TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++

FRIDA_VERSION = 16.7.13
GADGET_URL = https://github.com/frida/frida/releases/download/$(FRIDA_VERSION)/frida-gadget-$(FRIDA_VERSION)-ios-universal.dylib.xz

TWEAK_NAME = FridaGadgetLoader

FridaGadgetLoader_FILES = Tweak.xm
FridaGadgetLoader_CFLAGS = -fobjc-arc
FridaGadgetLoader_EXTRA_FRAMEWORKS = CydiaSubstrate

include $(THEOS_MAKE_PATH)/tweak.mk

before-package::
	# FridaGadget herunterladen & signieren
	curl -L $(GADGET_URL) | xz -d > FridaGadget.dylib
	codesign -f -s "Apple Development" --entitlements ent.plist FridaGadget.dylib
	
	# Paketstruktur erstellen
	mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries
	mkdir -p $(THEOS_STAGING_DIR)/usr/lib
	
	# Dateien kopieren
	cp FridaGadget.dylib $(THEOS_STAGING_DIR)/usr/lib/
	cp FridaGadgetLoader.plist $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/
