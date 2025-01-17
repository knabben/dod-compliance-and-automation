control 'VCLD-67-000034' do
  title 'VAMI must implement TLS1.2 exclusively.'
  desc  "Transport Layer Security (TLS) is a required transmission protocol for
a web server hosting controlled information. The use of TLS provides
confidentiality of data in transit between the web server and client. FIPS
140-2 approved TLS versions must be enabled, and non-FIPS-approved SSL versions
must be disabled.

    VAMI comes configured to use only TLS 1.2. This configuration must be
verified and maintained.
  "
  desc  'rationale', ''
  desc  'check', "
    Note: The below command must be run from a bash shell and not from a shell
generated by the \"appliance shell\". Use the \"chsh\" command to change the
shell for the account to \"/bin/bash\".

    At the command prompt, execute the following command:

    # /opt/vmware/sbin/vami-lighttpd -p -f
/opt/vmware/etc/lighttpd/lighttpd.conf|grep \"ssl.use\"

    Expected result:

        ssl.use-tlsv12                    = \"enable\"
        ssl.use-sslv2                     = \"disable\"
        ssl.use-sslv3                     = \"disable\"
        ssl.use-tlsv10                    = \"disable\"
        ssl.use-tlsv11                    = \"disable\"

    If the output does not match the expected result, this is a finding.
  "
  desc 'fix', "
    Navigate to and open /opt/vmware/etc/lighttpd/lighttpd.conf.

    Replace any and all \"ssl.use-*\" lines with following:

    ssl.use-tlsv12 = \"enable\"
    ssl.use-sslv2 = \"disable\"
    ssl.use-sslv3 = \"disable\"
    ssl.use-tlsv10 = \"disable\"
    ssl.use-tlsv11 = \"disable\"
  "
  impact 0.7
  tag severity: 'high'
  tag gtitle: 'SRG-APP-000439-WSR-000156'
  tag gid: 'V-239741'
  tag rid: 'SV-239741r816831_rule'
  tag stig_id: 'VCLD-67-000034'
  tag fix_id: 'F-42933r679332_fix'
  tag cci: ['CCI-002418']
  tag nist: ['SC-8']

  runtime = command("#{input('lighttpdBin')} -p -f #{input('lighttpdConf')}").stdout

  describe parse_config(runtime).params['ssl.use-sslv2'] do
    it { should cmp '"disable"' }
  end

  describe parse_config(runtime).params['ssl.use-sslv3'] do
    it { should cmp '"disable"' }
  end

  describe parse_config(runtime).params['ssl.use-tlsv10'] do
    it { should cmp '"disable"' }
  end

  describe parse_config(runtime).params['ssl.use-tlsv11'] do
    it { should cmp '"disable"' }
  end

  describe parse_config(runtime).params['ssl.use-tlsv12'] do
    it { should cmp '"enable"' }
  end
end
