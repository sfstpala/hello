# Hello

[![Build](https://img.shields.io/travis/sfstpala/hello.svg?style=flat-square)](https://travis-ci.org/sfstpala/hello)
[![Coverage](https://img.shields.io/coveralls/sfstpala/hello.svg?style=flat-square)](https://coveralls.io/r/sfstpala/hello)

## Prerequisites

 - Python 3.4
 - Ubuntu 14.40 (for Debian packaging)

## Development

The included `Makefile` can build the Python package, run tests, and compile documentation in a virtual environment:

    make test
    make docs

The test suite includes unit tests, linting, checking the manifest, and code coverage that fails the test suite if coverage is
less than 100%. You can also use tox to run the test suite:

    pip3 install tox
    tox

The main entry point (`hello`) is available after running `make` (all):

    bin/hello

## Packaging

To set up the debian packaging environment on Ubuntu, run:

    sudo apt-get install pbuilder debootstrap devscripts lintian
    sudo pbuilder create --debootstrapopts --variant=buildd

Afterwards, you can reproducibly build the Debian package using pbuilder:

    pdebuild --buildresult dist
    lintian --pedantic dist/*.deb dist/*.dsc dist/*.changes

## Releases

In order to release a new version of the package, [edit `debian/changelog`](https://www.debian.org/doc/debian-policy/ch-source.html#s-dpkgchangelog).
The setup script will read the version number of the package from the latest (topmost) changelog entry. The `__version__` attribute of the `hello`
package will, in turn, be read from the package's *egg-info* using `pkg_resources`.
