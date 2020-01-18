.PHONY: all
all: build

.PHONY: install
install: node_modules/.tmp/make/install
node_modules/.tmp/make/install: package.json
	@which yarn && yarn || npm install
	@$(MAKE) -s _modified MODIFIED=install
.PHONY: install-continue
install-continue: deps/libgtop/.git deps/glib/.git
	# @node-pre-gyp install --fallback-to-build
deps/libgtop/.git:
	$(MAKE) -s _submodules
deps/glib/.git:
	$(MAKE) -s _submodules
.PHONY: _submodules
_submodules:
	@git submodule update --init --recursive

.PHONY: build
build: install test-cache lib
lib: src
	@rm -rf lib
	@node_modules/.bin/babel src -d lib --extensions ".ts,.tsx" --source-maps inline

.PHONY: format-cache
format-cache: node_modules/.tmp/make/format-cache
node_modules/.tmp/make/format-cache: install $(shell git ls-files)
	@$(MAKE) -s _format
.PHONY: format
format: install _format
.PHONY: _format
_format:
	@node_modules/.bin/prettier --write ./**/*.{json,md,scss,yaml,yml,js,jsx,ts,tsx} --ignore-path .gitignore
	@$(MAKE) -s _modified MODIFIED=format-cache

.PHONY: spellcheck-cache
spellcheck-cache: node_modules/.tmp/make/spellcheck-cache
node_modules/.tmp/make/spellcheck-cache: format-cache $(shell git ls-files)
	@$(MAKE) -s _spellcheck
.PHONY: spellcheck
spellcheck: format _spellcheck
.PHONY: _spellcheck
_spellcheck:
	-@node_modules/.bin/cspell --config .cspellrc src/**/*.ts prisma/schema.prisma.tmpl
	@$(MAKE) -s _modified MODIFIED=spellcheck-cache

.PHONY: lint-cache
lint-cache: node_modules/.tmp/eslintReport.json
node_modules/.tmp/eslintReport.json: spellcheck-cache $(shell git ls-files)
	@$(MAKE) -s _lint
.PHONY: lint
lint: spellcheck _lint
.PHONY: _lint
_lint:
	-@node_modules/.bin/tsc --allowJs --noEmit
	-@node_modules/.bin/eslint --fix --ext .ts,.tsx .
	-@node_modules/.bin/eslint -f json -o node_modules/.tmp/eslintReport.json --ext .ts,.tsx ./
	@$(MAKE) -s _modified MODIFIED=lint-cache

.PHONY: test-cache
test-cache: coverage
coverage: lint-cache $(shell git ls-files)
	@$(MAKE) -s _test
.PHONY: test
test: lint _test
.PHONY: _test
_test:
	-@rm -rf coverage || true
	@node_modules/.bin/jest --coverage

.PHONY: start
start: install lint
	@node_modules/.bin/babel-node --extensions '.ts,.tsx' src

.PHONY: clean
clean: install
	@git clean -fXd -e \!node_modules -e \!node_modules/**/* -e \!yarn.lock
	-@rm -rf node_modules/.cache || true
	-@rm -rf node_modules/.tmp || true
	@node_modules/.bin/jest --clearCache

.PHONY: purge
purge: clean
	@git clean -fXd

.PHONY: _modified
_modified:
	@mkdir -p node_modules/.tmp/make/$(MODIFIED)
	@rm -f node_modules/.tmp/make/$(MODIFIED)/.modified
	@touch -m node_modules/.tmp/make/$(MODIFIED)/.modified
