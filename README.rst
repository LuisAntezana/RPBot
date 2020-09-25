RPBot
=====

.. image:: https://travis-ci.org/pbylicki/RPBot.svg?branch=master
    :target: https://travis-ci.org/pbylicki/RPBot

RPBot is a Python script to serialize `Robot Framework`_  output files into
a ReportPortal. This way the future `Robot Framework`_ related tools and
plugins will have a unified storage for the test run results.

RPBot is a fork of DbBot-SQLAlchemy project that is using SQLAlchemy in order
to store test run results in any of the major supported database systems.

Requirements
------------
RPBot is tested on

-  `Python`__ 3.5+
-  `Robot Framework`_ 3.0+

It may (though it is not guaranteed) work with older versions of dependencies.

How it works
------------

The script takes one or more `output.xml` files as input, and stores
the respective results into a ReportPortal

Installation
------------

This tool is installed with pip with command:

::

    $ pip install rpbot

Alternatively you can download the `source distribution`__, extract it and
install using:

::

    $ python setup.py install

What is stored
--------------

Both the test data (names, content) and test statistics (how many did pass or
fail, possible errors occurred, how long it took to run, etc.) related to
suites and test cases are stored by default. However, keywords and related
data are not stored as it might take order of magnitude longer for massive
test runs. You can choose to store keywords and related data by using `-k` or
`--also-keywords` flag.

License
-------

RpBot is released under the `Apache License, Version 2.0`__.

See LICENSE.TXT for details.

__ https://www.python.org/
__ http://www.tldrlegal.com/license/apache-license-2.0
.. _`Robot Framework`: http://www.robotframework.org
.. _`pip`: http://www.pip-installer.org
