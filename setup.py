from codecs import open
from os import path

from jupyter_packaging import get_data_files
from setuptools import find_packages, setup

pjoin = path.join

name = "jupyterlab_nbconvert_nocode"
here = path.abspath(path.dirname(__file__))

with open(path.join(here, "README.md"), encoding="utf-8") as f:
    long_description = f.read()

requires = [
    "jupyterlab>=3.5",
    "nbconvert>=6.0.0",
]

dev_requires = requires + [
    "black>=23",
    "bump2version>=1.0.0",
    "check-manifest",
    "flake8>=3.7.8",
    "flake8-black>=0.2.1",
    "jupyter_packaging",
    "mock",
    "pytest>=4.3.0",
    "pytest-cov>=2.6.1",
    "Sphinx>=1.8.4",
    "sphinx-markdown-builder>=0.5.2",
]

setup(
    name=name,
    version="0.4.0",
    description="A simple helper library with 2 NBConvert exporters for PDF/HTML export with no code cells",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/timkpaine/jupyterlab_nbconvert_nocode",
    author="Tim Paine",
    author_email="t.paine154@gmail.com",
    license="Apache 2.0",
    classifiers=[
        "Development Status :: 4 - Beta",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Framework :: Jupyter",
    ],
    keywords="jupyter jupyterlab",
    packages=find_packages(),
    python_requries=">=3.8",
    include_package_data=True,
    data_files=get_data_files(
        [
            ("share", "share", "**"),
        ]
    ),
    zip_safe=False,
    entry_points={
        "nbconvert.exporters": [
            "pdf_nocode = jupyterlab_nbconvert_nocode.nbconvert_functions.hideinput.exporters:PDFHideCodeExporter",
            "html_nocode = jupyterlab_nbconvert_nocode.nbconvert_functions.hideinput.exporters:HTMLHideCodeExporter",
        ],
    },
    extras_require={
        "dev": dev_requires,
        "develop": dev_requires,
    },
)
