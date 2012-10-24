# assume class DictionaryTemplate exactly as before
from step9 import DictionaryTemplate

class ListTemplate:

    def __init__(self, input_list=[]):
        self.input_list = input_list

    def __str__(self):
        return "\n".join([self._template % x for x in self.input_list])


class LI_Template(ListTemplate):

    _template = """\t<li>%s</li>"""


class UL_Template(DictionaryTemplate):

    _template = """<ul>\n%(lst|li)s\n</ul>"""

    def li(self, input_list):
        return LI_Template(input_list)


print UL_Template({"lst": ["foo", "bar"]})