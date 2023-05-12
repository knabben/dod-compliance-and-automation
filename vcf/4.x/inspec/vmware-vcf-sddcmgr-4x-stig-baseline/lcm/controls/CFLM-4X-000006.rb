control 'CFLM-4X-000006' do
  title 'The SDDC Manager LCM service files must be verified for their integrity.'
  desc  "Verifying that the application code is unchanged from it's shipping state is essential for file validation and non-repudiation. There is no reason that the MD5 hash of the rpm original files should be changed after installation, excluding configuration files."
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, execute the following command:

    # rpm -V vcf-lcm | grep \"^..5......\" | grep -v -E \"/etc|application.*properties\"

    If there is any output, this is a finding.
  "
  desc 'fix', 'Re-install the SDDC Manager or roll back to a snapshot or backup.  Modifying the installation files manually is not supported.'
  impact 0.3
  tag severity: 'low'
  tag gtitle: 'SRG-APP-000131-WSR-000051'
  tag gid: 'V-CFLM-4X-000006'
  tag rid: 'SV-CFLM-4X-000006'
  tag stig_id: 'CFLM-4X-000006'
  tag cci: ['CCI-001749']
  tag nist: ['CM-5 (3)']

  describe command('rpm -V vcf-lcm | grep \"^..5......\" | grep -v -E "/etc|application.*properties"') do
    its('stdout.strip') { should cmp '' }
  end
end
