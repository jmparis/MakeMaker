.PHONY:	clean
clean:
	rm -f	$(OBJFILES) $(DEPFILES) $(BINDIR)/$(EXE)
	@rm -fd	$(OBJDIR)   $(DEPDIR)   $(BINDIR)
