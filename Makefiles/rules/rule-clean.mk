# By default, Verbose is desactivated
V	?=	0

PRT_TAB		=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b

###

DEL_OBJS_C	=	rm -f	$(OBJFILES)	$(DEPFILES)	$(BINDIR)/$(EXE)
DEL_OBJS_0	=	@printf "Removing....: $(OBJFILES) $(DEPFILES) $(BINDIR)/$(EXE)\n"; printf $(PRT_TAB) " " ""; $(DEL_OBJS_C)
DEL_OBJS_1	=	$(DEL_OBJS_C)
DEL_OBJS	=	$(DEL_OBJS_$(V))

###

DEL_DIRS_C	=	rm -rfd	$(OBJDIR)   $(DEPDIR)   $(BINDIR)
DEL_DIRS_0	=	@printf "Removing....: $(OBJDIR) $(DEPDIR) $(BINDIR)\n"; printf $(PRT_TAB) " " ""; $(DEL_DIRS_C)
DEL_DIRS_1	=	$(DEL_DIRS_C)
DEL_DIRS	=	$(DEL_DIRS_$(V))

###

.PHONY:	clean
clean:	first_tab
	$(DEL_OBJS)
	$(DEL_DIRS)
