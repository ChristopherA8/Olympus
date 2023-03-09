TARGET := iphone:clang:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
export THEOS_DEVICE_IP=192.168.50.231

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Olympus

$(TWEAK_NAME)_FILES = Tweak.xm
$(TWEAK_NAME)_PRIVATE_FRAMEWORKS = SpringBoardFoundation MobileCoreServices
$(TWEAK_NAME)_EXTRA_FRAMEWORKS = Cephei
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += olympusprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
