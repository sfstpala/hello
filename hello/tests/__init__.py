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

import unittest
import mock
import pkg_resources
import hello


distribution = pkg_resources.get_distribution("hello")
main = distribution.load_entry_point("console_scripts", "hello")


class DistributionTest(unittest.TestCase):

    @mock.patch("sys.stdout")
    @mock.patch("sys.stderr")
    def test_options(self, stderr, stdout):
        self.assertEqual(main(["--invalid-argument"]), 2)
        self.assertEqual(main(["--help"]), 0)

    def test_version(self):
        self.assertEqual(hello.__version__, distribution.version)
        self.assertEqual(len(hello.__version__.split(".")), 3)
