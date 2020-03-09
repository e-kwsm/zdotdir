functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

.PHONY: clean
clean:
	rm -f functions.zwc
