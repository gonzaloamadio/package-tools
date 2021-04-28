#!/usr/bin/python

# adds the jira issue identifier at start of message 
# (uses the branch name if no identifier is found)
# use as commit-msg

import subprocess
import sys
import re

msg_filepath = sys.argv[1]
rx = re.compile('[A-Z]+-\d+')

with open(msg_filepath, 'r') as f:
    content = f.read()

p = subprocess.Popen('git rev-parse --abbrev-ref HEAD'.split(' '), stdout=subprocess.PIPE)
branch_name = p.stdout.read().strip()
jira_issues = rx.findall(branch_name)
jira_issue_prefix = ''
if len(jira_issues) > 0:
    jira_issue_prefix = ' '.join(jira_issues)
else:
    jira_issue_prefix = branch_name

jira_issue_prefix += ':'

if jira_issue_prefix not in content:
	with open(msg_filepath, 'w') as f:
	    print('.git/hooks/commit-msg: Adding prefix \'{}\' to commit msg.'.format(jira_issue_prefix))
	    f.write('{} {}'.format(jira_issue_prefix, content))
