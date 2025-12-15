# Add $HOME/bin to PATH if it exists
if test -d $HOME/bin
    fish_add_path $HOME/bin
end

# Add Homebrew to PATH if running on macOS and brew is available
if test (uname) = Darwin
    if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
    else if test -x /usr/local/bin/brew
        eval (/usr/local/bin/brew shellenv)
    end
end

if command -q brew
    brew shellenv | source
end

#if test -d /opt/homebrew/Cellar/postgresql@13/13.22/bin
#    fish_add_path /opt/homebrew/Cellar/postgresql@13/13.22/bin
#end

# Add claude to PATH if available
if type -q claude
    set -l claude_path (dirname (command -v claude))
    fish_add_path $claude_path
end

#check mise
if test -d $HOME/.local/bin/mise
    eval ($HOME/.local/bin/mise activate fish)
end

#check zoxide
if command -q zoxide
    zoxide init fish | source
end

if command -q direnv
    direnv hook fish | source
end

# Set editor
if test -d $HOME/bin/nvim
    export EDITOR=$HOME/bin/nvim
end

if status is-interactive
    # Initialize Starship prompt if installed
    if type -q starship
        starship init fish | source
    end

    alias vim=nvim
    alias dc=docker compose
    alias k=kubectl
end
