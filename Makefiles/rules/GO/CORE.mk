.SUFFIXES:
.SUFFIXES: .go

BASEDIR	=	.

SRCDIR	=	$(BASEDIR)/src

GOFILES	=	$(wildcard  $(SRCDIR)/*.go)

.DEFAULT_GOAL := Please_make_run

.IGNORE: run
run:
	go run $(GOFILES)

Please_make_run:

# By default, Verbose is desactivated
V	?=	0

PRT_TAB		:=	%$(shell echo \($(MAKELEVEL) + 1 \) \* 2 | bc)b%b


.PHONY:	clean
clean:
	@printf "\r"
	@printf $(PRT_TAB) " " "Nothing to remove\n"
