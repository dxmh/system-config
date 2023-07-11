{
  "browser.search.hiddenOneOffs" = "Amazon.co.uk,Bing,eBay,Wikipedia (en)";
  "browser.toolbars.bookmarks.visibility" = "never";
  "browser.search.region" = "GB";
  "browser.warnOnQuitShortcut" = false;
  "browser.newtabpage.pinned" = "[]";
  "browser.newtabpage.activity-stream.feeds.topsites" = false;

  #############################################################################
  #
  # Below is a subset of Firefox Hardening options (version: 0.20.0):
  #  https://gist.github.com/brainfucksec/68e79da1c965aeaa4782914afd8f7fa2
  #
  # For more information see the full Firefox Hardening article at:
  #  https://brainfucksec.github.io/firefox-hardening-guide
  #
  #############################################################################

  #############################################################################
  # StartUp Settings
  #############################################################################

  # disable about:config warning
  "browser.aboutConfig.showWarning" = false;

  # disable default browser check
  "browser.shell.checkDefaultBrowser" = false;

  # set startup page:
  #    0 = blank
  #    1 = home
  #    2 = last visited page
  #    3 = resume previous session
  "browser.startup.page" = 1;
  "browser.startup.homepage" = "about:home";

  # disable activity stream on new windows and tab pages
  "browser.newtabpage.enabled" = false;
  "browser.newtab.preload" = false;
  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
  "browser.newtabpage.activity-stream.telemetry" = false;
  "browser.newtabpage.activity-stream.feeds.snippets" = false;
  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
  "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
  "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
  "browser.newtabpage.activity-stream.showSponsored" = false;
  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
  "browser.newtabpage.activity-stream.default.sites" = "";

  #############################################################################
  # Geolocation
  #############################################################################

  # use Mozilla geolocation service instead of Google if permission is granted
  "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";

  # disable using the OS’s geolocation service
  "geo.provider.use_corelocation" = false;

  # disable region updates
  "browser.region.network.url" = "";
  "browser.region.update.enabled" = false;

  #############################################################################
  # Language / Locale
  #############################################################################

  # set language for displaying web pages:
  "intl.accept_languages" = "en-US, en";
  "javascript.use_us_english_locale" = true;

  #############################################################################
  # Auto-updates / Recommendations
  #############################################################################

  # disable auto-installing Firefox updates
  "app.update.auto" = false;

  # disable addons recommendations (use Google Analytics)
  "extensions.getAddons.showPane" = false;
  "extensions.htmlaboutaddons.recommendations.enabled" = false;
  "browser.discovery.enabled" = false;

  #############################################################################
  # Telemetry
  #############################################################################

  # disable telemetry
  "datareporting.policy.dataSubmissionEnabled" = false;
  "datareporting.healthreport.uploadEnabled" = false;
  "toolkit.telemetry.enabled" = false;
  "toolkit.telemetry.unified" = false;
  "toolkit.telemetry.server" = "data:,";
  "toolkit.telemetry.archive.enabled" = false;
  "toolkit.telemetry.newProfilePing.enabled" = false;
  "toolkit.telemetry.shutdownPingSender.enabled" = false;
  "toolkit.telemetry.updatePing.enabled" = false;
  "toolkit.telemetry.bhrPing.enabled" = false;
  "toolkit.telemetry.firstShutdownPing.enabled" = false;
  "toolkit.telemetry.coverage.opt-out" = true;
  "toolkit.coverage.opt-out" = true;
  "toolkit.coverage.endpoint.base." = "";
  "browser.ping-centre.telemetry" = false;
  "beacon.enabled" = false;

  #############################################################################
  # Studies
  #############################################################################

  # disable studies
  "app.shield.optoutstudies.enabled" = false;

  # disable normandy/shield
  "app.normandy.enabled" = false;
  "app.normandy.api_url" = "";

  #############################################################################
  # Crash Reports
  #############################################################################

  # disable crash reports
  "breakpad.reportURL" = "";
  "browser.tabs.crashReporting.sendReport" = false;

  #############################################################################
  # Captive Portal Detection / Network Checks
  #############################################################################

  # disable captive portal detection
  "captivedetect.canonicalURL" = "";
  "network.captive-portal-service.enabled" = false;

  # disable network connections checks
  "network.connectivity-service.enabled" = false;

  #############################################################################
  # Safe Browsing
  #############################################################################

  # disable safe browsing service
  "browser.safebrowsing.malware.enabled" = false;
  "browser.safebrowsing.phishing.enabled" = false;

  # disable list of blocked URI
  "browser.safebrowsing.blockedURIs.enabled" = false;

  # disable fetch of updates
  "browser.safebrowsing.provider.google4.gethashURL" = "";
  "browser.safebrowsing.provider.google4.updateURL" = "";
  "browser.safebrowsing.provider.google.gethashURL" = "";
  "browser.safebrowsing.provider.google.updateURL" = "";
  "browser.safebrowsing.provider.google4.dataSharingURL" = "";

  # disable checks for downloads
  "browser.safebrowsing.downloads.enabled" = false;
  "browser.safebrowsing.downloads.remote.enabled" = false;
  "browser.safebrowsing.downloads.remote.url" = "";

  # disable checks for unwanted software
  "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
  "browser.safebrowsing.downloads.remote.block_uncommon" = false;

  # disable bypasses the block of safe browsing with a click for current session
  "browser.safebrowsing.allowOverride" = false;

  #############################################################################
  # Network: DNS, Proxy, IPv6
  #############################################################################

  # disable link prefetching
  "network.prefetch-next" = false;

  # disable DNS prefetching
  "network.dns.disablePrefetch" = true;

  # disable predictor / prefetching
  "network.predictor.enabled" = false;

  # disable link-mouseover opening connection to linked server
  "network.http.speculative-parallel-limit" = 0;

  # disable mousedown speculative connections on bookmarks and history
  "browser.places.speculativeConnect.enabled" = false;

  # disable IPv6
  "network.dns.disableIPv6" = true;

  # disable "GIO" protocols as a potential proxy bypass vectors
  "network.gio.supported-protocols" = "";

  # disable using UNC (Uniform Naming Convention) paths (prevent proxy bypass)
  "network.file.disable_unc_paths" = true;

  # remove special permissions for certain mozilla domains
  "permissions.manager.defaultsUrl" = "";

  # use Punycode in Internationalized Domain Names to eliminate possible spoofing
  "network.IDN_show_punycode" = true;

  #############################################################################
  # Search Bar: Suggestions, Autofill
  #############################################################################

  # disable search suggestions
  "browser.search.suggest.enabled" = false;
  "browser.urlbar.suggest.searches" = false;

  # disable location bar domain guessing
  "browser.fixup.alternate.enabled" = false;

  # display all parts of the url in the bar
  "browser.urlbar.trimURLs" = false;

  # disable location bar making speculative connections
  "browser.urlbar.speculativeConnect.enabled" = false;

  # disable form autofill
  "browser.formfill.enable" = false;
  "extensions.formautofill.addresses.enabled" = false;
  "extensions.formautofill.available" = "off";
  "extensions.formautofill.creditCards.available" = false;
  "extensions.formautofill.creditCards.enabled" = false;
  "extensions.formautofill.heuristics.enabled" = false;

  # disable location bar contextual suggestions:
  "browser.urlbar.quicksuggest.scenario" = "history";
  "browser.urlbar.quicksuggest.enabled" = false;
  "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
  "browser.urlbar.suggest.quicksuggest.sponsored" = false;

  #############################################################################
  # Passwords
  #############################################################################

  # disable saving passwords
  "signon.rememberSignons" = false;

  # disable autofill login and passwords
  "signon.autofillForms" = false;

  # disable formless login capture for Password Manager
  "signon.formlessCapture.enabled" = false;

  # hardens against potential credentials phishing:
  #    0 = don't allow sub-resources to open HTTP authentication credentials dialogs
  #    1 = don't allow cross-origin sub-resources to open HTTP authentication credentials dialogs
  #    2 = allow sub-resources to open HTTP authentication credentials dialogs (default)
  "network.auth.subresource-http-auth-allow" = 1;

  #############################################################################
  # HTTPS / SSL/TLS / OSCP / CERTS
  #############################################################################

  # enable HTTPS-Only mode in all windows
  "dom.security.https_only_mode" = true;

  # disable sending HTTP request for checking HTTPS support by the server
  "dom.security.https_only_mode_send_http_background_request" = false;

  # display advanced information on Insecure Connection warning pages
  "browser.xul.error_pages.expert_bad_cert" = true;

  # disable TLS 1.3 0-RTT (round-trip time)
  "security.tls.enable_0rtt_data" = false;

  # set OCSP to terminate the connection when a CA isn't validate
  "security.OCSP.require" = true;

  # disable SHA-1 certificates
  "security.pki.sha1_enforcement_level" = 1;

  # enable strict pinning (PKP (Public Key Pinning)):
  #    0 = disabled
  #    1 = allow user MiTM (i.e. your Antivirus)
  #    2 = strict
  "security.cert_pinning.enforcement_level" = 2;

  # enable CRLite
  #    0 = disabled
  #    1 = consult CRLite but only collect telemetry (default)
  #    2 = consult CRLite and enforce both "Revoked" and "Not Revoked" results
  #    3 = consult CRLite and enforce "Not Revoked" results, but defer to OCSP for "Revoked"
  "security.remote_settings.crlite_filters.enabled" = true;
  "security.pki.crlite_mode" = 2;

  #############################################################################
  # Headers / Referers
  #############################################################################

  # control when to send a referer:
  #    0 = always (default)
  #    1 = only if base domains match
  #    2 = only if hosts match
  "network.http.referer.XOriginPolicy" = 2;

  # control amount of information to send:
  #    0 = send full URI (default):  https://example.com:8888/foo/bar.html?id=1234
  #    1 = scheme+host+port+path:    https://example.com:8888/foo/bar.html
  #    2 = scheme+host+port:         https://example.com:8888
  "network.http.referer.XOriginTrimmingPolicy" = 2;

  #############################################################################
  # Audio/Video: WebRTC, WebGL
  #############################################################################

  # disable WebRTC
  "media.peerconnection.enabled" = false;

  # force WebRTC inside the proxy
  "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;

  # force a single network interface for ICE candidates generation
  "media.peerconnection.ice.default_address_only" = true;

  # force exclusion of private IPs from ICE candidates
  "media.peerconnection.ice.no_host" = true;

  # disable autoplay of HTML5 media, You can set exceptions under site
  # permissions.
  #    0 = allow all
  #    1 = block non-muted media (default)
  #    5 = block all
  "media.autoplay.default" = 5;

  # disable DRM Content
  "media.eme.enabled" = false;

  #############################################################################
  # Downloads
  #############################################################################

  # always ask you where to save files:
  "browser.download.useDownloadDir" = false;

  # disable adding downloads to system's "recent documents" list
  "browser.download.manager.addToRecentDocs" = false;

  #############################################################################
  # Cookies
  #############################################################################

  # enable ETP (Enhanced Tracking Protection)
  # ETP strict mode enables Total Cookie Protection (TCP)
  "browser.contentblocking.category" = "strict";

  # enable state partitioning of service workers
  "privacy.partition.serviceWorkers" = true;

  # enable APS (Always Partitioning Storage)
  "privacy.partition.always_partition_third_party_non_cookie_storage" = true;
  "privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage" = false;

  #############################################################################
  # UI Features
  #############################################################################

  # block popup windows
  "dom.disable_open_during_load" = true;

  # limit events that can cause a popup
  "dom.popup_allowed_events" = "click dblclick mousedown pointerdown";

  # disable Pocket extension
  "extensions.pocket.enabled" = false;

  # disable Screenshots extension
  "extensions.screenshots.disabled" = true;

  # disable PDFJS scripting
  "pdfjs.enableScripting" = false;

  # enable Containers and show the UI settings
  "privacy.userContext.enabled" = true;
  "privacy.userContext.ui.enabled" = true;

  #############################################################################
  # Extensions
  #############################################################################

  # extensions are allowed to work on restricted domains, while their scope
  # is set to profile+applications.
  # See: https://mike.kaply.com/2012/02/21/understanding-add-on-scopes/
  "extensions.enabledScopes" = 5;
  "extensions.webextensions.restrictedDomains" = "";

  # Display always the installation prompt
  "extensions.postDownloadThirdPartyPrompt" = false;

  #############################################################################
  # Fingerprinting
  #############################################################################

  # RFP (Resist Fingerprinting):
  #
  # can cause some website breakage: mainly canvas, use a site
  # exception via the urlbar.
  #
  # RFP also has a few side effects: mainly timezone is UTC0, and
  # websites will prefer light theme.
  # [1] https://bugzilla.mozilla.org/418986
  #
  # See: https://support.mozilla.org/en-US/kb/firefox-protection-against-fingerprinting
  "privacy.resistFingerprinting" = true;

  # set new window size rounding max values
  "privacy.window.maxInnerWidth" = 1600;
  "privacy.window.maxInnerHeight" = 900;

  # disable mozAddonManager Web API
  "privacy.resistFingerprinting.block_mozAddonManager" = true;

  # disable showing about:blank page when possible at startup
  "browser.startup.blankWindow" = false;
}
