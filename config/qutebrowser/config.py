# Qutebrowser configuration
#
# Autoconfig.yml has been merged into this file.
# Changes made through qutebrowser's :set/:bind commands will no longer
# be loaded automatically from autoconfig.yml.

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------

c.aliases = {
    'q': 'close',
    'qa': 'quit',
    'tc': 'tab-close',
    'w': 'session-save',
    'wq': 'quit --save',
    'wqa': 'quit --save',
}


# ---------------------------------------------------------------------------
# Qt
# ---------------------------------------------------------------------------

c.qt.highdpi = False
c.qt.workarounds.disable_hangouts_extension = False


# ---------------------------------------------------------------------------
# Content
# ---------------------------------------------------------------------------

c.content.cookies.accept = 'no-3rdparty'

c.content.default_encoding = 'utf-8'

c.content.headers.accept_language = 'de-DE,de;q=0.9,en;q=0.6'

c.content.blocking.method = 'both'

c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
]

c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist.to/easylistgermany/easylistgermany.txt',
]

c.content.local_content_can_access_remote_urls = True

c.content.notifications.presenter = 'libnotify'

c.content.unknown_url_scheme_policy = 'allow-all'


# ---------------------------------------------------------------------------
# Downloads
# ---------------------------------------------------------------------------

c.downloads.location.directory = '~/Downloads'
c.downloads.open_dispatcher = 'xdg-open'


# ---------------------------------------------------------------------------
# Editor
# ---------------------------------------------------------------------------

c.editor.command = [
    'vim',
    '-f',
    '{file}',
    '-c',
    'normal {line}G{column0}l',
]


# ---------------------------------------------------------------------------
# Fonts
# ---------------------------------------------------------------------------

c.fonts.default_family = 'JetBrainsMono Nerd Font Mono'
c.fonts.default_size = '14pt'

c.fonts.web.family.fixed = None
c.fonts.web.family.standard = None

c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 14


# ---------------------------------------------------------------------------
# Scrolling
# ---------------------------------------------------------------------------

c.scrolling.smooth = True


# ---------------------------------------------------------------------------
# URL / Search
# ---------------------------------------------------------------------------

c.url.default_page = 'https://startpage.com/'

c.url.start_pages = 'https://startpage.com'

c.url.searchengines = {
    'DEFAULT': 'https://www.startpage.com/do/search?query={}',
    'asn': 'https://api.hackertarget.com/aslookup/?q={}',
    'br': 'https://search.brave.com/search?q={}',
    'de': 'https://de.thefreedictionary.com/{}',
    'ody': 'https://odysee.com/$/search?q={}',
    'q': 'https://lite.qwant.com/?q={}',
    'tr': 'https://www.linguee.com/english-german/search?source=auto&query={}',
    'ts': 'https://www.openthesaurus.de/synonyme/{}',
    'wp': 'https://de.wikipedia.org/w/index.php?search={}',
    'yt': 'https://inv.thepixora.com/search?q={}',
}


# ---------------------------------------------------------------------------
# Zoom
# ---------------------------------------------------------------------------

c.zoom.default = '125%'


# ---------------------------------------------------------------------------
# Colors
# ---------------------------------------------------------------------------

c.colors.completion.category.fg = 'white'

c.colors.webpage.bg = None
c.colors.webpage.preferred_color_scheme = 'dark'

c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.page = 'smart'

c.colors.tabs.selected.odd.bg = '#2076B1'
c.colors.tabs.selected.even.bg = '#2076B1'


# ---------------------------------------------------------------------------
# Key mappings
# ---------------------------------------------------------------------------

c.bindings.key_mappings = {
    '<Ctrl+6>': '<Ctrl+^>',
    '<Ctrl+Enter>': '<Ctrl+Return>',
    '<Ctrl+[>': '<Escape>',
    '<Ctrl+j>': '<Return>',
    '<Ctrl+m>': '<Return>',
    '<Enter>': '<Return>',
    '<Shift+Enter>': '<Return>',
    '<Shift+Return>': '<Return>',
}


# ---------------------------------------------------------------------------
# Normal mode bindings
# ---------------------------------------------------------------------------

config.bind(',v', 'hint links spawn mpv {hint-url}')
config.bind(',i', 'hint images download')

config.bind('<Backspace>', ':back')
config.bind('<Shift+Left>', 'tab-prev')
config.bind('<Shift+Right>', 'tab-next')

config.bind('C', 'tab-close')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')

config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind(
    'xx',
    'config-cycle statusbar.show always never;; '
    'config-cycle tabs.show always never',
)

# Keep q disabled in normal mode and map tab-next to K.
config.unbind('q')
config.bind('tab-next', 'K')


# ---------------------------------------------------------------------------
# UI
# ---------------------------------------------------------------------------

c.statusbar.show = 'always'
c.tabs.show = 'always'


# ---------------------------------------------------------------------------
# Other Config
# ---------------------------------------------------------------------------

# Disable autoconfig.yml
config.load_autoconfig(False)

