mkdir -p ~/.emacs.d/auto-install
cd ~/.emacs.d/auto-install
wget http://www.emacswiki.org/emacs/download/auto-install.el
emacs --batch -Q -f batch-byte-compile auto-install.el

wget http://chrispoole.com/downloads/ac-python.el
emacs --batch -Q -f batch-byte-compile ac-python.el

# (require 'auto-install)
# (auto-install-compatibility-setup)
