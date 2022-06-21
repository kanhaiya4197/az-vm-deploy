#! /bin/bash

#Download and unarchive agent package
# If vsts_agent_fullurl is set this specific version will be downloaded instead of latest
# https://vstsagentpackage.azureedge.net/agent/2.204.0/vsts-agent-linux-x64-2.204.0.tar.gz
cd /tmp && wget https://vstsagentpackage.azureedge.net/agent/2.204.0/vsts-agent-linux-x64-2.204.0.tar.gz --no-check-certificate
cd / && mkdir myagent && cd myagent
tar zxvf /tmp/vsts-agent-linux-x64-2.204.0.tar.gz
#Configure vsts-agent
./config.sh --unattended --acceptteeeula --url $vsts_server_url --auth PAT --token $vsts_accesstoken --pool $vsts_poolname --agent $vsts_agent_name --work $vsts_workfolder --replace
#Initial installation of systemd service files and generation of runsvc.sh
sudo ./svc.sh install && sudo ./svc.sh start




