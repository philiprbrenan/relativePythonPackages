# Importing relative [Python](https://www.python.org/) packages

![Test](https://github.com/philiprbrenan/relativePythonPackages/workflows/Test/badge.svg)

The __import__ statements in ```sounds/format/mp3.py``` work because of the
careful choice of start [folder](https://en.wikipedia.org/wiki/File_folder) and use of **-m** keyword.  Other combinations
do not work and require appropriate modifications of ```sys.path```.  See
(relative imports in the confusing [Python](https://www.python.org/) documantation)[https://docs.python.org/3/tutorial/modules.html#packages-in-multiple-directories]
