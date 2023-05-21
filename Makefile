DENO := $(shell which deno 2> /dev/null)

.PHONY: all
all: functions.zwc functions/_deno functions/_meson

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

functions/_deno: $(DENO)
ifneq ($(DENO),)
	$< completions zsh > $@
endif

.DELETE_ON_ERROR: functions/_meson
functions/_meson:
	wget -O $@ https://raw.githubusercontent.com/mesonbuild/meson/1.1.0/data/shell-completions/zsh/_meson
	echo 'e466ae7faa708dc71cfd996c8205c310c5a60ceac3d15c8fdb7e7e03 $@' | sha224sum --check -

.PHONY: clean
clean:
	rm -f functions.zwc functions/_deno functions/_meson
