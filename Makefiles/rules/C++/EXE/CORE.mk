.SUFFIXES:
.SUFFIXES: .cpp .o

# Verbose mode: 0 = Off, 1= On
V		?=	0

# Environment mode: P = Production, R = Release, D = Debug
E		?=	P

ifeq	($(findstring P,$(E)),P)
ENV		=	Production
endif

ifeq	($(findstring R,$(E)),R)
ENV		=	Release
endif

ifeq	($(findstring D,$(E)),D)
ENV		=	Debug
endif

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

SYSTEM	:=	$(shell uname -s)
MACH	:=	$(shell uname -m)
HOSTNAME:=	$(shell hostname)

SRCDIR	?=	$(BASEDIR)/src
OBJDIR	?=	$(BASEDIR)/build-$(SYSTEM)-$(MACH)-$(ENV)/obj
DEPDIR	?=	$(BASEDIR)/build-$(SYSTEM)-$(MACH)-$(ENV)/dep
BINDIR	?=	$(BASEDIR)/build-$(SYSTEM)-$(MACH)-$(ENV)/bin

ifeq ($(OS),Windows_NT)
EXESFX	=	.exe
else
EXESFX	=
endif

EXE		=	$(notdir    ${CURDIR})$(EXESFX)
EXEFILES=	$(BINDIR)/$(EXE)
CPPFILES=	$(wildcard  $(SRCDIR)/*.cpp)
OBJFILES=	$(addprefix $(OBJDIR)/,$(notdir $(CPPFILES:.cpp=.o)))
DEPFILES=	$(addprefix $(DEPDIR)/,$(notdir $(CPPFILES:.cpp=.d)))
DEPFLAGS=	-MM -MT '$@'
DEPEND.cpp = $(CXX)  $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH)


# ------------------
# Compiling C++ rule
# ------------------

# Linking
LINK_CPP_0		=	@printf "Linking.....: \033[1;31m$(EXEFILES)\033[0m\n"; $(LINK.cpp)
LINK_CPP_1		=	$(LINK.cpp)
LINK_CPP		=	$(LINK_CPP_$(V))

$(EXEFILES):	$(OBJFILES) | $(BINDIR)
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(LINK_CPP) $^ $(LOADLIBES) $(LDLIBS) -o $@

# Compiling
COMPILE_CPP_0	=	@printf "Compiling...: $(OBJDIR)/\033[1;35m$(notdir $@)\033[0m\n"; $(COMPILE.cpp)
COMPILE_CPP_1	=	$(COMPILE.cpp)
COMPILE_CPP		=	$(COMPILE_CPP_$(V))

DEPEND_CPP_0	=	@printf "Dependancies: $(DEPDIR)/\033[1;34m$*.d\033[0m\n"; $(DEPEND.cpp)
DEPEND_CPP_1	=	$(DEPEND.cpp)
DEPEND_CPP		=	$(DEPEND_CPP_$(V))

$(OBJDIR)/%.o:	$(SRCDIR)/%.cpp | $(OBJDIR) $(DEPDIR)
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(COMPILE_CPP)	$(OUTPUT_OPTION) $<
	@printf $(PRT_TAB) " " ""
	$(DEPEND_CPP)	$< > $(DEPDIR)/$*.d

-include $(DEPFILES)

$(OBJDIR):
	@mkdir	-p	$(OBJDIR)

$(DEPDIR):
	@mkdir	-p	$(DEPDIR)

$(BINDIR):
	@mkdir	-p	$(BINDIR)


###
DEL_OBJS_C	=	rm -f	$(EXEFILES) $(OBJFILES)	$(DEPFILES)
DEL_OBJS_0	=	@printf "Removing....: \033[1;35m$(OBJFILES)\033[0m \033[1;34m$(DEPFILES)\033[0m \033[1;31m$(EXEFILES)\033[0m\n"; $(DEL_OBJS_C)
DEL_OBJS_1	=	$(DEL_OBJS_C)
DEL_OBJS	=	$(DEL_OBJS_$(V))

###

ifeq	($(dir $(OBJDIR)), ./)
DEL_DIRS_C	=	rm -fd	$(OBJDIR) $(DEPDIR) $(BINDIR)
else
DEL_DIRS_C	=	rm -fd	$(OBJDIR) $(DEPDIR) $(BINDIR); rm -fd $(sort $(dir $(OBJDIR) $(DEPDIR) $(BINDIR)))
endif
DEL_DIRS_0	=	@printf "Removing....: \033[1;31m$(OBJDIR) $(DEPDIR) $(BINDIR)\033[0m\n"; $(DEL_DIRS_C)
DEL_DIRS_1	=	$(DEL_DIRS_C)
DEL_DIRS	=	$(DEL_DIRS_$(V))

###

.PHONY:	clean
clean:
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(DEL_OBJS)
	@printf $(PRT_TAB) " " ""
	$(DEL_DIRS)
