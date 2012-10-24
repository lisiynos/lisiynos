# the base template taken from previous example

class DictionaryTemplate:

    def __init__(self, dict={}):
        self.dict = dict

    def __str__(self):
        return self._template % self

    def __getitem__(self, key):
        return self._process(key.split("|"))

    def _process(self, l):
        arg = l[0]
        if len(l) == 1:
            if arg in self.dict:
                return self.dict[arg]
            elif hasattr(self, arg) and callable(getattr(self, arg)):
                return getattr(self, arg)()
            else:
                raise KeyError(arg)
        else:
            func = l[1]
            return getattr(self, func)(self._process([arg]))


# template for individual items       

class LI_Template:

    _template = """\t<li>%s</li>"""

    def __init__(self, input_list=[]):
        self.input_list = input_list

    def __str__(self):
        return "\n".join([self._template % x for x in self.input_list])


# template for overall list

class UL_Template(DictionaryTemplate):

    _template = """<ul>\n%(lst|li)s\n</ul>"""

    def li(self, input_list):
        return LI_Template(input_list)


print UL_Template({"lst": ["foo", "bar", "baz"]})