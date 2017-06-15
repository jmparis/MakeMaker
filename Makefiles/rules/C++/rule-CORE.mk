BASEDIR	=	.

SRCDIR	=	$(BASEDIR)/src
OBJDIR	=	$(BASEDIR)/obj
DEPDIR	=	$(BASEDIR)/obj
BINDIR	=	$(BASEDIR)/bin

EXE		=	$(notdir    ${CURDIR})
CPPFILES=	$(wildcard  $(SRCDIR)/*.cpp)
OBJFILES=	$(addprefix $(OBJDIR)/,$(notdir $(CPPFILES:.cpp=.o)))
DEPFILES=	$(OBJFILES:.o=.d)
DEPFLAGS=	-MM -MT '$@'
DEPEND.cpp = $(CXX)  $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH)

$(OBJDIR)/%.o:	$(SRCDIR)/%.cpp | $(OBJDIR)
	$(COMPILE.cpp) $(OUTPUT_OPTION) $<
	$(DEPEND.cpp) $< > $(DEPDIR)/$*.d

-include $(DEPFILES)

$(BINDIR)/$(EXE):	$(OBJFILES) | $(BINDIR)
	$(LINK.cpp) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(OBJDIR):
	@mkdir	$(OBJDIR)

$(BINDIR):
	@mkdir	$(BINDIR)