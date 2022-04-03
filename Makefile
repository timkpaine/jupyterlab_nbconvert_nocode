testpy: ## Clean and Make unit tests
	python -m pytest -v jupyterlab_nbconvert_nocode/tests --cov=jupyterlab_nbconvert_nocode --junitxml=python_junit.xml --cov-report=xml --cov-branch

test: tests
tests: testpy  ## run the tests

lintpy:  ## Black/flake8 python
	python -m black --check jupyterlab_nbconvert_nocode setup.py docs/conf.py
	python -m flake8 jupyterlab_nbconvert_nocode setup.py docs/conf.py

lint: lintpy  ## run linter

fixpy:  ## Black python
	python -m black jupyterlab_nbconvert_nocode/ setup.py docs/conf.py

fix: fixpy  ## run black/tslint fix

check: checks
checks:  ## run lint and other checks
	check-manifest

build: clean  ## build python/javascript
	python setup.py build

develop:  ## install to site-packages in editable mode
	python -m pip install --upgrade build pip setuptools twine wheel
	python -m pip install -e .[develop]

install:  ## install to site-packages
	python -m pip install .

dist: clean build  ## create dists
	python -m twine check dist/*

publishpy:  ## dist to pypi
	python -m twine upload dist/* --skip-existing

publish: dist publishpy  ## dist to pypi and npm

docs:  ## make documentation
	make -C ./docs html
	open ./docs/_build/html/index.html

clean: ## clean the repository
	find . -name "__pycache__" | xargs  rm -rf
	find . -name "*.pyc" | xargs rm -rf
	find . -name ".ipynb_checkpoints" | xargs  rm -rf
	rm -rf .coverage coverage *.xml build dist *.egg-info lib node_modules .pytest_cache *.egg-info .autoversion .mypy_cache
	# make -C ./docs clean
	git clean -fd

# Thanks to Francoise at marmelab.com for this
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%:
	@echo '$*=$($*)'

.PHONY: testpy tests test lintpy lint fixpy fix checks check build develop install dist publishpy publish docs clean
