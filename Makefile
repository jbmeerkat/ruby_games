.PHONY: start test doc_test lint build

start:
	bin/start

install:
	bin/setup

test:
	bin/rspec

doc_test:
	bin/rspec -fd

lint:
	bin/rubocop -PES

build: lint test
