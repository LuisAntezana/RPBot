Releasing DbBot
===============

    #. Update __version__ in `rpbot/__init__.py` to release version (remove
       '-devel' suffix)
    #. Commit, push, add git tag with version number and push tags
    #. Upload to PyPi with: `python setup.py sdist upload`
    #. Check that page in PyPi looks good and `pip install rpbot` works.
    #. Change __version__ to 'x.x-devel' in `rpbot/__init__.py`, commit and
       push

Directory structure
-------------------

+-----------+------------------------------------------------------------------+
| Directory | Description                                                      |
+===========+==================================================================+
| atests    | Robot Framework-powered acceptance tests for DbBot. Also has     |
|           | some test data in the `testdata` directory.                      |
+-----------+------------------------------------------------------------------+
| rpbot     | Source code files of RpBot.                                      |
+-----------+------------------------------------------------------------------+