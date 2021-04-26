import os
import os.path
from nbconvert.exporters.html import HTMLExporter
from nbconvert.exporters.pdf import PDFExporter
from .utils import ENV_VARS


def export_pdf(nbpath, template=None):
    from nbconvert.nbconvertapp import NbConvertApp
    if template is None:
        template = os.environ.get(ENV_VARS['export_pdf'], 'hide_code_cells_pdf')
    NbConvertApp.launch_instance([nbpath, '--template', template, '--to', 'pdf'])


def export_html(nbpath, template=None):
    from nbconvert.nbconvertapp import NbConvertApp
    if template is None:
        template = os.environ.get(ENV_VARS['export_html'], 'hide_code_cells_html')
    NbConvertApp.launch_instance([nbpath, '--template', template, '--to', 'html'])


class HTMLHideCodeExporter(HTMLExporter):
    export_from_notebook = "HTML - No Code"

    # exclude_input = True
    def _template_name_default(self):
        return 'hide_code_cells_html'


class PDFHideCodeExporter(PDFExporter):
    export_from_notebook = "PDF - No Code"

    def _template_file_default(self):
        return 'hide_code_cells_pdf'
