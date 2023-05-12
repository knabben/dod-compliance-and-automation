control 'CFLM-4X-000018' do
  title 'The SDDC Manager LCM service must be protected from being stopped.'
  desc  "
    An attacker has at least two reasons to stop a web server. The first is to cause a DoS, and the second is to put in place changes the attacker made to the web server configuration.

    To prohibit an attacker from stopping the web server, the process ID (pid) of the web server and the utilities used to start/stop the web server must be protected from access by non-privileged users. By knowing the pid and having access to the web server utilities, a non-privileged user has a greater capability of stopping the server, whether intentionally or unintentionally.
  "
  desc  'rationale', ''
  desc  'check', "
    At the command prompt, run the following command:

    # grep management.endpoint.shutdown.enabled /opt/vmware/vcf/lcm/lcm-app/conf/application-prod.properties

    Expected result:

    management.endpoint.shutdown.enabled=false

    If the output does not match the expected result or is commented out, this is a finding.
  "
  desc 'fix', "
    Navigate to and open:

    /opt/vmware/vcf/lcm/lcm-app/conf/application-prod.properties

    Add or edit the following line to match below:

    management.endpoint.shutdown.enabled=false

    Restart the service for the setting to take effect.

    # systemctl restart lcm.service
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000435-WSR-000147'
  tag gid: 'V-CFLM-4X-000018'
  tag rid: 'SV-CFLM-4X-000018'
  tag stig_id: 'CFLM-4X-000018'
  tag cci: ['CCI-002385']
  tag nist: ['SC-5']

  describe parse_config_file(input('applicationProdPropertiesPath')) do
    its(['management.endpoint.shutdown.enabled']) { should cmp 'false' }
  end
end
