# Neovim Setup Notes

Personal reminders for configuring and troubleshooting this Neovim setup.

## Plugin Troubleshooting

### Markdown Preview
**Problem**: `:MarkdownPreview` does nothing.

**Fix**:
1. Go to the plugin directory:
   ```bash
   cd ~/.local/share/nvim/lazy/markdown-preview.nvim
   ```
2. Install the missing `tslib` dependency:
   ```bash
   npm install tslib
   ```

**Check**:
- Run `:checkhealth` in Neovim to confirm.
- Look for a warning about `tslib` missing if the issue persists.
