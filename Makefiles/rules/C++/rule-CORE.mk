V		?=	0
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

BASEDIR	?=	.
HOSTNAME:=	$(shell hostname)

SRCDIR	?=	$(BASEDIR)/src
OBJDIR	?=	$(BASEDIR)/build-$(HOSTNAME)-$(ENV)/obj
DEPDIR	?=	$(BASEDIR)/build-$(HOSTNAME)-$(ENV)/dep
BINDIR	?=	$(BASEDIR)/build-$(HOSTNAME)-$(ENV)/bin

EXE		=	$(notdir    ${CURDIR})
CPPFILES=	$(wildcard  $(SRCDIR)/*.cpp)
OBJFILES=	$(addprefix $(OBJDIR)/,$(notdir $(CPPFILES:.cpp=.o)))
DEPFILES=	$(addprefix $(DEPDIR)/,$(notdir $(CPPFILES:.cpp=.d)))
#DEPFILES=	$(OBJFILES:.o=.d)
DEPFLAGS=	-MM -MT '$@'
DEPEND.cpp = $(CXX)  $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH)

###

PRT_TAB		:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b

###

LINK_CPP_0		=	@printf "Linking.....: $(BINDIR)/\033[1;31m$(EXE)\033[0m\n"; $(LINK.cpp)
LINK_CPP_1		=	$(LINK.cpp)
LINK_CPP		=	$(LINK_CPP_$(V))

$(BINDIR)/$(EXE):	$(OBJFILES) | $(BINDIR)
	@printf "\r"
	@printf $(PRT_TAB) " " ""
	$(LINK_CPP) $^ $(LOADLIBES) $(LDLIBS) -o $@

###

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