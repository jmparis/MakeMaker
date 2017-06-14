update:
	@curl --silent $(UPDATE_URL) > ./Makefile.new
	@diff ./Makefile ./Makefile.new ; \
	if test $$? -eq 1 ; \
	then \
		cp ./Makefile.new ./Makefile ; \
		printf %.$(MAKELEVEL)b%b " " "Makefile updated!\n" ; \
	else \
		printf %.$(MAKELEVEL)b%b " " "Makefile is already up to date\n" ; \
	fi ;
	@rm -f ./Makefile.new
