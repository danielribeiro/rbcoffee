rbcoffee
==============

Adds some rubyisms and smalltalkisms into [Coffeescript](https://github.com/jashkenas/coffee-script) (all are top level functions, and in node.js they are module functions):

* puts
* raise: throws an error
* abstract_method: General smalltalkism for abstract methods is to throw Subclass responsability. In smalltalk subclass_responsability is actually a method of Object class, but I'm against libraries adding methods to core classes without some very good justification, and even then it needs to be very very polite and only do it when explicitely requested.
* define: add a method a class
* methods: list the instance methods of a class

There are a few other variants of *methods*. Check the [source](https://github.com/danielribeiro/rbcoffee/blob/master/rbcoffee.coffee) for more info.

Meta
----

Created by [Daniel Ribeiro](http://metaphysicaldeveloper.wordpress.com/about-me)

Released under the MIT License: http://www.opensource.org/licenses/mit-license.php

http://github.com/danielribeiro/rbcoffee
