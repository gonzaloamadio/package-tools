import os
import sys
import stat

HOOK_NAMES = [
    'applypatch-msg',
    'commit-msg',
    'fsmonitor-watchman',
    'post-update',
    'pre-applypatch',
    'pre-commit',
    'pre-push',
    'pre-rebase',
    'pre-receive',
    'prepare-commit-msg',
    'update',
]


hook_to_append = sys.argv[1]
command = sys.argv[2]

if hook_to_append not in HOOK_NAMES:
    raise Exception('Invalid hook name {}, should be one of these: {}'.format(hook_to_append, HOOK_NAMES))

hook_to_append = '.git/hooks/{}'.format(hook_to_append)


if not os.path.exists(command):
    raise Exception('Cannot find {}'.format(command))

command_is_executable = bool(os.stat(command).st_mode & stat.S_IEXEC)
if not command_is_executable:
    raise Exception('The command added is not executable. Run chmod +x {}'.format(command))
with open(command, 'r') as f:
    first_line = f.readline()
if '#!/' not in first_line:
    raise Exception('The file {} should start with a #!/<executable>'.format(command))

if not os.path.exists(hook_to_append):
    with open(hook_to_append, 'w') as f:
        f.write('#!/bin/bash\n')
        f.write('set -euo pipefail\n')

    st = os.stat(hook_to_append)
    os.chmod(hook_to_append, st.st_mode | stat.S_IEXEC)

with open(hook_to_append, 'a') as f:
    f.write('./{} $@\n'.format(command))
