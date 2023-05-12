control 'CFSS-4X-000002' do
  title 'The SDDC Manager SOS service files must be verified for their integrity.'
  desc  "Verifying that the application code is unchanged from it's shipping state is essential for file validation and non-repudiation. There is no reason that the MD5 hash of the rpm original files should be changed after installation, excluding configuration files."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # rpm -V sddc-support | grep \"^..5......\"

    If there is any output, this is a finding.
  "
  desc 'fix', 'Re-install the SDDC Manager or roll back to a snapshot or backup.  Modifying the installation files manually is not supported.'
  impact 0.3
  tag severity: 'low'
  tag gtitle: 'SRG-APP-000131-WSR-000051'
  tag gid: 'V-CFSS-4X-000002'
  tag rid: 'SV-CFSS-4X-000002'
  tag stig_id: 'CFSS-4X-000002'
  tag cci: ['CCI-001749']
  tag nist: ['CM-5 (3)']

  describe command('rpm -V sddc-support | grep \"^..5......\"') do
    its('stdout.strip') { should eq '' }
  end
end
