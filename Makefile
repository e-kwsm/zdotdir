DENO := $(shell which deno 2> /dev/null)

.PHONY: all
all: functions.zwc functions/_deno

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

functions/_deno: $(DENO)
ifneq ($(DENO),)
	$< completions zsh > $@
endif

.PHONY: clean
clean:
	rm -f functions.zwc functions/_deno
