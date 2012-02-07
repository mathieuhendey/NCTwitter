include theos/makefiles/common.mk

BUNDLE_NAME = NCTwitter
NCTwitter_FILES = NCTwitterController.m
NCTwitter_INSTALL_PATH = /System/Library/WeeAppPlugins/
NCTwitter_FRAMEWORKS = UIKit CoreGraphics Twitter AddressBook AddressBookUI

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
