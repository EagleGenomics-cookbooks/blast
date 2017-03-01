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

blast_rpm_filename = "ncbi-blast-#{node['blast']['version']}+-1.x86_64.rpm"
blast_linux_filename = "ncbi-blast-#{node['blast']['version']}+-x64-linux.tar.gz"
blast_linux_folder = "ncbi-blast-#{node['blast']['version']}+"
blast_source = "#{node['blast']['url']}/#{node['blast']['version']}"

# to run the fasta pipeline we need makeblastdb installed
# ubuntu only
if node['platform_family'] == 'debian'
  # almost no versions are available through apt-get
  remote_file "#{Chef::Config[:file_cache_path]}/#{blast_linux_filename}" do
    source "#{blast_source}/#{blast_linux_filename}"
    not_if { File.exist?('/usr/bin/blastn') }
    action :create_if_missing
  end
  execute 'untar ncbi-blast' do
    command 'tar xzf ' \
      "#{Chef::Config[:file_cache_path]}/#{blast_linux_filename}" \
      " -C #{Chef::Config[:file_cache_path]}"
    not_if { File.exist?('/usr/bin/blastn') }
  end
  execute 'copy binaries' do
    cwd Chef::Config[:file_cache_path]
    command "cp ./#{blast_linux_folder}/bin/* #{node['blast']['install_path']}"
    not_if { File.exist?('/usr/bin/blastn') }
  end
elsif node['platform_family'] == 'rhel'
  remote_file "#{Chef::Config[:file_cache_path]}/#{blast_rpm_filename}" do
    source "#{blast_source}/#{blast_rpm_filename}"
    not_if { File.exist?('/usr/bin/blastn') }
    action :create_if_missing
  end
  execute 'install ncbi-blast rpm' do
    command "rpm -i --nodeps #{Chef::Config[:file_cache_path]}/#{blast_rpm_filename}"
    not_if { File.exist?('/usr/bin/blastn') }
  end
end
