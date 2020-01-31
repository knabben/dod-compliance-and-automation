control "VCUI-67-000020" do
  title "vSphere UI must set the welcome-file node to a default web page."
  desc  "Enumeration techniques, such as URL parameter manipulation, rely upon
being able to obtain information about the web server's directory structure by
locating directories without default pages. In the scenario, the web server
will display to the user a listing of the files in the directory being
accessed. By having a default hosted application web page, the anonymous web
user will not obtain directory browsing information or an error message that
reveals the server type and version. Ensuring that every document directory has
an index.jsp (or equivalent) file is one approach to mitigating the
vulnerability."
  impact CAT II
  tag severity: "CAT II"
  tag gtitle: nil
  tag gid: nil
  tag rid: "VCUI-67-000020"
  tag stig_id: "VCUI-67-000020"
  tag fix_id: nil
  tag cci: nil
  tag nist: nil
  tag false_negatives: nil
  tag false_positives: nil
  tag documentable: nil
  tag mitigations: nil
  tag severity_override_guidance: nil
  tag potential_impacts: nil
  tag third_party_tools: nil
  tag mitigation_controls: nil
  tag responsibility: nil
  tag ia_controls: nil
  tag check: "At the command prompt, execute the following command:

# xmllint --format /usr/lib/vmware-vsphere-ui/server/conf/web.xml | sed
's/xmlns=\".*\"//g' | xmllint --xpath '/web-app/welcome-file-list' -

Expected result:

<welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
  </welcome-file-list>

If the output of the command does not match the expected result, this is a
finding."
  tag fix: "Navigate to and open /usr/lib/vmware-vsphere-ui/server/conf/web.xml

Add the following section under the <web-apps> node:

 \xC2\xA0 \xC2\xA0<welcome-file-list>
 \xC2\xA0 \xC2\xA0 \xC2\xA0 \xC2\xA0<welcome-file>index.html</welcome-file>
 \xC2\xA0 \xC2\xA0 \xC2\xA0 \xC2\xA0<welcome-file>index.htm</welcome-file>
 \xC2\xA0 \xC2\xA0 \xC2\xA0 \xC2\xA0<welcome-file>index.jsp</welcome-file>
 \xC2\xA0 \xC2\xA0</welcome-file-list>
"
end

