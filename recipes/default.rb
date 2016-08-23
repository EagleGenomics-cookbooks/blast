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

  # # This ignore the install for some reason...
  # rpm_package 'Install ncbi blast rpm' do
  #   action :install
  #   source "#{Chef::Config[:file_cache_path]}/ncbi-blast-2.2.31+-2.x86_64.rpm"
  #   #source "/tmp/ncbi-blast-2.2.31+-2.x86_64.rpm"
  #   package_name 'ncbi-blast-2.2.31+-2.x86_64'
  #   options '--nodeps'
  # end

  execute 'install ncbi-blast rpm' do
    command "rpm -i --nodeps #{Chef::Config[:file_cache_path]}/#{node['blast']['rpm_filename']}"
    not_if { File.exist?('/usr/bin/blastn') }
  end
end
# elsif node['platform_family'] == 'rhel'
#   # in centos 6.6 we need to use this rpm as not in any repo's
#   remote_file "#{Chef::Config[:file_cache_path]}/ncbi-blast-2.2.31+-src.tar.gz" do
#     source "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.2.31+-src.tar.gz"
#     action :create
#   end

#   # The make install step below assumes basename is at /usr/bin/basename
#   link "/usr/bin/basename" do
#     to "/bin/basename"
#   end

#   bash "install ncbi-blast+" do
#     cwd Chef::Config[:file_cache_path]
#     code <<-EOH
#       tar -zxf ncbi-blast-2.2.31+-src.tar.gz
#       cd ncbi-blast-2.2.31+-src/c++
#       ./configure
#       make
#       make install
#       EOH
#   end
# end

# this symlinks every executable in the install subdirectory to the top of the directory tree
# so that they are in the PATH
execute "find #{node['blast']['dir']} -maxdepth 1 -name '*.py' -executable -type f -exec ln -sf {} . \\;" do
  cwd node['blast']['install_path'] + '/bin'
end
