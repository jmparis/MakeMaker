TOPTARGETS	:=	all clean clobber install uninstall run help update
SUBDIRS		:=	$(wildcard */.)

.PHONY:	$(TOPTARGETS) $(SUBDIRS)
$(TOPTARGETS):	$(SUBDIRS)
$(SUBDIRS):
	@printf %.$(MAKELEVEL)b%b " " "\033[1;34m[\033[1;35m$@\033[1;34m]\033[0m\n"
	@$(MAKE) --no-print-directory -C $@ $(MAKECMDGOALS)

#UPDATE_URL = 'https://raw.githubusercontent.com/jmparis/Makefiles/master/Makefile-folders.mk'
#include ./.mk/rules/rule-update.mk
include ${MKMK_HOME}/Makefiles/rules/rule-DEFAULT.mk
