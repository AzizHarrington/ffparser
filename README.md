ffparser
========

A flat file parser that includes a command line interface and api for sorting and displaying records.

Written as part of a job application code challenge.

Requirements
============

The following need to be installed on your computer:
- Ruby
- Bundler

How to run
==========

In terminal, `cd` into project directory and run `bundle install` to install gem dependencies.

Data
----
Test data in both comma and pipe seperated files can be found in `data/`.


API
---

To run the API locally:
- `rackup`

This will start a local rack server at port 9292.

The following commands can be used for testing (requires `curl` to be installed):
- `curl http://localhost:9292/records/name` for records sorted by name
- `curl http://localhost:9292/records/gender` for records sorted by gender
- `curl http://localhost:9292/records/birthdate` for records sorted by birthdate
- `curl --data "record=lee,bruce,male,blue,11/27/1940" http://localhost:9292/records` to post a new record and append it to data file

Command Line
------------

Example Usage:
- `ruby ffparser_cli.rb -f path/to/file -s fielda,fieldb -o desc, -d pipe`
- `ruby ffparser_cli.rb -f data/records.txt -s gender,last_name -o asc -d comma` to return records sorted in ascending order by gender, then last_name.

Run `ruby ffparser_cli.rb --help` for an overview of options.
