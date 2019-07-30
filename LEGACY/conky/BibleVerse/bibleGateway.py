__author__ = 'jonathan'

import urllib.request
import json
import html
import textwrap

f = urllib.request.urlopen("http://www.biblegateway.com/votd/get/?format=json&version=ESV")
content = json.loads(f.read().decode("utf-8"))

print(textwrap.fill(html.unescape(content['votd']['text']),30))
