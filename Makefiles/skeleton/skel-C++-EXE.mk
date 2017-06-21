include ${MKMK_HOME}/Makefiles/rules/$(LANG)/rule-SUFFIXES.mk
-include ./.mkmk/config*.mk
include ${MKMK_HOME}/Makefiles/rules/$(LANG)/rule-CORE.mk

help::
	@printf "\r"
	@printf $(PRT_TAB) " " "The supported targets are:\n"
	@printf $(PRT_TAB) " " "make............: to compile project\n"
	@printf $(PRT_TAB) " " "make clean......: to clean project\n"
	@printf $(PRT_TAB) " " "make install....: to install project\n"
	@printf $(PRT_TAB) " " "make uninstall..: to remove project from system\n"

include ${MKMK_HOME}/Makefiles/rules/rule-clean.mk
include ${MKMK_HOME}/Makefiles/rules/rule-install-uninstall.mk
#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/mk/rules/skeleton-compilation-exe.mk'
#include ./.mk/Makefiles/rules/rule-update.mk
include ${MKMK_HOME}/Makefiles/rules/rule-DEFAULT.mk
