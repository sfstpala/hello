'''
hello

Usage:
    hello (--help | --version)

Options:
    --help -h      display this help message and exit
    --version      print version information and exit

'''

import sys
import docopt
import hello


def main(argv=sys.argv[1:]):
    try:
        docopt.docopt(__doc__, argv=argv, version=hello.__version__)
    except docopt.DocoptExit as e:
        print(str(e), file=sys.stderr)
        return 2
    except SystemExit as e:
        return 0


if __name__ == "__main__":  # pragma: no cover
    sys.exit(main())
