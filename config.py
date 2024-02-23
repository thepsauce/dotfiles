config.load_autoconfig()

config.bind('<z><l>', 'spawn --userscript qute-pass')
config.bind('<z><u><l>', 'spawn --userscript qute-pass --username-only')
config.bind('<z><p><l>', 'spawn --userscript qute-pass --password-only')
config.bind('<z><o><l>', 'spawn --userscript qute-pass --otp-only')

config.bind('<;><c>', 'hint all right-click')

config.set("colors.webpage.preferred_color_scheme", "dark")
config.set("content.headers.user_agent", "Mozilla/5.0 (X11; Linux x86_64; rv:120.0) Gecko/20100101 Firefox/120.0")

config.set("content.blocking.enabled", True)
config.set("content.javascript.clipboard", "access")

config.set("content.pdfjs", True)
