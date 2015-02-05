# Copyright (c) 2014 Stefano Palazzo <stefano.palazzo@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

python ?= python3.4
virtualenv ?= virtualenv

all: hello.egg-info

hello.egg-info: setup.py bin/pip
	bin/pip install --editable . && touch $@
bin/pip:
	$(virtualenv) -p $(python) .

test: all bin/coverage bin/flake8 bin/check-manifest
	bin/coverage run setup.py test
	bin/coverage html
	bin/coverage report --fail-under=100
	bin/flake8 setup.py hello
	bin/check-manifest || ! test -d .git
	bin/python setup.py check
bin/coverage: bin/pip
	bin/pip install coverage
bin/flake8: bin/pip
	bin/pip install flake8
bin/check-manifest: bin/pip
	bin/pip install check-manifest

docs: all bin/pdoc bin/pygmentize hello/** setup.py
	bin/pdoc --html --only-pypath --html-dir ./docs --overwrite hello hello
bin/pdoc: bin/pip
	bin/pip install pdoc
bin/pygmentize: bin/pip
	bin/pip install pygments

ifdef DEB_HOST_ARCH
DESTDIR ?= /
PREFIX ?= usr/
install:
	$(python) setup.py install --no-compile --prefix="$(PREFIX)" --root="$(DESTDIR)" --install-layout=deb
endif

clean:
	rm -rf build dist $(shell find hello -name "__pycache__") $(shell find hello -name "*.pyc")
	rm -rf *.egg-info *.egg .eggs bin lib lib64 include share pyvenv.cfg .Python
	rm -rf docs htmlcov .coverage .tox pip-selfcheck.json
