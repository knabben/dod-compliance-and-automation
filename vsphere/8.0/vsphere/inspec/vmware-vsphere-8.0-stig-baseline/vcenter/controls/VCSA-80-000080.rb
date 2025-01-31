control 'VCSA-80-000080' do
  title 'The vCenter Server must enable revocation checking for certificate-based authentication.'
  desc  'The system must establish the validity of the user-supplied identity certificate using Online Certificate Status Protocol (OCSP) and/or Certificate Revocation List (CRL) revocation checking.'
  desc  'rationale', ''
  desc  'check', "
    If a federated identity provider is configured and used for an identity source and supports Smartcard authentication, this is not applicable.

    From the vSphere Client, go to Administration >> Single Sign On >> Configuration >> Identity Provider >> Smart Card Authentication.

    Under Smart card authentication settings >> Certificate revocation, verify \"Revocation check\" does not show as disabled.

    If \"Revocation check\" shows as disabled, this is a finding.
  "
  desc 'fix', "
    From the vSphere Client, go to Administration >> Single Sign On >> Configuration >> Identity Provider >> Smart Card Authentication.

    Under Smart card authentication settings >> Certificate revocation, click the \"Edit\" button.

    Configure revocation checking per site requirements. OCSP with CRL failover is recommended.

    By default, both locations are pulled from the cert. CRL location can be overridden in this screen, and local responders can be specified via the sso-config command line tool. See the vSphere documentation for more information.

    Note: If FIPS mode is enabled on vCenter, OCSP revocation validation may not function and CRL used instead.
  "
  impact 0.5
  tag severity: 'medium'
  tag gtitle: 'SRG-APP-000175'
  tag satisfies: ['SRG-APP-000392', 'SRG-APP-000401', 'SRG-APP-000403']
  tag gid: 'V-VCSA-80-000080'
  tag rid: 'SV-VCSA-80-000080'
  tag stig_id: 'VCSA-80-000080'
  tag cci: ['CCI-000185', 'CCI-001954', 'CCI-001991', 'CCI-002010']
  tag nist: ['IA-2 (12)', 'IA-5 (2) (a)', 'IA-5 (2) (d)', 'IA-8 (1)']

  if input('embeddedIdp')
    describe.one do
      describe powercli_command('(Get-SsoAuthenticationPolicy).OCSPEnabled') do
        its('stdout.strip') { should cmp 'true' }
      end
      describe powercli_command('(Get-SsoAuthenticationPolicy).UseInCertCRL') do
        its('stdout.strip') { should cmp 'true' }
      end
      describe powercli_command('(Get-SsoAuthenticationPolicy).CRLUrl') do
        its('stdout.strip') { should_not cmp '' }
      end
    end
  else
    describe 'This check is a manual or policy based check and must be reviewed manually.' do
      skip 'This check is a manual or policy based check and must be reviewed manually.'
    end
  end
end
