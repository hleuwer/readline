include config

all:
	cd src; $(MAKE) $@

clean depend:
	cd src; $(MAKE) $@

uclean: clean
	rm -f `find . -name "*~"`
	rm -f out.*

install: all
	cd src; mkdir -p $(INSTALL_LIB)
	cd src; cp $(TARGET_SO) $(INSTALL_LIB)

uninstall:
	rm $(INSTALL_LIB)/$(TARGET_SO)

test:
	$(LUABIN) $(TESTLUA)

testd:
	$(LUABIN) $(TESTLUA) DEBUG

cvsdist::
	mkdir -p $(EXPORTDIR)/$(DISTNAME)
	cvs export -r latest -d $(EXPORTDIR)/$(DISTNAME) $(CVSMODULE)
	cd $(EXPORTDIR); tar -cvzf $(DISTNAME).tar.gz $(DISTNAME)/*
	rm -rf $(EXPORTDIR)/$(DISTNAME)

dist::
	svn export $(REPOSITORY)/$(SVNMODULE) $(EXPORTDIR)/$(DISTNAME)
	cd $(EXPORTDIR); tar -cvzf $(DISTARCH) $(DISTNAME)/*
	rm -rf $(EXPORTDIR)/$(DISTNAME)

.PHONY: all tag cvsdist dist test testd depend clean uclean install uninstall
