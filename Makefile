###############
# Build Tools #
###############
build:  ## build python/javascript
	python -m build .

develop:  ## install to site-packages in editable mode
	python -m pip install --upgrade build pip setuptools twine wheel
	python -m pip install -e .[develop]

install:  ## install to site-packages
	python -m pip install .

###########
# Testing #
###########
testpy: ## clean and Make unit tests
	python -m pytest -v jupyterlab_nbconvert_nocode/tests --junitxml=junit.xml --cov=jupyterlab_nbconvert_nocode --cov-report=xml:.coverage.xml --cov-branch --cov-fail-under=0 --cov-report term-missing

test: tests
tests: testpy  ## run the tests

###########
# Linting #
###########
lint:  ## ruff python
	python -m ruff check jupyterlab_nbconvert_nocode setup.py
	python -m ruff format --check jupyterlab_nbconvert_nocode setup.py

fix:  ## ruff python
	python -m ruff check --fix jupyterlab_nbconvert_nocode setup.py
	python -m ruff format jupyterlab_nbconvert_nocode setup.py

format: fix

################
# Distribution #
################
dist: clean build  ## create dists
	python -m twine check dist/*

publishpy:  ## dist to pypi
	python -m twine upload dist/* --skip-existing

publish: dist publishpy  ## dist to pypi and npm

############
# Cleaning #
############
clean: ## clean the repository
	find . -name "__pycache__" | xargs  rm -rf
	find . -name "*.pyc" | xargs rm -rf
	find . -name ".ipynb_checkpoints" | xargs  rm -rf
	rm -rf .coverage coverage *.xml build dist *.egg-info lib node_modules .pytest_cache *.egg-info
	git clean -fd

###########
# Helpers #
###########
# Thanks to Francoise at marmelab.com for this
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%:
	@echo '$*=$($*)'

.PHONY: tests test lint fix format build develop install dist publishpy publish clean