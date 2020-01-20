PLATFORM := $(shell node -e "process.stdout.write(process.platform)")
ifeq ($(PLATFORM), win32)
  SHELL = cmd
endif

.EXPORT_ALL_VARIABLES:

.PHONY: all
all: build

.PHONY: install
install: node_modules/.tmp/make/install
node_modules/.tmp/make/install: package.json
	@which yarn && yarn || npm install
	@$(MAKE) -s _modified MODIFIED=install

.PHONY: install-continue
install-continue:
	-@node-pre-gyp install --fallback-to-build

.PHONY: build
build: lib build/Release/gtop.node
build/config.gypi:
	@node-pre-gyp clean configure
build/Release/gtop.node: build/config.gypi
	@cd deps && $(MAKE) -s -f Makefile.glib build
	@cd deps && $(MAKE) -s -f Makefile.libgtop build
	@node-pre-gyp build package
lib: node_modules/.tmp/eslintReport.json
	@rm -rf lib
	@babel src -d lib --extensions ".ts,.tsx" --source-maps inline

.PHONY: format-cache
format-cache: node_modules/.tmp/make/format-cache
node_modules/.tmp/make/format-cache: $(shell git ls-files)
	@$(MAKE) -s format
.PHONY: format
format: install
	@prettier --write ./**/*.{json,md,scss,yaml,yml,js,jsx,ts,tsx} --ignore-path .gitignore
	@$(MAKE) -s _modified MODIFIED=format-cache

.PHONY: spellcheck-cache
spellcheck-cache: node_modules/.tmp/make/spellcheck-cache
node_modules/.tmp/make/spellcheck-cache: $(shell git ls-files)
	@$(MAKE) -s spellcheck
.PHONY: spellcheck
spellcheck: format-cache
	-@cspell --config .cspellrc src/**/*.ts prisma/schema.prisma.tmpl
	@$(MAKE) -s _modified MODIFIED=spellcheck-cache

.PHONY: lint-cache
lint-cache: node_modules/.tmp/eslintReport.json
node_modules/.tmp/eslintReport.json: $(shell git ls-files)
	@$(MAKE) -s lint
.PHONY: lint
lint: spellcheck-cache
	-@tsc --allowJs --noEmit
	-@eslint --fix --ext .ts,.tsx .
	-@eslint -f json -o node_modules/.tmp/eslintReport.json --ext .ts,.tsx ./
	@$(MAKE) -s _modified MODIFIED=lint-cache

.PHONY: test-cache
test-cache: coverage
coverage: $(shell git ls-files)
	@$(MAKE) -s test
.PHONY: test
test: lint-cache
	-@rm -rf coverage || true
	@jest --coverage

.PHONY: start
start: node_modules/.tmp/eslintReport.json
	@babel-node --extensions '.ts,.tsx' example

.PHONY: clean
clean:
	-@jest --clearCache
	-@node-pre-gyp clean
	-@rm -rf node_modules/.cache || true
	-@rm -rf node_modules/.tmp || true
	@cd deps && $(MAKE) -s -f Makefile.glib clean
	@cd deps && $(MAKE) -s -f Makefile.libgtop clean
	@git clean -fXd -e \!node_modules -e \!node_modules/**/* -e \!yarn.lock

.PHONY: purge
purge: clean
	@git clean -fXd

.PHONY: prepublish
prepublish: deps/libgtop/.git deps/glib/.git
	@$(MAKE) -s _modified MODIFIED=install
	@$(MAKE) -s build
deps/libgtop/.git:
	$(MAKE) -s _submodules
deps/glib/.git:
	$(MAKE) -s _submodules
.PHONY: _submodules
_submodules:
	@git submodule update --init --recursive

.PHONY: prepublish-only
prepublish-only:
	@rm -rf build
	@$(MAKE) -s build
	@node-pre-gyp-github publish --release

.PHONY: _modified
_modified:
	@rm -rf node_modules/.tmp/make/$(MODIFIED)
	@mkdir -p node_modules/.tmp/make/$(MODIFIED)
	@touch -m node_modules/.tmp/make/$(MODIFIED)/.modified
