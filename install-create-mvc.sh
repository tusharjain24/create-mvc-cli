#!/bin/zsh
set -e

# ----------------------------
# Production-grade Installer
# ----------------------------

# Hidden installation directory
INSTALL_DIR="$HOME/.create-mvc"

# Create hidden folder
mkdir -p "$INSTALL_DIR"

# Copy CLI script
cp create-mvc.sh "$INSTALL_DIR/create-mvc"

# Make executable
chmod +x "$INSTALL_DIR/create-mvc"

# ----------------------------
# Ensure .zshrc exists
# ----------------------------
if [ ! -f "$HOME/.zshrc" ]; then
    echo "# Created by create-mvc installer" > "$HOME/.zshrc"
fi

# Add folder to PATH if not already
if ! grep -q 'export PATH="$HOME/.create-mvc:$PATH"' "$HOME/.zshrc"; then
    echo 'export PATH="$HOME/.create-mvc:$PATH"' >> "$HOME/.zshrc"
    echo "✅ Added ~/.create-mvc to PATH in ~/.zshrc"
fi

# Reload shell to apply changes
source "$HOME/.zshrc"

echo "✅ create-mvc installed successfully in $INSTALL_DIR!"
echo "👉 You can now run it from anywhere:"
echo "   create-mvc --help"
