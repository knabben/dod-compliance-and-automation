control 'VCST-80-000025' do
  title 'The vCenter STS service logs folder permissions must be set correctly.'
  desc  'Log data is essential in the investigation of events. The accuracy of the information is always pertinent. One of the first steps an attacker will take is the modification or deletion of log records to cover tracks and prolong discovery. The web server must protect the log data from unauthorized modification.'
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # find /var/log/vmware/sso/ -xdev ! -name lookupsvc-init.log ! -name sts-prestart.log -type f -a '(' -perm -o+w -o -not -user sts -o -not -group lwis ')' -exec ls -ld {} \\;

    If any files are returned, this is a finding.
  "
  desc 'fix', "
    At the command prompt, run the following commands:

    # chmod o-w <file>
    # chown sts:lwis <file>

    Note: Substitute <file> with the listed file.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000118-AS-000078'
  tag satisfies: ['SRG-APP-000119-AS-000079', 'SRG-APP-000120-AS-000080']
  tag gid: 'V-VCST-80-000025'
  tag rid: 'SV-VCST-80-000025'
  tag stig_id: 'VCST-80-000025'
  tag cci: ['CCI-000162', 'CCI-000163', 'CCI-000164']
  tag nist: ['AU-9']

  logfiles = command("find '#{input('logPath')}' ! -name lookupsvc-init.log ! -name sts-prestart.log -type f -xdev").stdout
  if !logfiles.empty?
    logfiles.split.each do |fname|
      describe file(fname) do
        it { should_not be_writable.by('others') }
        its('owner') { should eq 'sts' }
        its('group') { should eq 'lwis' }
      end
    end
  else
    describe 'No log files found...skipping.' do
      skip 'No log files found...skipping.'
    end
  end
end
