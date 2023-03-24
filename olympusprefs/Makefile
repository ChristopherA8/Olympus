TARGET := iphone:clang:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = olympusprefs

$(BUNDLE_NAME)_FILES = $(wildcard *.m *.mm *.xm)
$(BUNDLE_NAME)_FRAMEWORKS = UIKit
# $(BUNDLE_NAME)_EXTRA_FRAMEWORKS += AltList
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = Preferences
$(BUNDLE_NAME)_INSTALL_PATH = /Library/PreferenceBundles
$(BUNDLE_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
