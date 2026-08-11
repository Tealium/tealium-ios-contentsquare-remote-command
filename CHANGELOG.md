# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0]

### Removed
- **BREAKING:** Removed the `forgetMe` command. Contentsquare deprecated `forgetMe` in SDK 2.28.0 and removed it in SDK 4.45.0. There is no direct replacement; refer to the [Contentsquare privacy documentation](https://docs.contentsquare.com/en/ios/privacy/#forget-me) for guidance.

### Changed
- **BREAKING:** Raised the minimum supported iOS version to 13.0, to match the Contentsquare SDK requirement.
- Bumped the Contentsquare SDK dependency from `~> 4.19` to `~> 4.52.1`.

## [2.4.0] - 2025-05-29

### Added
- Added the `sendUserIdentifier` command.
- Added custom variables support with an index/name/value structure.

## [2.3.0] - 2024-03-13

### Changed
- Added support for Xcode 15.
- Raised the minimum iOS deployment target to iOS 12.

## [2.2.1] - 2023-02-22

### Changed
- Removed the arm64 architecture exclusion from CocoaPods.

## [2.2.0] - 2023-02-13

### Changed
- Bumped the minimum iOS version to 12.
- Updated to the latest Tealium SDK.
- Updated to the latest Contentsquare SDK.

## [2.1.0] - 2022-02-02

### Added
- Added the version of the Remote Command to the DataLayer.

### Changed
- Updated the Contentsquare minimum version to 4.10.
- Updated the Tealium Swift minimum version to 2.6.0.

## [2.0.0] - 2020-10-21

### Changed
- Updated for JSON-controlled Remote Commands.
- Updated to the latest version of the Contentsquare SDK.
- Sample app updates.

## [1.0.0] - 2020-04-06

### Added
- Initial release: a [Contentsquare](https://docs.contentsquare.com/ios/#get-started) integration with the [Tealium SDK](https://github.com/tealium/tealium-swift) that enables Contentsquare API calls to be made through Tealium's track API.

[3.0.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.4.0...3.0.0
[2.4.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.3.0...2.4.0
[2.3.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.2.1...2.3.0
[2.2.1]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.2.0...2.2.1
[2.2.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/compare/1.0.0...2.0.0
[1.0.0]: https://github.com/Tealium/tealium-ios-contentsquare-remote-command/releases/tag/1.0.0
