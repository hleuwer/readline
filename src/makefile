include ../config

TOP = ..
TARGET = $(TOP)/$(BUILD)/$(MODULE).$(SOEXT)
OBJS = $(addprefix $(TOP)/$(BUILD)/, $(OBJECTS))
LIBS += $(addprefix -l, $(LIBRARIES))
HDRS += $(addprefix -I, $(HEADERS))

all: $(TOP)/$(BUILD) $(TARGET)

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $< $(LIBS)

$(TOP)/$(BUILD)/%.o: $(TOP)/src/%.c
	$(CC) -MMD -MF $(@:.o=.d) -c $(HDRS) $(CFLAGS) -o$@ $<

$(TOP)/$(BUILD):
	$(MKDIR) $(TOP)/$(BUILD)

.PHONY: clean uclean
clean:
	$(RM) $(OBJS) $(TOP)/$(MODULE) $(TARGET) 

uclean: clean
	$(RM) $(TOP)/$(BUILD)

-include $(OBJS:.o=.d)