# Add tools for syntax and style checkers (refernces at the end of this file)

This repo gives you a ready to use set of tools and commands useful for a project. For now, python/django.

You will find: 
* syntax formatting and checking with black, flake, isort.
* Security checks with safety and bandit.
* Installable git hooks with pre-commit package and the posibility to make our custom hooks and install them.

## Configurations

You will find black formatter config and relevant resources inside pyproject.tml file.

Resto of tools configurations in setup.cfg


Useful resources:
[Apply Black formatting without ruining your git blame](https://black.readthedocs.io/en/stable/installation_and_usage.html#migrating-your-code-style-without-ruining-git-blame)



## TODO

* Add https://mypy.readthedocs.io/en/stable/
* Check more packages used in cookiecutter and cookiecutter django (poetry for example) : [cookiecutter](https://github.com/pydanny/cookiecutter-django/tree/master/%7B%7Bcookiecutter.project_slug%7D%7D)
* Improve coverage scripts (more checks inside script with thresholds?)
* Improve frontend hooks
* Test bandit and safety scripts
* Test custom hooks
* Final overall testing
* Debate if we should use black or not ([read this](https://luminousmen.com/post/my-unpopular-opinion-about-black-code-formatter)), we can leave it in the makefile as optional.

## Easy way of using this repo

Copy this files and folder as they are in the root of your project. Except for package_tools and tests, they are intended to tests the functionality of this repo.

Execute ```make help``` to see available make targets.

Create venv and install packages: ```make install-venv```

Install hooks (see details in Hooks section of this readme): ```pre-commit install```

## Hard way of using this repo

### Create venv

Out of scope: But you should create your virtual env to work on, and activate it.

### Install packages

Versions may be upgraded. I locked them, because I have tested with this versions.

```
pip install black
pip install flake8==3.9.1
pip install pre-commit==2.12.1
pip install safety==1.10.3
pip install bandit==1.7.0
pip install safety==1.10.3
pip install coverage==5.2.1
pip install isort==5.4.2
```

### Create config files

Copy this files to the root of your project.
Change parameters as desired. *Be aware to put in every file the sime line-length.*

This file: *pyproject.toml*, will configure black formatter.

This file: *setup.cfg*, will configure flake, pylint, isort in a way that they are compatible with black formatter.

This file: *.pre-commit-config.yaml*, will configure pre-commit package. And will determine with hooks will run before a commit. Add, remove hooks as desired. All hooks available are listed in the hooks link provided further down in this file.

### Hooks

#### Configure pre-commit and install hooks

We should have the pre-commit config file (.pre-commit-config.yml)
There are a lot of hooks that can be configured. All hooks available to run : https://pre-commit.com/hooks.html

To install them, execute:

```
pre-commit install
```

That will add hooks to .git/hooks/pre-commit

New hooks usually will run on changed files during git hooks.
If we want to run them against all files
```pre-commit run --all-files```

Or for example if we want to run a specific hook, see this doc
https://pre-commit.com/#pre-commit-run


*Some useful links*

To uninstall pre-commit run `pre-commit uninstall`

We can also install hooks on pre-push or post-commit.
See https://pre-commit.com/#pre-commit-during-push

Config some hooks to run at certain stages (some hook only in pre-push, and not in pre-commit, etc)
https://pre-commit.com/#confining-hooks-to-run-at-certain-stages

Add to gitlab-ci
https://pre-commit.com/#gitlab-ci-example


#### Frontend hooks

TODO: Improve this section

See husky
https://prettier.io/docs/en/precommit.html


#### Run commands manually to see results

```
??? cp myPackage/example-error.py.example myPackage/example-error.py

??? flake8
./myPackage/example-error.py:1:1: F401 'os' imported but unused
./myPackage/example-error.py:5:5: F841 local variable 'var' is assigned to but never used
./myPackage/example-error.py:7:13: E126 continuation line over-indented for hanging indent
./myPackage/example-error.py:7:20: W291 trailing whitespace
./myPackage/example-error.py:8:17: E131 continuation line unaligned for hanging indent
./myPackage/example-error.py:9:16: E126 continuation line over-indented for hanging indent
./myPackage/example-error.py:11:120: E501 line too long (161 > 119 characters)

??? cat myPackage/example-error.py
import os


def foo():
    var = 1
    print(
            "Hello"
                "World"
               )

    print("veeeeeeeeeeeer looonnggg lineeeeeee   e  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee eeeeeeeeeeeeeeeeeeeeeeeeeeeeee")

??? black -S .
reformatted myPackage/example-error.py
All done! ??? ???? ???
1 file reformatted.

??? cat myPackage/example-error.py
import os


def foo():
    var = 1
    print("Hello" "World")

    print(
        "veeeeeeeeeeeer looonnggg lineeeeeee   e  eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee eeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
    )

??? flake8
./myPackage/example-error.py:1:1: F401 'os' imported but unused
./myPackage/example-error.py:5:5: F841 local variable 'var' is assigned to but never used
./myPackage/example-error.py:9:120: E501 line too long (158 > 119 characters)
```

### Example of hooks usage flow

```
??? pre-commit install
pre-commit installed at .git/hooks/pre-commit

??? cp myPackage/example-error.py.example myPackage/example-error.py

??? git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   myPackage/example-error.py

no changes added to commit (use "git add" and/or "git commit -a")

??? git add -A

??? git commit -m "Test pre-commmit hooks"
[INFO] Initializing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Initializing environment for https://github.com/psf/black.
[INFO] Initializing environment for https://gitlab.com/PyCQA/flake8.
[INFO] Installing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
[INFO] Installing environment for https://github.com/psf/black.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
[INFO] Installing environment for https://gitlab.com/PyCQA/flake8.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
Check Yaml...........................................(no files to check)Skipped
Fix End of Files.........................................................Passed
Trim Trailing Whitespace.................................................Failed
- hook id: trailing-whitespace
- exit code: 1
- files were modified by this hook

Fixing myPackage/example-error.py

black....................................................................Failed
- hook id: black
- files were modified by this hook

reformatted myPackage/example-error.py
All done! ??? ???? ???
1 file reformatted.

flake8...................................................................Failed
- hook id: flake8
- exit code: 1

myPackage/example-error.py:1:1: F401 'os' imported but unused
myPackage/example-error.py:5:5: F841 local variable 'var' is assigned to but never used
myPackage/example-error.py:9:120: E501 line too long (158 > 119 characters)

??? git add -A
??? git commit -m "Test pre-commmit hooks"
Check Yaml...........................................(no files to check)Skipped
Fix End of Files.....................................(no files to check)Skipped
Trim Trailing Whitespace.............................(no files to check)Skipped
black................................................(no files to check)Skipped
flake8...............................................(no files to check)Skipped
On branch master
nothing to commit, working tree clean

??? cp myPackage/example-error.py.example myPackage/example-error.py

??? git add -A
??? git commit -m "Test pre-commmit hooks"
Check Yaml...........................................(no files to check)Skipped
Fix End of Files.........................................................Passed
Trim Trailing Whitespace.................................................Failed
- hook id: trailing-whitespace
- exit code: 1
- files were modified by this hook

Fixing myPackage/example-error.py

black....................................................................Failed
- hook id: black
- files were modified by this hook

reformatted myPackage/example-error.py
All done! ??? ???? ???
1 file reformatted.

flake8...................................................................Failed
- hook id: flake8
- exit code: 1

myPackage/example-error.py:1:1: F401 'os' imported but unused
myPackage/example-error.py:5:5: F841 local variable 'var' is assigned to but never used
myPackage/example-error.py:9:120: E501 line too long (158 > 119 characters)
```

## Test

You can run python tests with: ```python -m unittest```,

And coverage tests with: ```coverage run -m unittest```

Reports:
* To stdout : ```coverage report```
* Html report: ```coverage html; open htmlcov/index.html```


