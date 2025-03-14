Setting up a dev machine with Ubuntu.
- Copy `github_dummy` to the dev machine
- Create file called `config` in `~/.ssh/` directory with the following content
    Host github.com
            HostName github.com
            User git
            IdentityFile ~/.ssh/github_dummy
- Clone `git clone git@github.com:vjabrayilov/dotfiles.git`
- Run `cd dotfiles && ./setup.sh`

