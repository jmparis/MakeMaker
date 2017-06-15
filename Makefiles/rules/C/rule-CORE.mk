BASEDIR	=	.

SRCDIR	=	$(BASEDIR)/src
OBJDIR	=	$(BASEDIR)/obj
DEPDIR	=	$(BASEDIR)/obj
BINDIR	=	$(BASEDIR)/bin

EXE		=	$(notdir    ${CURDIR})
CFILES	=	$(wildcard  $(SRCDIR)/*.c)
OBJFILES=	$(addprefix $(OBJDIR)/,$(notdir $(CFILES:.c=.o)))
DEPFILES=	$(OBJFILES:.o=.d)
DEPFLAGS=	-MM -MT '$@'
DEPEND.c=	$(CC)  $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH)

$(OBJDIR)/%.o:	$(SRCDIR)/%.c | $(OBJDIR)
	$(COMPILE.c) $(OUTPUT_OPTION) $<
	$(DEPEND.c) $< > $(DEPDIR)/$*.d

-include $(DEPFILES)

$(BINDIR)/$(EXE):	$(OBJFILES) | $(BINDIR)
	$(LINK.c) $^ $(LOADLIBES) $(LDLIBS) -o $@

$(OBJDIR):
	@mkdir	$(OBJDIR)

$(BINDIR):
	@mkdir	$(BINDIR)