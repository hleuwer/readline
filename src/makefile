include ../config

ifeq ($(LUAVERS), 5.0)
OBJS:=$(COMPAT)/compat-5.1.o 
else
OBJS:=
endif

OBJS += lreadline.o

all: $(TARGET_SO)

$(TARGET_SO): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)

clean:
	rm -f $(OBJS) $(TARGET_SO) 
	rm -rf makefile.deps

depend: makefile.deps

makefile.deps: $(OBJS:.o=.c)
	rm -f makefile.deps
	test -z "$(OBJS)" || $(CC) -MM $(CFLAGS) $(OBJS:.o=.c) >> makefile.deps

-include makefile.deps