.SILENT:

VENV = venv
CLEAN_DIRS := .ansible venv

REQS_IN ?= requirements.in
REQS ?= requirements.txt

PYTHON_SYS ?= python3.11
PYTHON ?= $(VENV)/bin/python3

init: $(VENV)
	$(PYTHON) -m pre-commit install
	$(PYTHON) -m pre-commit install-hooks
	$(PYTHON) -m ansible-galaxy collection install -r collections/requirements.yml

bump-pip:
	$(PYTHON) -m pip-compile $(REQS_IN)

refresh:
	rm -rf $(CLEAN_DIRS)
	$(MAKE) init

$(VENV):
	$(MAKE) venv

venv:
	$(PYTHON_SYS) -m venv $(VENV)
	$(VENV)/bin/python3 -m pip install -r $(REQS) pip-tools==7.6.1
