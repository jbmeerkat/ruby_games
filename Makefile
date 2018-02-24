.PHONY: start test doc_test lint build

start:
	bin/start

install:
	bin/setup

test:
	bin/rspec

test_ci:
	bin/rspec -t ~gosu

doc_test:
	bin/rspec -fd

lint:
	bin/rubocop -PES

build: lint test
build_ci: lint test_ci
