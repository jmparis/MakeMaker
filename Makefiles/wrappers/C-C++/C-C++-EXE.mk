include ${MKMK_HOME}/Makefiles/rules/$(LANG)/rule-SUFFIXES.mk
#-include ./.makefile.mk
include ${MKMK_HOME}/Makefiles/rules/$(LANG)/rule-CORE.mk
include ${MKMK_HOME}/Makefiles/rules/rule-clean.mk
include ${MKMK_HOME}/Makefiles/rules/rule-install-uninstall.mk
#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/mk/rules/skeleton-compilation-exe.mk'
#include ./.mk/Makefiles/rules/rule-update.mk
include ${MKMK_HOME}/Makefiles/rules/rule-DEFAULT.mk
