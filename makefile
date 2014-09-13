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

ifdef DEB_HOST_ARCH
DESTDIR ?= /
PREFIX ?= usr/
install:
	@$(python) setup.py install --no-compile --prefix="$(PREFIX)" --root="$(DESTDIR)" --install-layout=deb
endif

deb:
	rm -rf build; mkdir build; cp -r $$(find * -not -name "build" -prune) build
	cd build/; debuild -us -uc -tc && lintian ../*.deb ../*.dsc ../*.changes

clean:
	rm -rf *.egg-info *.egg bin lib include pyvenv.cfg
	rm -rf build *.dsc *.tar.gz *.build *.changes *.deb
	rm -rf get-pip.py htmlcov .coverage
	find . -name "__pycache__" -type d | xargs rm -rf
