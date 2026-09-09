# Sourced by the Nix-managed ~/.zshrc (see home.nix). Edit in place, no rebuild needed.

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.9/bin:$HOME/.ghcup/bin:$PATH"

# --- integrations ---
test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
command -v scw >/dev/null && eval "$(scw autocomplete script shell=zsh)"

# --- aliases ---
alias agent='npm run agent --'
alias nv='nvim'
alias chrome='open -a "Google Chrome"'

# --- functions ---
# nf <name>  open the first file matching <name> in nvim; nf alone fuzzy-picks one
nf() {
  local file
  if [ -n "$1" ]; then
    file=$(find . -type f -name "$1" | head -1)
    [ -n "$file" ] && nvim "$file" || echo "File not found: $1"
  else
    file=$(find . -type f | sed 's|^\./||' | fzf --prompt="Open file: ")
    [ -n "$file" ] && nvim "$file"
  fi
}

tex() { nvim "$1"; }

# Claude Conversation Manager (Chrome app) with its search shortcut
ccm() {
  open "$HOME/Applications/Chrome Apps.localized/Claude Conversation Manager.app"
  sleep 1
  osascript -e 'tell application "Claude Conversation Manager" to activate' \
            -e 'tell application "System Events" to keystroke "f" using {control down, command down}'
}

# --- cheat sheet on every new shell ---
cat <<'SHEET'
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  CHEAT SHEET
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  AI & TOOLS
    claude-personal     personal account   -> ~/.claude-personal
    claude-admination   business account   -> ~/.claude-admination
    ccm                 open Claude Conversation Manager
  EDITING
    nf                  fuzzy-find and open a file in nvim
    nv <file>           open file in nvim
    tex <file.tex>      open in nvim (auto-compiles + Skim)
  NVIM BASICS
    i                   start typing  (Insert mode)
    jk  or  Escape      stop typing   (Normal mode)
    :w  :q  :wq         save / quit / save and quit
  VIEWING FILES
    bat <file>          view file with syntax colors
  APPS (open -a)
    chrome              Google Chrome
    open -a AltTab | Calculator | Calendar | MacWhisper | Music
    open -a Notes | Photos | Skim | WhatsApp | zoom.us | Zotero
  CHROME APPS (~/Applications/Chrome Apps)
    open -a Admination | GCalendar | Gemini | GitHub | Gmail
    open -a "Google Maps" | "Google Meet" | Prisma | quiver | "Supabase Studio"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SHEET
