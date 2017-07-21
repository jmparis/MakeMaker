-include ./.mkmk/config*.mk

include ${MKMK_HOME}/Makefiles/rules/$(LANG)/$(TYPE)/CORE.mk

include ${MKMK_HOME}/Makefiles/rules/DEFAULT.mk
