python ?= python3.4
package = hello

all: $(package).egg-info

$(package).egg-info: bin/pip setup.py
	bin/pip install --editable . && touch $(package).egg-info
bin/pip: bin/python get-pip.py
	bin/python get-pip.py
bin/python:
	$(python) -m venv --without-pip .
get-pip = https://bootstrap.pypa.io/get-pip.py
get-pip.py:
	$(python) -c "import urllib.request; urllib.request.urlretrieve('$(get-pip)', '$@')"

test: coverage
test: flake8
coverage: bin/coverage all
	@bin/coverage run --source=$(package)/ -m unittest discover -vf -s $(package)/tests -p '*.py'
	@bin/coverage report --fail-under=100 -m; bin/coverage html
flake8: bin/flake8 all
	@bin/flake8 setup.py $(package)/
bin/coverage: bin/pip
	bin/pip install coverage
bin/flake8: bin/pip
	bin/pip install flake8

clean:
	rm -rf *.egg-info *.egg bin lib include pyvenv.cfg get-pip.py htmlcov .coverage
	find . -name "__pycache__" -type d | xargs rm -rf
