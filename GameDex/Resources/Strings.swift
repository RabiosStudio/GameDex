// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// First, add the game title and optionnally the corresponding platform.
  internal static let addBasicGameInformationDescription = L10n.tr("Localizable", "addBasicGameInformationDescription", fallback: "First, add the game title and optionnally the corresponding platform.")
  /// Add a game
  internal static let addGame = L10n.tr("Localizable", "addGame", fallback: "Add a game")
  /// Coming soon...!
  internal static let comingSoon = L10n.tr("Localizable", "comingSoon", fallback: "Coming soon...!")
  /// Continue
  internal static let `continue` = L10n.tr("Localizable", "continue", fallback: "Continue")
  /// Discover
  internal static let discover = L10n.tr("Localizable", "discover", fallback: "Discover")
  /// It's time to add the very first game to your collection ! 
  internal static let emptyMyCollectionDescription = L10n.tr("Localizable", "emptyMyCollectionDescription", fallback: "It's time to add the very first game to your collection ! ")
  /// Your collection is empty
  internal static let emptyMyCollectionTitle = L10n.tr("Localizable", "emptyMyCollectionTitle", fallback: "Your collection is empty")
  /// Import
  internal static let `import` = L10n.tr("Localizable", "import", fallback: "Import")
  /// is Required
  internal static let isRequired = L10n.tr("Localizable", "isRequired", fallback: "is Required")
  /// Manually
  internal static let manually = L10n.tr("Localizable", "manually", fallback: "Manually")
  /// Add your games manually by filling a form
  internal static let manuallyDescription = L10n.tr("Localizable", "manuallyDescription", fallback: "Add your games manually by filling a form")
  /// My Collection
  internal static let myCollection = L10n.tr("Localizable", "myCollection", fallback: "My Collection")
  /// My Profile
  internal static let myProfile = L10n.tr("Localizable", "myProfile", fallback: "My Profile")
  /// Platform
  internal static let platform = L10n.tr("Localizable", "platform", fallback: "Platform")
  /// Scan codebar
  internal static let scan = L10n.tr("Localizable", "scan", fallback: "Scan codebar")
  /// Search a platform
  internal static let searchPlatform = L10n.tr("Localizable", "searchPlatform", fallback: "Search a platform")
  /// Select platform
  internal static let selectPlatform = L10n.tr("Localizable", "selectPlatform", fallback: "Select platform")
  /// Step 1/3
  internal static let stepOneOutOfThree = L10n.tr("Localizable", "stepOneOutOfThree", fallback: "Step 1/3")
  /// Title
  internal static let title = L10n.tr("Localizable", "title", fallback: "Title")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
