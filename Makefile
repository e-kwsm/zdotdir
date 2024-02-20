DENO := $(shell which deno 2> /dev/null)
POETRY := $(shell which poetry 2> /dev/null)
REGISTER_PYTHON_ARGCOMPLETE := $(shell which register-python-argcomplete 2> /dev/null)

EXTERNAL := \
	functions/_conda \
	functions/_deno \
	functions/_jupyter \
	functions/_meson \
	functions/_pipx \
	functions/_poetry \

.PHONY: all
all: functions.zwc $(EXTERNAL)

functions.zwc: $(shell git ls-files functions/)
	zsh -c 'zcompile -U -M $@ $(sort $^)'

.DELETE_ON_ERROR: functions/_conda
functions/_conda:
	wget -O $@ https://raw.githubusercontent.com/conda-incubator/conda-zsh-completion/v0.10/_conda
	echo 'ef552dfb8caa1ececedd44cb36d070b75bf2733e7802cf14ba876971 $@' | sha224sum --check -

functions/_deno: $(DENO)
ifneq ($(DENO),)
	$< completions zsh > $@
endif

.DELETE_ON_ERROR: functions/_jupyter
functions/_jupyter:
	wget -O $@ https://raw.githubusercontent.com/jupyter/jupyter_core/v5.7.1/examples/completions-zsh
	echo '5300e28506604c2f9f61980b9ee66a0312c0aa28c675f96810a6ce45 $@' | sha224sum --check -

.DELETE_ON_ERROR: functions/_meson
functions/_meson:
	wget -O $@ https://raw.githubusercontent.com/mesonbuild/meson/1.3.2/data/shell-completions/zsh/_meson
	echo '35b4a698e7088fe05d6691d544185ce6364149fe9326726c712b08e7 $@' | sha224sum --check -

functions/_pipx: $(REGISTER_PYTHON_ARGCOMPLETE)
ifneq ($(REGISTER_PYTHON_ARGCOMPLETE),)
	{ printf '%s\n' '#compdef pipx' 'autoload bashcompinit' 'bashcompinit'; $< pipx; } > $@
endif

functions/_poetry: $(POETRY)
ifneq ($(POETRY),)
	$< completions zsh > $@
endif

.PHONY: clean
clean:
	rm -f functions.zwc $(EXTERNAL)
