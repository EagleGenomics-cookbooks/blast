# BLAST attributes
default['blast']['version'] = '2.4.0'
default['blast']['install_path'] = '/usr/local'
default['blast']['dir'] = default['blast']['install_path'] + '/' + 'blast-' + default['blast']['version']
default['blast']['rpm_filename'] = "ncbi-blast-#{node['blast']['version']}+-2.x86_64.rpm"
default['blast']['linux_filename'] = "ncbi-blast-#{node['blast']['version']}+-x64-linux.tar.gz"
default['blast']['url'] = 'ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/'

default['apt']['compile_time_update'] = true
