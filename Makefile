
testpy: ## Clean and Make unit tests
	python3.7 -m pytest -v jupyterlab_nbconvert_nocode/tests --cov=jupyterlab_nbconvert_nocode

tests: lint ## run the tests
	python3.7 -m pytest -v jupyterlab_nbconvert_nocode/tests --cov=jupyterlab_nbconvert_nocode --junitxml=python_junit.xml --cov-report=xml --cov-branch

lint: ## run linter
	flake8 jupyterlab_nbconvert_nocode setup.py

fix:  ## run autopep8/tslint fix
	autopep8 --in-place -r -a -a jupyterlab_nbconvert_nocode/

annotate: ## MyPy type annotation check
	mypy -s jupyterlab_nbconvert_nocode

annotate_l: ## MyPy type annotation check - count only
	mypy -s jupyterlab_nbconvert_nocode | wc -l

clean: ## clean the repository
	find . -name "__pycache__" | xargs  rm -rf
	find . -name "*.pyc" | xargs rm -rf
	find . -name ".ipynb_checkpoints" | xargs  rm -rf
	rm -rf .coverage coverage cover htmlcov logs build dist *.egg-info lib node_modules
	# make -C ./docs clean

docs:  ## make documentation
	make -C ./docs html
	open ./docs/_build/html/index.html

install:  ## install to site-packages
	pip3 install .

dist:  ## create dists
	rm -rf dist build
	python3.7 setup.py sdist bdist_wheel

publish: dist  ## dist to pypi and npm
	twine check dist/* && twine upload dist/*

# Thanks to Francoise at marmelab.com for this
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%:
	@echo '$*=$($*)'

.PHONY: clean install serverextension labextension test tests help docs dist
