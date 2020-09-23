SRCDIR := src
OUTDIR := build

SRCFILES  := $(shell find $(SRCDIR) -name '*.moon')
LUAFILES  := $(subst $(SRCDIR),$(OUTDIR),$(SRCFILES:.moon=.lua))

all: clean $(LUAFILES)

.PHONY: clean

$(LUAFILES): $(OUTDIR)/%.lua: $(SRCDIR)/%.moon
	moonc -o $@ $<

clean:
	-rm -rf $(OUTDIR)

link: all
	scripts/link.sh

pull:
	scripts/sync.sh pull

push: pull link
	scripts/sync.sh push
