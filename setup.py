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

import setuptools


setuptools.setup(
    name="hello", version="0.0.0",
    packages=setuptools.find_packages(),
    test_suite="hello.tests",
    author="Stefano Palazzo",
    author_email="stefano.palazzo@gmail.com",
    url="https://github.com/sfstpala/hello/",
    description="Hello World",
    long_description="This is a pretty simple Python package.",
    license="GPLv3",
    platforms="Debian GNU/Linux",
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.4",
    ],
    install_requires=[
        "docopt >=0.6.2",
    ],
    entry_points={
        "console_scripts": [
            "hello = hello.__main__:main",
        ]
    },
    data_files=[
        ("share/man/man1", ["debian/hello.1"]),
    ],
    package_data={
        "hello": [
        ],
    },
)
