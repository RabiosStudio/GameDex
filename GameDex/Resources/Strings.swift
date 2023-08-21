// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add a game
  internal static let addGameButtonTitle = L10n.tr("Localizable", "addGameButtonTitle", fallback: "Add a game")
  /// First, add the game title and optionnally the corresponding platform.
  internal static let addGameStepOneDescription = L10n.tr("Localizable", "addGameStepOneDescription", fallback: "First, add the game title and optionnally the corresponding platform.")
  /// Continue
  internal static let `continue` = L10n.tr("Localizable", "continue", fallback: "Continue")
  /// Discover
  internal static let discover = L10n.tr("Localizable", "discover", fallback: "Discover")
  /// It's time to add the very first game to your collection ! 
  internal static let emptyCollectionDescription = L10n.tr("Localizable", "emptyCollectionDescription", fallback: "It's time to add the very first game to your collection ! ")
  /// Your collection is empty
  internal static let emptyCollectionTitle = L10n.tr("Localizable", "emptyCollectionTitle", fallback: "Your collection is empty")
  /// is Required
  internal static let isRequired = L10n.tr("Localizable", "isRequired", fallback: "is Required")
  /// My Collection
  internal static let myCollection = L10n.tr("Localizable", "myCollection", fallback: "My Collection")
  /// My Profile
  internal static let myProfile = L10n.tr("Localizable", "myProfile", fallback: "My Profile")
  /// Platform
  internal static let platform = L10n.tr("Localizable", "platform", fallback: "Platform")
  /// Step 1/3
  internal static let stepOne = L10n.tr("Localizable", "stepOne", fallback: "Step 1/3")
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
