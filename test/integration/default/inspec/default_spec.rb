
# Check that the installation was successfull
describe file('/usr/bin/blastn') do
  it { should be_file }
  it { should be_executable }
end
