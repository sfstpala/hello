import setuptools


setuptools.setup(
    name="hello", version="0.0.0",
    packages=setuptools.find_packages(),
    test_suite="hello",
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
)
