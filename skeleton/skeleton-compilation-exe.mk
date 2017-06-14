 include ${MKMK_HOME}/rules/rule-$(LANG)-SUFFIXES.mk
-include ${MKMK_HOME}/vars/var-*.mk
 include ${MKMK_HOME}/rules/rule-$(LANG)-CORE.mk
 include ${MKMK_HOME}/rules/rule-clean.mk
 include ${MKMK_HOME}/rules/rule-install-uninstall.mk
#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/mk/rules/skeleton-compilation-exe.mk'
#include ./.mk/rules/rule-update.mk
 include ${MKMK_HOME}/rules/rule-DEFAULT.mk
