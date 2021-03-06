[![Build Status](https://travis-ci.org/EagleGenomics-cookbooks/blast.svg?branch=master)](https://travis-ci.org/EagleGenomics-cookbooks/blast)

# BLAST

Description
===========
This Cookbook installs BLAST, a tool to assess genome assembly and annotation completeness with single-copy orthologs.

Requirements
============

## Platforms:

* Centos 7.2
* Ubuntu 14.04

Notes
=====

When specifying a version other than 2.6.0, it is necessary to change the `blast_rpm_filename` within the recipe. For version 2.6.0, this has the extension `+-1.x86_64.rpm` but for, e.g. version 2.4.0 this is `+-2.x86_64.rpm`. Wildcard characters do not seem to work when specifying `remote_file`.

Usage
=====
Simply include the recipe wherever you would like it installed, such as a run list (recipe[blast]) or a cookbook (include_recipe 'blast')


## Testing
To test the recipe we use chef test kitchen:

kitchen converge

kitchen login

kitchen verify

kitchen destroy

kitchen test

Attributes
==========
See attributes/default.rb for default values.

default['BLAST']['version']

License and Authors
===================

* Authors:: Daniel Barrell (<chef@eaglegenomics.com>)
* Authors:: Nick James  (<chef@eaglegenomics.com>)

Copyright:: 2016, Eagle Genomics Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
