.PHONY: default
default:

.PHONY: format
format: black isort

.PHONY: lint
lint: flake8 isort-check black-check mypy

.PHONY: test
test:
	pytest .

.PHONY: test-update-snapshots
test-update-snapshots:
	pytest . --snapshot-update

.PHONY: black
black:
	black -l 100 .

.PHONY: black-check
black-check:
	black -l 100 --check .

.PHONY: isort
isort:
	isort --force-sort-within-sections --profile=black .

.PHONY: isort-check
isort-check:
	isort --force-sort-within-sections --profile=black --check .

.PHONY: flake8
flake8:
	flake8

.PHONY: mypy
mypy: export MYPYPATH=stubs
mypy:
	mypy cada_prio tests

.PHONY: serve
serve:
	uvicorn cada_prio.rest_server:app --host 0.0.0.0 --port 8080 --reload
