# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
# config.load_autoconfig()

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'file://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome://*/*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'qute://*/*')

# ,m opens page with mpv
config.bind(',m', 'spawn --detach mpv {url}')
# ,M hints and oens choice with mpv
config.bind(',M', 'hint links spawn --detach mpv {hint-url}')

# Position of the tab bar.
# Type: Position
# Valid values:
#   - top
#   - bottom
#   - left
#   - right
c.tabs.position = 'left'

# Width (in pixels or as percentage of the window) of the tab bar if
# it's vertical.
# Type: PercOrInt
c.tabs.width = '7%'

# Maximum width (in pixels) of tabs (-1 for no maximum). This setting
# only applies when tabs are horizontal. This setting does not apply to
# pinned tabs, unless `tabs.pinned.shrink` is False. This setting may
# not apply properly if max_width is smaller than the minimum size of
# tab contents, or smaller than tabs.min_width.
# Type: Int
c.tabs.max_width = 20

# Font used in the tab bar.
# Type: QtFont
c.fonts.tabs = '8pt monospace'


##  mmmm                              #              mmmm  #                      m                    m
## #"   "  mmm    mmm    m mm   mmm   # mm          #"   " # mm    mmm    m mm  mm#mm   mmm   m   m  mm#mm   mmm
## "#mmm  #"  #  "   #   #"  " #"  "  #"  #         "#mmm  #"  #  #" "#   #"  "   #    #"  "  #   #    #    #   "
##     "# #""""  m"""#   #     #      #   #             "# #   #  #   #   #       #    #      #   #    #     """m
## "mmm#" "#mm"  "mm"#   #     "#mm"  #   #         "mmm#" #   #  "#m#"   #       "mm  "#mm"  "mm"#    "mm  "mmm"

# Google
c.url.searchengines['goog'] = 'https://google.com/search?q={}'
# Arch User Repository
c.url.searchengines['aur'] = 'https://aur.archlinux.org/packages/?O=0&K={}'
# Arch Wiki
c.url.searchengines['aw'] = 'https://wiki.archlinux.org/?search={}'
# Wordpress
c.url.searchengines['wps'] = 'https://developer.wordpress.org/?s={}'
# Wordpress - Only functions
c.url.searchengines['wpf'] = 'https://developer.wordpress.org/?s={}&post_type%5B%5D=wp-parser-function'
# Wordpress - Only hooks
c.url.searchengines['wph'] = 'https://developer.wordpress.org/?s={}&post_type%5B%5D=wp-parser-hook'
# Wordpress - Only classes
c.url.searchengines['wpc'] = 'https://developer.wordpress.org/?s={}&post_type%5B%5D=wp-parser-class'
# Wordpress - Only methods
c.url.searchengines['wpm'] = 'https://developer.wordpress.org/?s={}&post_type%5B%5D=wp-parser-method'
# PHP.net
c.url.searchengines['phps'] = 'https://secure.php.net/manual-lookup.php?pattern={}&scope=quickref'
# Can I Use
c.url.searchengines['ciu'] = 'https://caniuse.com/#search={}'
# Mozzila Developer Network web docs
c.url.searchengines['mdn'] = 'https://developer.mozilla.org/en-US/search?q={}'
# GitHub
c.url.searchengines['gh'] = 'https://github.com/search?q={}'
