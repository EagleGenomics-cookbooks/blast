
# Check that the installation was successfull
describe file('/usr/bin/blastn') do
  it { should be_file }
  it { should be_executable }
end

describe command('/usr/bin/blastn -version') do
  its(:stdout) { should match(/2.6.0+/) }
end
