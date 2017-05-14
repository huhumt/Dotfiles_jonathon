__author__ = 'jonathan'

import urllib.request
import json

f = urllib.request.urlopen("http://www.biblegateway.com/votd/get/?format=json&version=ESV")
content = json.loads(f.read().decode("utf-8"))
print(content['votd']['reference'])