DENO != command -v deno
POETRY != command -v poetry
REGISTER_PYTHON_ARGCOMPLETE != command -v register-python-argcomplete
RUFF != command -v ruff
RYE != command -v rye

SITE_FUNCTIONS := \
	site-functions/_conda \
	site-functions/_deno \
	site-functions/_jupyter \
	site-functions/_meson \
	site-functions/_pipx \
	site-functions/_poetry \
	site-functions/_ruff \
	site-functions/_rye \

.PHONY: all
all: functions.zwc $(SITE_FUNCTIONS)

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

.DELETE_ON_ERROR: site-functions/_conda
site-functions/_conda:
	wget -O $@ https://raw.githubusercontent.com/conda-incubator/conda-zsh-completion/v0.11/_conda
	echo 'c3ce95877692a8d6841652a8c407da9ee7ff454f9d8e44407360b284 $@' | sha224sum --check -

site-functions/_deno: $(DENO)
ifneq ($(DENO),)
ifeq ($(wildcard /usr/share/zsh/site-functions/_deno),)
	$< completions zsh > $@
endif
endif

.DELETE_ON_ERROR: site-functions/_jupyter
site-functions/_jupyter:
ifeq ($(wildcard /usr/share/zsh/site-functions/_jupyter),)
	wget -O $@ https://raw.githubusercontent.com/jupyter/jupyter_core/v5.9.1/examples/completions-zsh
	echo '5300e28506604c2f9f61980b9ee66a0312c0aa28c675f96810a6ce45 $@' | sha224sum --check -
endif

.DELETE_ON_ERROR: site-functions/_meson
site-functions/_meson:
ifeq ($(wildcard /usr/share/zsh/site-functions/_meson),)
	wget -O $@ https://raw.githubusercontent.com/mesonbuild/meson/1.11.1/data/shell-completions/zsh/_meson
	echo 'cf2048643efe8d87be098642d069e4363b4b2003098e8631f3e60a55 $@' | sha224sum --check -
endif

site-functions/_pipx: $(REGISTER_PYTHON_ARGCOMPLETE)
ifneq ($(REGISTER_PYTHON_ARGCOMPLETE),)
ifeq ($(wildcard /usr/share/zsh/site-functions/_pipx),)
	{ printf '%s\n' '#compdef $(patsubst _%,%,$(@F))' 'autoload bashcompinit' 'bashcompinit'; $< $(patsubst _%,%,$(@F)); } > $@
endif
endif

site-functions/_poetry: $(POETRY)
ifneq ($(POETRY),)
ifeq ($(wildcard /usr/share/zsh/site-functions/_poetry),)
	$< completions zsh > $@
endif
endif

site-functions/_ruff: $(RUFF)
ifneq ($(RUFF),)
ifeq ($(wildcard /usr/share/zsh/site-functions/_ruff),)
	$< generate-shell-completion zsh > $@
endif
endif

site-functions/_rye: $(RYE)
ifneq ($(RYE),)
ifeq ($(wildcard /usr/share/zsh/site-functions/_rye),)
	$< self completion -s zsh > $@
endif
endif

.PHONY: clean
clean:
	rm -f functions.zwc $(SITE_FUNCTIONS)
