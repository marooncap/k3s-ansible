.SILENT:

VENV = venv
CLEAN_DIRS := .ansible $(VENV)

REQS_IN ?= requirements.in
REQS ?= requirements.txt

PYTHON_SYS ?= python3.11
PYTHON ?= $(VENV)/bin/python3
PRE_COMMIT ?= $(VENV)/bin/pre-commit
GALAXY ?= $(VENV)/bin/ansible-galaxy

.PHONY: ci
ci: $(VENV)
	unset ANSIBLE_VAULT_IDENTITY_LIST && $(PRE_COMMIT) run --all-files

.PHONY: init
init: $(VENV)
	$(PRE_COMMIT) install
	$(PRE_COMMIT) install-hooks
	$(GALAXY) collection install -r collections/requirements.yml

.PHONY: bump-pip
bump-pip:
	$(PYTHON) -m pip-compile $(REQS_IN)

.PHONY: refresh
refresh: clean init

.PHONY: clean
clean:
	rm -rf $(CLEAN_DIRS) || true

$(VENV):
	$(PYTHON_SYS) -m venv $(VENV)
	$(VENV)/bin/python3 -m pip install -r $(REQS) pip-tools==7.6.1
