# Installs to /usr/local/bin
# Change variables to adjust locations
#
# Jun 24 2016 - Gustavo Neves

IDIR=/usr/local/bin
IFILE=$(IDIR)/TymeMotD

BCIDIR=bash_completion.d
BCIFILE=$(BCIDIR)/TymeMotD

BCODIR=/etc/bash_completion.d
BCOFILE=$(BCODIR)/TymeMotD

CRONSOURCE=cron.d/TymeMotD
CRONDIR=/etc/cron.d
CRONFILE=$(CRONDIR)/TymeMotD

all: install bash_completion cron

install:
	cp TymeMotD $(IFILE)
	chmod 755 $(IFILE)

bash_completion:
	cp $(BCIFILE) $(BCOFILE)

cron:
	cp $(CRONSOURCE) $(CRONFILE)

uninstall:
	rm -f $(IFILE)
	rm -f $(BCOFILE)
