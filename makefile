include config

# Tools
MKDIR = mkdir -p
ifneq (,$(findstring Msys, $(SYSTEM)))
  INSTALL = c:/msys/1.0/bin/install.exe -p
  GIT =  c:/msysgit/msysgit/bin/git.exe
  GZIP = c:/msysgit/msysgit/bin/gzip.exe
else
  INSTALL = install.exe -p
  GIT =  git
  GZIP = gzip
endif
INSTALL_EXEC = $(INSTALL) -m 0755 
INSTALL_DATA = $(INSTALL) -m 0644
RM = rm -rf

# Build
.PHONY: all
all:
	cd src && $(MAKE) $@

# Clean
.PHONY: clean uclean
clean:
	cd src && $(MAKE) $@

uclean: clean
	cd src && $(MAKE) $@
	$(RM) `find . -name "*~"` out.* 

# Install Uninstall
.PHONY: install uninstall
install: all
	cd src && $(MKDIR) $(INSTALL_LIB)
	cd src && $(INSTALL_EXEC) $(TARGET_SO) $(INSTALL_LIB)

uninstall:
	cd $(INSTALL_LIB) && $(RM) $(TARGET_SO)

# Test
.PHONY: test testd
test:
ifneq (, $(findstring Msys, $(SYSTEM)))
	@echo "Msys only:"
	@echo "Test this module in an interactive command shell using: lua test/test.lua"
else	
	$(LUABIN) $(TESTLUA)
endif
testd:
	$(LUABIN) $(TESTLUA) DEBUG

# Distribute
.PHONY: dist sys
dist::
	$(MKDIR) $(EXPORTDIR)
ifeq (, $(findstring Msys, $(SYSTEM)))
	$(GIT) archive --format=tar --prefix=$(DISTNAME)/ HEAD | $(GZIP) >$(EXPORTDIR)/$(DISTARCH)	
else
	$(GIT) archive --format=zip --prefix=$(DISTNAME)/ HEAD > $(EXPORTDIR)/$(DISTARCH)	
endif

sys:
	@echo "system is: $(SYSTEM)"
	
.PHONY: all tag cvsdist dist test testd depend clean uclean install uninstall sys
