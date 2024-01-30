# setup.py shim for use with applications that require it.
__import__("setuptools").setup()
requires = [
    "jupyterlab>=3.5",
    "nbconvert>=6.0.0",
]
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
