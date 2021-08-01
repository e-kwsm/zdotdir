.PHONY: all
all: functions.zwc functions/_deno

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

functions/_deno:
ifeq ($(shell type deno > /dev/null && echo FOUND),FOUND)
	deno completions zsh > $@
endif

.PHONY: clean
clean:
	rm -f functions.zwc functions/_deno
