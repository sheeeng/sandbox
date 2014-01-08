#!/usr/bin/python
# -*- coding: utf-8 -*-

#http://stackoverflow.com/a/7291240
def get_wide_ordinal(char):
    if len(char) != 2:
        return ord(char)
        return 0x10000 + (ord(char[0]) - 0xD800) * 0x400 + (ord(char[1]) - 0xDC00)


print("Checkmark: " + u'\u2713');
print("Snowman: " + u'\u2603');
print("Comet: " + u'\u2604');
print("Black Star: " + u'\u2605');
print("White Star: " + u'\u2606');

helloWorldString = '你好，世界！'
print type(helloWorldString)

helloWorldUnicodeString = u'你好，世界！'
print type(helloWorldUnicodeString)

#Shows the unicode escape code as a source string.
print "Unicode escape:" + helloWorldUnicodeString.encode("unicode_escape")

print "Unicode values of \'Café\':"
for c in u"Café":
    print '\t', repr(c), '-' ,ord(c)

print "Unicode values of \'你好，世界！\':"
for c in helloWorldUnicodeString:
    print '\t', get_wide_ordinal(c) 
