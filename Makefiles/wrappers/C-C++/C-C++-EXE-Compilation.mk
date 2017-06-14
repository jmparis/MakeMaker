 include ${MKMK_HOME}/Makefiles/rules/rule-$(LANG)-SUFFIXES.mk
-include ${MKMK_HOME}/Makefiles/vars/var-*.mk
 include ${MKMK_HOME}/Makefiles/rules/rule-$(LANG)-CORE.mk
 include ${MKMK_HOME}/Makefiles/rules/rule-clean.mk
 include ${MKMK_HOME}/Makefiles/rules/rule-install-uninstall.mk
#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/mk/rules/skeleton-compilation-exe.mk'
#include ./.mk/Makefiles/rules/rule-update.mk
 include ${MKMK_HOME}/Makefiles/rules/rule-DEFAULT.mk
