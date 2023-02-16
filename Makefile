DENO := $(shell which deno 2> /dev/null)

.PHONY: all
all: functions.zwc functions/_deno functions/_meson

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

functions/_deno: $(DENO)
ifneq ($(DENO),)
	$< completions zsh > $@
endif

functions/_meson:
	wget -O $@ https://raw.githubusercontent.com/mesonbuild/meson/master/data/shell-completions/zsh/_meson

.PHONY: clean
clean:
	rm -f functions.zwc functions/_deno functions/_meson
