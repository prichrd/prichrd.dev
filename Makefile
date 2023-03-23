.DEFAULT_GOAL := all

SRC_DIR := src
PAGES_DIR := $(SRC_DIR)/pages
TEMPLATE_FILE := $(SRC_DIR)/template.html
OUT_DIR := out
HTML_FILES := $(shell find $(PAGES_DIR) -type f -name '*.html')
OUT_HTML_FILES := $(patsubst $(PAGES_DIR)/%.html,$(OUT_DIR)/%.html,$(HTML_FILES))

print-%: ; @echo $* = $($*)

# Define a pattern rule to generate output files
$(OUT_DIR)/%.html: $(PAGES_DIR)/%.html $(TEMPLATE_FILE) | $(OUT_DIR)
	mkdir -p $(dir $@)
	sed -e '/{{ content }}/ {' -e 'r $<' -e 'd' -e '}' $(TEMPLATE_FILE) > $@

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

all: $(OUT_HTML_FILES)

clean:
	rm -rf $(OUT_DIR)

.PHONY: all clean

