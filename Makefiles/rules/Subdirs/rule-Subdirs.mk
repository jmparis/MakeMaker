TOPTARGETS	:=	clean clobber install uninstall run update
NODIRS		?=
SUBDIRS		:=	$(sort $(filter-out $(addsuffix /,$(NODIRS)),$(wildcard */)))

PRT_TAB		:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b

.PHONY:	$(TOPTARGETS) help $(SUBDIRS)

$(TOPTARGETS):	$(SUBDIRS)

$(SUBDIRS):
	@printf "\r"
	@printf $(PRT_TAB) " " "\033[1;34m[\033[1;35m$@\033[1;34m]\033[0m\n"
	@printf $(PRT_TAB) " " ""
	@$(MAKE) --no-print-directory -C $@ $(MAKECMDGOALS)
#	@printf $(PRT_TAB) "\b" ""

help:	folders_man	$(SUBDIRS)

folders_man:
	@printf "\r"
	@printf $(PRT_TAB) " " "The supported targets are:\n"
	@printf $(PRT_TAB) " " "make............: to compile all subprojects\n"
	@printf $(PRT_TAB) " " "make clean......: to clean all subprojects\n"
	@printf $(PRT_TAB) " " "make install....: to install subprojects\n"
	@printf $(PRT_TAB) " " "make uninstall..: to remove subprojects from system\n"
