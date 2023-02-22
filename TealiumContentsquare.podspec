Pod::Spec.new do |s|

    # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.name         = "TealiumContentsquare"
    s.module_name  = "TealiumContentsquare"
    s.version      = "2.2.1"
    s.summary      = "Tealium Swift and Contentsquare integration"
    s.description  = <<-DESC
    Tealium's integration with Contentsquare for iOS.
    DESC
    s.homepage     = "https://github.com/Tealium/tealium-ios-contentsquare-remote-command"

    # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.license      = { :type => "Commercial", :file => "LICENSE.txt" }
    
    # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.authors            = { "Tealium Inc." => "tealium@tealium.com",
        "jonathanswong"   => "jonathan.wong@tealium.com",
        "christinasund"   => "christina.sund@tealium.com" }
    s.social_media_url   = "https://twitter.com/tealium"

    # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.swift_version = "5.1"
    s.platform     = :ios, "12.0"    

    # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.source       = { :git => "https://github.com/Tealium/tealium-ios-contentsquare-remote-command.git", :tag => "#{s.version}" }

    # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.ios.source_files      = "Sources/*.{swift}"

    # ――― Dependencies ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
    s.ios.dependency 'tealium-swift/Core', '~> 2.9'
    s.ios.dependency 'tealium-swift/RemoteCommands', '~> 2.9'
    s.ios.dependency 'CS_iOS_SDK', '~> 4.19'

end
