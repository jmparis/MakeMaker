TOPTARGETS	:=	all clean clobber install uninstall run help update
SUBDIRS		:=	$(sort $(wildcard */.))

PRT_TAB		:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b

.PHONY:	$(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS):	$(SUBDIRS)
$(SUBDIRS):
	@printf "\r"
	@printf $(PRT_TAB) " " "\033[1;34m[\033[1;35m$@\033[1;34m]\033[0m\n"
	@printf $(PRT_TAB) " " ""
	@$(MAKE) --no-print-directory -C $@ $(MAKECMDGOALS)
#	@printf $(PRT_TAB) "\b" ""


#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/Makefile-folders.mk'
#include ./.mk/rules/rule-update.mk

include ${MKMK_HOME}/Makefiles/rules/rule-DEFAULT-verbose.mk
