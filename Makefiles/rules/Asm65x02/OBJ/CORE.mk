.SUFFIXES:					# Delete the default suffixes
.SUFFIXES: .o .lst .d .s	# Define our suffix list

# Verbose mode: 0 = Off, 1= On
V		?=	0

# Helper variables for display
PRT_TAB	:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b
comma	:= ,
empty	:=
space	:= $(empty) $(empty)
tab		:= $(empty)	$(empty)
.print_r:
	@printf "\r"



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

$(OBJDIR)/%.o $(LSTDIR)/%.lst: $(SRCDIR)/%.s | .print_r $(OBJDIR) $(LSTDIR) $(DEPDIR)
	@printf $(PRT_TAB) " " ""
	$(COMPILE_S) -o $@ $<


# --------------
# create & clean
# --------------

CRE_OBJDIR_C	=	mkdir	-p	$(OBJDIR)
CRE_OBJDIR_0	=	printf "Creating....: \033[1;32m$(OBJDIR)\033[0m\n"; $(CRE_OBJDIR_C)
CRE_OBJDIR_1	=	printf "mkdir	-p	$(OBJDIR)"; $(CRE_OBJDIR_C); printf "\n"
CRE_OBJDIR		=	$(CRE_OBJDIR_$(V))
$(OBJDIR):
ifneq	($(OBJDIR), .)
	@printf $(PRT_TAB) " " ""
	@$(CRE_OBJDIR)
endif

CRE_LSTDIR_C	=	mkdir	-p	$(LSTDIR)
CRE_LSTDIR_0	=	printf "Creating....: \033[1;32m$(LSTDIR)\033[0m\n"; $(CRE_LSTDIR_C)
CRE_LSTDIR_1	=	printf "mkdir	-p	$(LSTDIR)"; $(CRE_LSTDIR_C); printf "\n"
CRE_LSTDIR		=	$(CRE_LSTDIR_$(V))
$(LSTDIR):
ifneq	($(LSTDIR), .)
	@printf $(PRT_TAB) " " ""
	@$(CRE_LSTDIR)
endif

CRE_DEPDIR_C	=	mkdir	-p	$(DEPDIR)
CRE_DEPDIR_0	=	printf "Creating....: \033[1;32m$(DEPDIR)\033[0m\n"; $(CRE_DEPDIR_C)
CRE_DEPDIR_1	=	printf "mkdir	-p	$(DEPDIR)"; $(CRE_DEPDIR_C); printf "\n"
CRE_DEPDIR		=	$(CRE_DEPDIR_$(V))
$(DEPDIR):
ifneq	($(DEPDIR), .)
	@printf $(PRT_TAB) " " ""
	@$(CRE_DEPDIR)
endif

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

clean:	all .print_r
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
