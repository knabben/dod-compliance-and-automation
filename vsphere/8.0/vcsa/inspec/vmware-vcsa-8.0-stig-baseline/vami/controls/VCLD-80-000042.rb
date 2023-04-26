control 'VCLD-80-000042' do
  title 'The vCenter VAMI service must enable FIPS mode.'
  desc  'Encryption is only as good as the encryption modules used. Unapproved cryptographic module algorithms cannot be verified and cannot be relied on to provide confidentiality or integrity, and DOD data may be compromised due to weak algorithms. FIPS 140-2 is the current standard for validating cryptographic modules.'
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f /opt/vmware/etc/lighttpd/lighttpd.conf 2>/dev/null|grep \"server.fips-mode\"

    Expected result:

    server.fips-mode                  = \"enable\"

    If the output does not match the expected result, this is a finding.

    Note: The command must be run from a bash shell and not from a shell generated by the \"appliance shell\". Use the \"chsh\" command to change the shell for the account to \"/bin/bash\". Refer to KB Article 2100508 for more details:

    https://kb.vmware.com/s/article/2100508
  "
  desc 'fix', "
    Navigate to and open:

    /opt/vmware/etc/lighttpd/lighttpd.conf

    Add or reconfigure the following value:

    server.fips-mode = \"enable\"

    Restart the service with the following command:

    # vmon-cli --restart applmgmt
  "
  impact 0.7
  tag severity: 'high'
  tag gtitle: 'SRG-APP-000179-WSR-000111'
  tag satisfies: ['SRG-APP-000014-WSR-000006', 'SRG-APP-000416-WSR-000118', 'SRG-APP-000439-WSR-000188']
  tag gid: 'V-VCLD-80-000042'
  tag rid: 'SV-VCLD-80-000042'
  tag stig_id: 'VCLD-80-000042'
  tag cci: ['CCI-000068', 'CCI-000803', 'CCI-002418', 'CCI-002450']
  tag nist: ['AC-17 (2)', 'IA-7', 'SC-13', 'SC-8']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['server.fips-mode'] do
    it { should cmp '"enable"' }
  end
end