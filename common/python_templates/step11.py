class DictionaryTemplate:

    def __init__(self, dict={}, **keywords):
        self.dict = dict
        self.dict.update(keywords)

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
            func_name = l[1]
            if func_name in self.dict:
                func = self.dict[func_name]
            else:
                func = getattr(self, func_name)
            return func(self._process([arg]))


# assume ListTemplate as before
from step10 import ListTemplate


class LI_Template(ListTemplate):

    _template = """\t<li>%s</li>"""


class UL_Template(DictionaryTemplate):

    _template = """<ul>\n%(lst|li)s\n</ul>"""


print UL_Template(lst=["foo", "bar", "baz", "biz"], li=LI_Template)