import argparse
import os

HOME = os.environ["HOME"]
DOT_SSH = "{}/.ssh".format(HOME)
GIT_ROOT = "{}/git_tree".format(HOME)
GO_ROOT = "{}/git_tree/gopath".format(HOME)
CONFIG_ROOT = "{}/.config".format(HOME)
BIN = "{}/bin".format(HOME)
FONTS_ROOT = "{}/.fonts".format(HOME)
DOWNLOADS = "{}/Downloads".format(HOME)


def parser_init():
    parser = argparse.ArgumentParser(description="Setup the system")
    parser.add_argument('action', metavar='action', nargs=1, type=str, choices=['install', 'symlinks'])
    return parser


def run_shell(cmd, wd=''):
    if wd != '':
        os.chdir(wd)
    os.system(cmd)


def mkdir(d):
    try:
        os.mkdir(d)
    except FileExistsError:
        pass 


def install_packages():
    packages = ['python3-pip', 'emacs-nox', 'wmctrl', 'tmux', 'copyq', 'xclip', 'golang-go', 'dconf-editor', 'i3',
                'rofi', 'feh', 'libxkbfile-dev', 'cmake', 'lxappearance', 'numlockx', 'xdotool', 'fzf',
                'autotools-dev', 'autoconf', 'libtool', 'libtool-bin', 'rofi-dev', 'libqalculate-dev', 'qalculate',
                'clang', 'clangd', 'libstdc++-10-dev', 'libstdc++-10-doc', 'gcc-10', 'gcc-10-base', 'gcc-10-doc',
                'silversearcher-ag', 'python-is-python3'
                ]
    run_shell("sudo -S apt update")
    run_shell("sudo -S apt install -y {}".format(str.join(" ", packages)))


def add_repos():
    mkdir(DOWNLOADS)
    run_shell('/usr/bin/wget https://launchpad.net/~kxstudio-debian/+archive/kxstudio/+files/kxstudio-repos_10.0.3_all.deb', DOWNLOADS)
    run_shell("sudo -S dpkg -i kxstudio-repos_10.0.3_all.deb", DOWNLOADS)
    run_shell('''sudo -S mv 'home:manuelschneid3r.asc' $HOME''', '/etc/apt/trusted.gpg.d')
    run_shell('wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo -S apt-key add -')
    run_shell('echo "deb https://download.sublimetext.com/ apt/stable/" | sudo -S tee /etc/apt/sources.list.d/sublime-text.list')


def clone_go_repos():
    repos = ["github.com/wincent/clipper"]
    for repo in repos:
        run_shell("go get {}".format(repo), GO_ROOT + "/src")


def clone_repos():
    repos = ['https://github.com/trueneu/dotfiles.git', 'https://github.com/rbreaves/kinto.git',
             'https://github.com/grwlf/xkb-switch.git', 'https://github.com/trueneu/xkeysnail.git',
             'https://github.com/svenstaro/rofi-calc.git',
             ]
    for repo in repos:
        run_shell("git clone {}".format(repo), GIT_ROOT)


def install_xkeysnail():
    run_shell('sudo -S pip3 install --upgrade .', GIT_ROOT + "/xkeysnail")


def install_kinto():
    run_shell('./setup.py', GIT_ROOT + "/kinto/")


def install_clipper():
    run_shell('go build', GO_ROOT + "/src/github.com/wincent/clipper")
    run_shell('cp clipper {}'.format(BIN), GO_ROOT + "/src/github.com/wincent/clipper")


def install_xkbswitch():
    mkdir(GIT_ROOT + "/xkb-switch/build")
    run_shell("cmake ..", GIT_ROOT + "/xkb-switch/build")
    run_shell("make", GIT_ROOT + "/xkb-switch/build")
    run_shell("sudo -S make install", GIT_ROOT + "/xkb-switch/build")
    run_shell("sudo -S ldconfig", GIT_ROOT + "/xkb-switch/build")


