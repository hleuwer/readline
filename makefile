include config

TOP=.

all clean:
	cd src && $(MAKE) $@

uclean: clean 
	cd src && $(MAKE) $@
	$(RMTEMP)

install: all doc
	$(MKDIR) $(INSTALL_LIB)
	$(INSTALL_EXEC) $(TOP)/$(BUILD)/$(MODULE).$(SOEXT) $(INSTALL_LIB)

uninstall: 
	cd $(INSTALL_LIB) && $(RM) $(MODULE).$(SOEXT)

test testd:
ifneq (, $(findstring Msys, $(SYSTEM)))
	@echo "Have to learn how to launch an interactive console in eclipse. Sorry."
else
	lua test/test.lua
endif

doc::
	@echo "Nothing to do!"

clean-doc:
	$(RM) doc

dist::
	$(MKDIR) $(EXPORTDIR)
ifeq (, $(findstring Msys, $(SYSTEM)))
	$(GIT) archive --format=tar --prefix=$(DISTNAME)/ HEAD | $(GZIP) >$(EXPORTDIR)/$(DISTARCH)	
else
	$(GIT) archive --format=zip --prefix=$(DISTNAME)/ HEAD > $(EXPORTDIR)/$(DISTARCH)	
endif

sys:
	@echo "system is: $(SYSTEM)"

.PHONY: all dist test testd clean uclean install uninstall dist sys
