#!/usr/bin/python

import sys
from PyQt4.QtGui import *  
from PyQt4.QtCore import *  
from PyQt4.QtWebKit import *  
import codecs

class Render(QWebPage):
    def __init__(self, url):  
        self.app = QApplication(sys.argv)  
        QWebPage.__init__(self)  
        self.loadFinished.connect(self._loadFinished)  
        self.mainFrame().load(QUrl(url))  
        self.app.exec_()  
  
    def _loadFinished(self, result):  
        self.frame = self.mainFrame()  
        self.app.quit()  

url = sys.argv[1]
r = Render(url)  
html = r.frame.toHtml()  
codec = QTextCodec.codecForName("utf-8");
foo = unicode(codec.fromUnicode(html), 'utf-8')

f = codecs.open(sys.argv[2], encoding='utf-8', mode='w+')
f.write(foo)
f.close()
