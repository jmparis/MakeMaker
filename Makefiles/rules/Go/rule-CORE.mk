BASEDIR	=	.

SRCDIR	=	$(BASEDIR)/src

GOFILES	=	$(wildcard  $(SRCDIR)/*.go)

.DEFAULT_GOAL := Please_make_run

.IGNORE: run
run:
	go run $(GOFILES)

Please_make_run:
