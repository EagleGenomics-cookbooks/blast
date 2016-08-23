
# Check that the installation directory was created successfully
describe file('/usr/local/BLAST') do
  it { should be_directory }
end
