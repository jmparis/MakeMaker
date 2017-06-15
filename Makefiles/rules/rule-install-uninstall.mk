PREFIX = /usr/local

.PHONY:	install
install:	$(BINDIR)/$(EXE)
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp	$<	$(DESTDIR)$(PREFIX)/bin/$(EXE)

.PHONY:	uninstall
uninstall:
	rm -f	$(DESTDIR)$(PREFIX)/bin/$(EXE)
