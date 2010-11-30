include ../config

all: $(TARGET_SO)

$(TARGET_SO): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^ $(LIBS)

SUFFIXES: .c .o .d
.c.o:
	$(CC) -MMD -c $(CFLAGS) -o $@ $<

.PHONY: clean uclean
clean:
	$(RM) $(OBJS) $(TARGET_SO) 

uclean: clean
	$(RM) $(OBJS:.o=.d)
	
-include $(OBJS:.o=.d)