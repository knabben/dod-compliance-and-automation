control 'VCSA-70-000268' do
  title 'The vCenter Server must set the distributed port group Forged Transmits policy to "Reject".'
  desc 'If the virtual machine operating system changes the Media Access Control (MAC) address, the operating system can send frames with an impersonated source MAC address at any time. This allows an operating system to stage malicious attacks on the devices in a network by impersonating a network adaptor authorized by the receiving network.

When the "Forged Transmits" option is set to "Accept", ESXi does not compare source and effective MAC addresses.

To protect against MAC impersonation, set the "Forged Transmits" option to "Reject". The host compares the source MAC address being transmitted by the guest operating system with the effective MAC address for its virtual machine adapter to determine if they match. If the addresses do not match, the ESXi host drops the packet.'
  desc 'check', 'If distributed switches are not used, this is not applicable.

From the vSphere Client, go to "Networking".

Select a distributed switch and then select a port group.

Select Configure >> Settings >> Policies.

Verify "Forged Transmits" is set to "Reject".

or

From a PowerCLI command prompt while connected to the vCenter server, run the following commands:

Get-VDSwitch | Get-VDSecurityPolicy
Get-VDPortgroup | ?{$_.IsUplink -eq $false} | Get-VDSecurityPolicy

If the "Forged Transmits" policy is set to accept for a nonuplink port, this is a finding.'
  desc 'fix', 'From the vSphere Client, go to "Networking".

Select a distributed switch and then select a port group.

Select Configure >> Settings >> Policies.

Click "Edit".

Click the "Security" tab.

Set "Forged Transmits" to "Reject".

Click "OK".

or

From a PowerCLI command prompt while connected to the vCenter server, run the following commands:

Get-VDSwitch | Get-VDSecurityPolicy | Set-VDSecurityPolicy -ForgedTransmits $false
Get-VDPortgroup | ?{$_.IsUplink -eq $false} | Get-VDSecurityPolicy | Set-VDSecurityPolicy -ForgedTransmits $false'
  impact 0.5
  tag check_id: 'C-60023r885653_chk'
  tag severity: 'medium'
  tag gid: 'V-256348'
  tag rid: 'SV-256348r885655_rule'
  tag stig_id: 'VCSA-70-000268'
  tag gtitle: 'SRG-APP-000516'
  tag fix_id: 'F-59966r885654_fix'
  tag cci: ['CCI-000366']
  tag nist: ['CM-6 b']

  command = 'Get-VDSwitch | Select -ExpandProperty Name'
  vdswitches = powercli_command(command).stdout.gsub("\r\n", "\n").split("\n")

  if vdswitches.empty?
    describe '' do
      skip 'No distributed switches found to check.'
    end
  else
    vdswitches.each do |vds|
      command = "(Get-VDSwitch -Name \"#{vds}\") | Get-VDSecurityPolicy | Select-Object -ExpandProperty ForgedTransmits"
      describe powercli_command(command) do
        its('stdout.strip') { should cmp 'false' }
      end
    end
  end

  command = 'Get-VDPortgroup | Where-Object {$_.IsUplink -eq $false} | Select -ExpandProperty Name'
  vdportgroups = powercli_command(command).stdout.gsub("\r\n", "\n").split("\n")

  if vdportgroups.empty?
    describe '' do
      skip 'No distributed port groups found to check.'
    end
  else
    vdportgroups.each do |vdpg|
      command = "(Get-VDPortgroup -Name \"#{vdpg}\") | Get-VDSecurityPolicy | Select-Object -ExpandProperty ForgedTransmits"
      describe powercli_command(command) do
        its('stdout.strip') { should cmp 'false' }
      end
    end
  end
end