def install_rofi_calc():
    run_shell("autoreconf -i", GIT_ROOT + "/rofi-calc")
    mkdir(GIT_ROOT + "/rofi-calc/build")
    run_shell("../configure", GIT_ROOT + "/rofi-calc/build")
    run_shell("make", GIT_ROOT + "/rofi-calc/build")
    run_shell("sudo -S make install", GIT_ROOT + "/rofi-calc/build")
    run_shell("sudo -S libtool --finish /usr/lib/x86_64-linux-gnu/rofi//", GIT_ROOT + "/rofi-calc/build")


def enable_services():
    user_svcs = ["clipper.service"]
    for user_svc in user_svcs:
        systemd_user_enable(user_svc)


def create_symlinks():
    links = {
        "clipper.service": CONFIG_ROOT + "/systemd/user/clipper.service",
        "ssh-config": DOT_SSH + "/config",
        ".tmux.conf": HOME + "/.tmux.conf",
        ".tmux.conf.linux": HOME + "/.tmux.conf.linux",
        ".gitconfig": HOME + "/.gitconfig",
        "kinto.py": CONFIG_ROOT + "/kinto/kinto.py",
        "i3/config": CONFIG_ROOT + "/i3/config",
        "i3/.i3status.conf": HOME + "/.i3status.conf",
        ".Xresources": HOME + "/.Xresources",
        "copyq.conf": CONFIG_ROOT + "/copyq/copyq.conf",
    }

    for k, v in links.items():
        run_shell("ln -sf {} {}".format(GIT_ROOT + "/dotfiles/" + k, v))


def create_bin_symlinks():
    run_shell('ls -1 | while read f ; do ln -s $HOME/git_tree/dotfiles/bin/$f $HOME/bin/$f ; done',
              GIT_ROOT + "/dotfiles/bin")


def bashrc():
    run_shell('''echo '[ -f ~/git_tree/dotfiles/.bashrc ] && source ~/git_tree/dotfiles/.bashrc' >> $HOME/.bashrc''')


def systemd_user_enable(svc):
    run_shell("systemd --user daemon-reload")
    run_shell("systemd --user enable {}".format(svc))
    run_shell("systemd --user start {}".format(svc))


def install_fonts():
    run_shell('cp fts.tgz {}'.format(FONTS_ROOT), GIT_ROOT + "/dotfiles")
    run_shell('tar xvzf fts.tgz', FONTS_ROOT)
    run_shell('rm fts.tgz', FONTS_ROOT)
    run_shell('fc-cache -fv', FONTS_ROOT)


def wallpaper():
    mkdir(HOME + "/Pictures/wallpapers")
    run_shell('wget https://512pixels.net/downloads/macos-wallpapers/10-13.jpg', HOME + "/Pictures/wallpapers")


def install_jetbrains_toolbox():
    run_shell(GIT_ROOT + "/dotfiles/synchronizer/jetbrains-toolbox.sh")


def run():
    args = parser_init().parse_args()
    if args.action[0] == 'install':
        add_repos()
        install_packages()
        mkdir(GIT_ROOT)
        mkdir(GO_ROOT)
        mkdir(GO_ROOT + "/src")
        mkdir(BIN)
        mkdir(DOT_SSH)
        mkdir(CONFIG_ROOT)
        mkdir(CONFIG_ROOT + "/i3")
        mkdir(FONTS_ROOT)
        mkdir(CONFIG_ROOT + "/systemd/")
        mkdir(CONFIG_ROOT + "/systemd/user")
        mkdir(CONFIG_ROOT + "/copyq")

        clone_repos()
        clone_go_repos()

        install_xkeysnail()
        install_kinto()
        install_clipper()
        install_fonts()
        install_jetbrains_toolbox()
        install_rofi_calc()

        wallpaper()

        create_symlinks()
        create_bin_symlinks()
        enable_services()
        bashrc()

        print("All done. Don't forget about xkb symbols - I'm too lazy to script that!")
    elif args.action[0] == 'symlinks':
        create_symlinks()
        create_bin_symlinks()


if __name__ == '__main__':
    run()
