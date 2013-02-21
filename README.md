#DBMonitor

Use your web browser to monitor table inserts

##Description

Monitor inserts to a specific table of a datbase based on a MySQL timestamp
column.

##Dependencies

* nodejs
* npm

##Install

```
$ git clone git://github.com/atomaka/dbmonitor.git
$ cd dbmonitor
$ npm install
$ cp config/application.coffee.sample application.coffee
$ cp config/database.coffee.sample database.coffee
```

* Edit settings in application.coffee and database.coffee as necessary

##Usage

```
$ ./node_modules/coffee-script/bin/coffee dbmonitor.coffee
```

or with global coffee-script install:

```
$ coffee dbmonitor.coffee
```

Access the application in your browser using the port you have configured.

##License

The MIT License

Copyright (c) 2013 Andrew Tomaka

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in 
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
THE SOFTWARE.
