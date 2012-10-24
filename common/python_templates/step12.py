from step11 import DictionaryTemplate, ListTemplate


# a list with no wrapper elements

class ArticleList_Template(DictionaryTemplate):

    _template = """
      <div>
        <h1>Articles</h1>
        %(lst|li)s
      </div>"""


# a template for an article

class Article_Template(ListTemplate):

    _template = """
        <div>
          <h2>%(heading)s</h2>
          <p class="date">%(date)s</p>
          <p>%(abstract)s</p>
          <p><a href="%(link)s">Link</a></p>
        </div>"""


# the actual data
articles = [
    {"heading": "Article 1",
     "date": "2003-02-10",
     "abstract": "This is the first article.",
     "link": "http://example.com/article/1"},
    {"heading": "Article 2",
     "date": "2003-02-13",
     "abstract": "This is the second article.",
     "link": "http://example.com/article/2"}]


print ArticleList_Template(lst=articles, li=Article_Template)