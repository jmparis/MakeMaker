PREFIX = /usr/local

.PHONY:	install
install:	$(BINDIR)/$(EXE)
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp	$<	$(DESTDIR)$(PREFIX)/bin/$(EXE)

.PHONY:	uninstall
uninstall:
	rm -f	$(DESTDIR)$(PREFIX)/bin/$(EXE)

help::
	@printf $(PRT_TAB) " " "make install....: to install project\n"
	@printf $(PRT_TAB) " " "make uninstall..: to remove project from system\n"
