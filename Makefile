.PHONY: start test doc_test lint build ci

start:
	bin/start

install:
	bin/setup

test:
	bin/rspec

test_ci:
	bin/rspec -t ~gosu

documentation:
	yard doc lib/ecs

doc_test:
	bin/rspec -fd

lint:
	bin/rubocop -PES

# optional. include (or not) later in linting step
reek: lint
	bin/reek

build: lint test
build_ci: lint test_ci

ci:
	travis show
