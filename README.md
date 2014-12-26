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

To build the Debian package, run:

    debuild -us -uc -tc

Note that you need to update `debian/changelog` as well as `setup.py` for each release.
