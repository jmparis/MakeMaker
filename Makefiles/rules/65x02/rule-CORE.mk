.SUFFIXES:					# Delete the default suffixes
.SUFFIXES: .o .lst .d .s	# Define our suffix list

V		?=	0
PRT_TAB	:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b


# -----------------------
# Compute Folders & Files
# -----------------------
BASEDIR	?=	.
SRCDIR	?=	$(BASEDIR)/src
OBJDIR	?=	$(BASEDIR)/build/obj
LSTDIR	?=	$(BASEDIR)/build/lst
DEPDIR	?=	$(BASEDIR)/build/dep

SFILES	=	$(wildcard  $(SRCDIR)/*.s)
OBJFILES=	$(addprefix $(OBJDIR)/,$(notdir $(SFILES:.s=.o)))
LSTFILES=	$(addprefix $(LSTDIR)/,$(notdir $(SFILES:.s=.lst)))
DEPFILES=	$(addprefix $(DEPDIR)/,$(notdir $(SFILES:.s=.d)))


all:	$(OBJFILES) $(LSTFILES)
-include	$(DEPFILES)


# ---------------
# Assembling rule
# ---------------

# Default variables, can be overriden outside
AS_ARCH	?=	ca65
TGT_ARCH?=	apple2
CPU_ARCH?=	65C02
MM_ARCH	?=	near
LST_BYT	?=	0
PG_LEN	?=	-1
INCDIR	?=	.
DEFINES	?=

# Prepare the internal make COMPILE.s variable
AS		=	$(AS_ARCH)
ASFLAGS	=	--verbose
ASFLAGS	+=	$(addprefix -D ,$(DEFINES)) --include-dir $(INCDIR)
ASFLAGS	+=	--listing $(LSTDIR)/$*.lst --list-bytes $(LST_BYT) --pagelength $(PG_LEN)
ASFLAGS	+=	--create-dep $(DEPDIR)/$*.d
TARGET_MACH	=	--target $(TGT_ARCH) --cpu $(CPU_ARCH) --memory-model $(MM_ARCH)

COMPILE_S_0	=	@printf "Assembling..: $(OBJDIR)/\033[1;35m$(notdir $@)\033[0m\n"; $(COMPILE.s)
COMPILE_S_1	=	$(COMPILE.s)
COMPILE_S	=	$(COMPILE_S_$(V))

$(OBJDIR)/%.o $(LSTDIR)/%.lst: $(SRCDIR)/%.s | $(OBJDIR) $(LSTDIR) $(DEPDIR)
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(COMPILE_S) -o $@ $<


# --------------
# create & clean
# --------------

$(OBJDIR):
ifneq	($(OBJDIR), .)
	@mkdir	-p	$(OBJDIR)
endif
$(LSTDIR):
ifneq	($(LSTDIR), .)
	@mkdir	-p	$(LSTDIR)
endif
$(DEPDIR):
ifneq	($(DEPDIR), .)
	@mkdir	-p	$(DEPDIR)
endif

comma	:= ,
empty	:=
space	:= $(empty) $(empty)
tab		:= $(empty)	$(empty)

DEL_OBJFILES_C	=	rm	$(OBJFILES)
DEL_OBJFILES_0	=	@printf "Removing....: \033[1;35m$(subst $(space),$(tab),$(OBJFILES))\033[0m\n"; $(DEL_OBJFILES_C)
DEL_OBJFILES_1	=	$(DEL_OBJFILES_C)
DEL_OBJFILES	=	$(DEL_OBJFILES_$(V))

DEL_LSTFILES_C	=	rm	$(LSTFILES)
DEL_LSTFILES_0	=	@printf "Removing....: \033[1;34m$(subst $(space),$(tab),$(LSTFILES))\033[0m\n"; $(DEL_LSTFILES_C)
DEL_LSTFILES_1	=	$(DEL_LSTFILES_C)
DEL_LSTFILES	=	$(DEL_LSTFILES_$(V))

DEL_DEPFILES_C	=	rm	$(DEPFILES)
DEL_DEPFILES_0	=	@printf "Removing....: \033[1;34m$(subst $(space),$(tab),$(DEPFILES))\033[0m\n"; $(DEL_DEPFILES_C)
DEL_DEPFILES_1	=	$(DEL_DEPFILES_C)
DEL_DEPFILES	=	$(DEL_DEPFILES_$(V))

ALL_DIRS		:=	$(sort $(OBJDIR) $(LSTDIR) $(DEPDIR))
ALL_DIR_DIRS	:=	$(sort $(dir $(OBJDIR) $(LSTDIR) $(DEPDIR)))

DEL_ALL_DIRS_C	=	rmdir	$(ALL_DIRS)
DEL_ALL_DIRS_0	=	@printf "Removing....: \033[1;32m$(ALL_DIRS)\033[0m\n"; $(DEL_ALL_DIRS_C)
DEL_ALL_DIRS_1	=	$(DEL_ALL_DIRS_C)
DEL_ALL_DIRS	=	$(DEL_ALL_DIRS_$(V))

DEL_ALL_PDIRS_C	=	rmdir	$(ALL_DIR_DIRS)
DEL_ALL_PDIRS_0	=	@printf "Removing....: \033[1;32m$(ALL_DIR_DIRS)\033[0m\n"; $(DEL_ALL_PDIRS_C)
DEL_ALL_PDIRS_1	=	$(DEL_ALL_PDIRS_C)
DEL_ALL_PDIRS	=	$(DEL_ALL_PDIRS_$(V))

clean:	all
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(DEL_OBJFILES)
	@printf $(PRT_TAB) " " ""
	$(DEL_LSTFILES)
	@printf $(PRT_TAB) " " ""
	$(DEL_DEPFILES)
ifneq	($(ALL_DIRS), .)
	@printf $(PRT_TAB) " " ""
	$(DEL_ALL_DIRS)
endif
ifneq	($(ALL_DIR_DIRS), ./)
	@printf $(PRT_TAB) " " ""
	$(DEL_ALL_PDIRS)
endif
