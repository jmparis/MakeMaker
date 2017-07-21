-include ./.mkmk/config*.mk

include ${MKMK_HOME}/Makefiles/rules/$(LANG)/$(TYPE)/CORE.mk

help::
	@printf "\r"
	@printf $(PRT_TAB) " " "The supported targets are:\n"
	@printf $(PRT_TAB) " " "make............: to compile project\n"
	@printf $(PRT_TAB) " " "make clean......: to clean project\n"

include ${MKMK_HOME}/Makefiles/rules/rule-install-uninstall.mk

#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/mk/rules/skeleton-compilation-exe.mk'
#include ./.mk/Makefiles/rules/rule-update.mk

include ${MKMK_HOME}/Makefiles/rules/DEFAULT.mk
