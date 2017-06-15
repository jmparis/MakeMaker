# Makefiles
Various makefiles for many purposes

## Keep your local Makefiles updated

Within each __Makefile__ available from this Git repository; I've added a specific target '__update__'.

Each time you run a `> make update` command, the __local__ Makefile is checked against the one available in the _master_ branch
of the repository. The `> make update` command do a kind of basic 'pull' from the Git __Makefiles__ repository.

The implementation uses a simple `wget` command to retrieve the latest Makefile available on the _Master_ branch.
