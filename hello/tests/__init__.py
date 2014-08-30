import unittest
import unittest.mock
import pkg_resources
import hello


distribution = pkg_resources.get_distribution("hello")
main = distribution.load_entry_point("console_scripts", "hello")


class DistributionTest(unittest.TestCase):

    @unittest.mock.patch("builtins.print")
    def test_options(self, print):
        self.assertEqual(main(["--invalid-argument"]), 2)
        self.assertEqual(main(["--help"]), 0)

    def test_version(self):
        self.assertEqual(hello.__version__, distribution.version)
        self.assertRegex(hello.__version__, r'\d+\.\d+\.\d+')
