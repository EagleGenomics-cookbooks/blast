#
# Cookbook Name:: BLAST
# Recipe:: default
#
# Copyright 2016 Eagle Genomics Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

package ['tar'] do
  action :install
end

include_recipe 'build-essential'
include_recipe 'apt'

# to run the fasta pipeline we need makeblastdb installed
# ubuntu only
if node['platform_family'] == 'debian'
  package 'ncbi-blast+'
elsif node['platform_family'] == 'rhel'
  remote_file "#{Chef::Config[:file_cache_path]}/#{node['blast']['rpm_filename']}" do
    source "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/#{node['blast']['rpm_filename']}"
    not_if { File.exist?('/usr/bin/blastn') }
    action :create_if_missing
  end

  execute 'install ncbi-blast rpm' do
    command "rpm -i --nodeps #{Chef::Config[:file_cache_path]}/#{node['blast']['rpm_filename']}"
    not_if { File.exist?('/usr/bin/blastn') }
  end
end
