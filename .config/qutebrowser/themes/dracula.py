# def blood(c, options = {}):
options = {}

dracula = {
    'background': '#282a36',
    'background-alt': '#282a36',
    'background-attention': '#181920',
    'border': '#282a36',
    'current-line': '#44475a',
    'selection': '#44475a',
    'foreground': '#f8f8f2',
    'foreground-alt': '#e0e0e0',
    'foreground-attention': '#ffffff',
    'comment': '#6272a4',
    'cyan': '#8be9fd',
    'green': '#50fa7b',
    'orange': '#ffb86c',
    'pink': '#ff79c6',
    'purple': '#bd93f9',
    'red': '#ff5555',
    'yellow': '#f1fa8c'
}

spacing = options.get('spacing', {
    'vertical': 5,
    'horizontal': 5
})

padding = options.get('padding', {
    'top': spacing['vertical'],
    'right': spacing['horizontal'],
    'bottom': spacing['vertical'],
    'left': spacing['horizontal']
})

## Background color of the completion widget category headers.
c.colors.completion.category.bg = dracula['background']

## Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = dracula['border']

## Top border color of the completion widget category headers.
c.colors.completion.category.border.top = dracula['border']

## Foreground color of completion widget category headers.
c.colors.completion.category.fg = dracula['foreground']

## Background color of the completion widget for even rows.
c.colors.completion.even.bg = dracula['background']

## Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = dracula['background-alt']

## Text color of the completion widget.
c.colors.completion.fg = dracula['foreground']

## Background color of the selected completion item.
c.colors.completion.item.selected.bg = dracula['selection']

## Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = dracula['selection']

## Top border color of the completion widget category headers.
c.colors.completion.item.selected.border.top = dracula['selection']

## Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = dracula['foreground']

## Foreground color of the matched text in the completion.
c.colors.completion.match.fg = dracula['orange']

## Color of the scrollbar in completion view
c.colors.completion.scrollbar.bg = dracula['background']

## Color of the scrollbar handle in completion view.
c.colors.completion.scrollbar.fg = dracula['foreground']

## Background color for the download bar.
c.colors.downloads.bar.bg = dracula['background']

## Background color for downloads with errors.
c.colors.downloads.error.bg = dracula['background']

## Foreground color for downloads with errors.
c.colors.downloads.error.fg = dracula['red']

## Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = dracula['background']

## Color gradient interpolation system for download backgrounds.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
c.colors.downloads.system.bg = 'none'

## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
c.colors.hints.bg = dracula['background']

## Font color for hints.
c.colors.hints.fg = dracula['purple']

## Hints
c.hints.border = '1px solid ' + dracula['background-alt']

## Font color for the matched part of hints.
c.colors.hints.match.fg = dracula['foreground-alt']

## Background color of the keyhint widget.
c.colors.keyhint.bg = dracula['background']

## Text color for the keyhint widget.
c.colors.keyhint.fg = dracula['purple']

## Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = dracula['selection']

## Background color of an error message.
c.colors.messages.error.bg = dracula['background']

## Border color of an error message.
c.colors.messages.error.border = dracula['background-alt']

## Foreground color of an error message.
c.colors.messages.error.fg = dracula['red']

## Background color of an info message.
c.colors.messages.info.bg = dracula['background']

## Border color of an info message.
c.colors.messages.info.border = dracula['background-alt']

## Foreground color an info message.
c.colors.messages.info.fg = dracula['comment']

## Background color of a warning message.
c.colors.messages.warning.bg = dracula['background']

## Border color of a warning message.
c.colors.messages.warning.border = dracula['background-alt']

## Foreground color a warning message.
c.colors.messages.warning.fg = dracula['red']

## Background color for prompts.
c.colors.prompts.bg = dracula['background']

# ## Border used around UI elements in prompts.
c.colors.prompts.border = '1px solid ' + dracula['background-alt']

## Foreground color for prompts.
c.colors.prompts.fg = dracula['cyan']

## Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = dracula['selection']

## Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = dracula['background']

## Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = dracula['orange']

## Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = dracula['background']

## Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = dracula['orange']

## Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = dracula['background']

## Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = dracula['pink']

## Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = dracula['background']

## Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = dracula['foreground-alt']

## Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = dracula['background-attention']

## Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = dracula['foreground-attention']

## Background color of the statusbar.
c.colors.statusbar.normal.bg = dracula['background']

## Foreground color of the statusbar.
c.colors.statusbar.normal.fg = dracula['foreground']

## Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = dracula['background']

## Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = dracula['orange']

## Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = dracula['background-alt']

## Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = dracula['foreground-alt']

## Background color of the progress bar.
c.colors.statusbar.progress.bg = dracula['background']

## Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = dracula['red']

## Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = dracula['foreground']

## Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = dracula['cyan']

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.http.fg = dracula['green']

## Foreground color of the URL in the statusbar on successful load
c.colors.statusbar.url.success.https.fg = dracula['green']

## Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = dracula['yellow']

## Status bar padding
c.statusbar.padding = padding

## Background color of the tab bar.
## Type: QtColor
c.colors.tabs.bar.bg = dracula['selection']

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = dracula['selection']

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = dracula['foreground']

## Color for the tab indicator on errors.
## Type: QtColor
c.colors.tabs.indicator.error = dracula['red']

## Color gradient start for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.start = dracula['orange']

## Color gradient end for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.stop = dracula['green']

## Color gradient interpolation system for the tab indicator.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
c.colors.tabs.indicator.system = 'none'

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = dracula['selection']

## Foreground color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.fg = dracula['foreground']

# ## Background color of selected even tabs.
# ## Type: QtColor
c.colors.tabs.selected.even.bg = dracula['background']

# ## Foreground color of selected even tabs.
# ## Type: QtColor
c.colors.tabs.selected.even.fg = dracula['foreground']

# ## Background color of selected odd tabs.
# ## Type: QtColor
c.colors.tabs.selected.odd.bg = dracula['background']

# ## Foreground color of selected odd tabs.
# ## Type: QtColor
c.colors.tabs.selected.odd.fg = dracula['foreground']

## Tab padding
c.tabs.padding = padding
c.tabs.indicator.width = 1
c.tabs.favicons.scale = 1
