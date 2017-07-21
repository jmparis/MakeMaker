# Keep update Makefile

PRT_TAB		:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b

Makefile:	${MKMK_HOME}/Makefiles/wrappers/${LANG}/${TYPE}/Makefile
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	@cp -f $< $@
	@printf "\033[1;31m$@ updated!\033[0m\n"
	@printf $(PRT_TAB) " " ""
