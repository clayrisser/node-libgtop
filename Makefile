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

.PHONY: prepublish
prepublish: deps/libgtop/.git deps/glib/.git
deps/libgtop/.git:
	$(MAKE) -s _submodules
deps/glib/.git:
	$(MAKE) -s _submodules
.PHONY: _submodules
_submodules:
	@git submodule update --init --recursive

.PHONY: configure
configure: install build/config.gypi
build/config.gypi:
	@cd deps && $(MAKE) -s -f Makefile.glib build
	@cd deps && $(MAKE) -s -f Makefile.libgtop configure
	@node-pre-gyp clean configure

.PHONY: build
build: lib build/Release/gtop.node
build/Release/gtop.node: build/config.gypi
	@node-pre-gyp build
	@mkdir -p build/Release/obj.libs
	@cp -r deps/glib/build/glib/*.so* build/Release/obj.libs
	@node-pre-gyp package
lib: node_modules/.tmp/eslintReport.json
	@rm -rf lib
	@babel src -d lib --extensions ".ts,.tsx" --source-maps inline

.PHONY: format-cache
format-cache: node_modules/.tmp/make/format-cache
node_modules/.tmp/make/format-cache: $(shell git ls-files)
	@$(MAKE) -s _format
.PHONY: format
format: _format
.PHONY: _format
_format: install
	@prettier --write ./**/*.{json,md,scss,yaml,yml,js,jsx,ts,tsx} --ignore-path .gitignore
	@$(MAKE) -s _modified MODIFIED=format-cache

.PHONY: spellcheck-cache
spellcheck-cache: node_modules/.tmp/make/spellcheck-cache
node_modules/.tmp/make/spellcheck-cache: node_modules/.tmp/make/format-cache $(shell git ls-files)
	@$(MAKE) -s _spellcheck
.PHONY: spellcheck
spellcheck: format _spellcheck
.PHONY: _spellcheck
_spellcheck:
	-@cspell --config .cspellrc src/**/*.ts prisma/schema.prisma.tmpl
	@$(MAKE) -s _modified MODIFIED=spellcheck-cache

.PHONY: lint-cache
lint-cache: node_modules/.tmp/eslintReport.json
node_modules/.tmp/eslintReport.json: node_modules/.tmp/make/spellcheck-cache $(shell git ls-files)
	@$(MAKE) -s _lint
.PHONY: lint
lint: spellcheck _lint
.PHONY: _lint
_lint:
	-@tsc --allowJs --noEmit
	-@eslint --fix --ext .ts,.tsx .
	-@eslint -f json -o node_modules/.tmp/eslintReport.json --ext .ts,.tsx ./
	@$(MAKE) -s _modified MODIFIED=lint-cache

.PHONY: test-cache
test-cache: coverage
coverage: node_modules/.tmp/make/lint-cache $(shell git ls-files)
	@$(MAKE) -s _test
.PHONY: test
test: lint _test
.PHONY: _test
_test:
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
prepublish:
	@$(MAKE) -s _modified MODIFIED=install
	@$(MAKE) -s build

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
