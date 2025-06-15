DENO != command -v deno
POETRY != command -v poetry
REGISTER_PYTHON_ARGCOMPLETE != command -v register-python-argcomplete
RUFF != command -v ruff
RYE != command -v rye

EXTERNAL := \
	functions/_conda \
	functions/_deno \
	functions/_jupyter \
	functions/_meson \
	functions/_pipx \
	functions/_poetry \
	functions/_ruff \
	functions/_rye \

.PHONY: all
all: functions.zwc $(EXTERNAL)

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

.DELETE_ON_ERROR: functions/_conda
functions/_conda:
	wget -O $@ https://raw.githubusercontent.com/conda-incubator/conda-zsh-completion/v0.11/_conda
	echo 'c3ce95877692a8d6841652a8c407da9ee7ff454f9d8e44407360b284 $@' | sha224sum --check -

functions/_deno: $(DENO)
ifneq ($(DENO),)
	$< completions zsh > $@
endif

.DELETE_ON_ERROR: functions/_jupyter
functions/_jupyter:
	wget -O $@ https://raw.githubusercontent.com/jupyter/jupyter_core/v5.7.2/examples/completions-zsh
	echo '5300e28506604c2f9f61980b9ee66a0312c0aa28c675f96810a6ce45 $@' | sha224sum --check -

.DELETE_ON_ERROR: functions/_meson
functions/_meson:
	wget -O $@ https://raw.githubusercontent.com/mesonbuild/meson/1.8.2/data/shell-completions/zsh/_meson
	echo 'd878fa7c6635ea93d821770d6b6ba09a162181cb28a357d11affce3f $@' | sha224sum --check -

functions/_pipx: $(REGISTER_PYTHON_ARGCOMPLETE)
ifneq ($(REGISTER_PYTHON_ARGCOMPLETE),)
	{ printf '%s\n' '#compdef $(patsubst _%,%,$(@F))' 'autoload bashcompinit' 'bashcompinit'; $< $(patsubst _%,%,$(@F)); } > $@
endif

functions/_poetry: $(POETRY)
ifneq ($(POETRY),)
	$< completions zsh > $@
endif

functions/_ruff: $(RUFF)
ifneq ($(RUFF),)
	$< generate-shell-completion zsh > $@
endif

functions/_rye: $(RYE)
ifneq ($(RYE),)
	$< self completion -s zsh > $@
endif

.PHONY: clean
clean:
	rm -f functions.zwc $(EXTERNAL)
