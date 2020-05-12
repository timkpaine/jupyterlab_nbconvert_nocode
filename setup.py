from setuptools import setup, find_packages
from codecs import open
from os import path

from jupyter_packaging import ensure_python, get_version

pjoin = path.join

ensure_python(('2.7', '>=3.3'))

name = 'jupyterlab_nbconvert_nocode'
here = path.abspath(path.dirname(__file__))
version = get_version(pjoin(here, name, '_version.py'))

with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

requires = [
    'jupyterlab>=1.0.0',
]

dev_requires = requires + [
    'pytest',
    'pytest-cov',
    'flake8',
    'bump2version',
    'mock',
    'autopep8'
]

setup(
    name=name,
    version=version,
    description='A simple helper library with 2 NBConvert exporters for PDF/HTML export with no code cells',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/timkpaine/jupyterlab_nbconvert_nocode',
    author='Tim Paine',
    author_email='t.paine154@gmail.com',
    license='Apache 2.0',

    classifiers=[
        'Development Status :: 3 - Alpha',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Framework :: Jupyter',
    ],
    keywords='jupyter jupyterlab',
    packages=find_packages(exclude=['tests', ]),
    include_package_data=True,
    package_data={'': ['jupyterlab_nbconvert_nocode/nbconvert_functions/hideinput/templates/*']},
    zip_safe=False,
    entry_points={
        'nbconvert.exporters': [
            'pdf_hidecode = jupyterlab_nbconvert_nocode.nbconvert_functions.hideinput.exporters:PDFHideCodeExporter',
            'html_hidecode = jupyterlab_nbconvert_nocode.nbconvert_functions.hideinput.exporters:HTMLHideCodeExporter',
        ],
    },
    extras_require={
        'dev': dev_requires,
    },
)
