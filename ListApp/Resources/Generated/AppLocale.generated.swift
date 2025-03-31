// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation
import SwiftUI

// swiftlint:disable all
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum AppLocale {
    // MARK: - Constants

    public enum Constants {
        public static let defaultTable: String = "Localizable"
    }

    private static let userDefaults = UserDefaults.standard
    private static var currentLocalize: LocalizeKeys {
        (userDefaults.object(forKey: "currentLocalize") as? LocalizeKeys) ?? .english
    }

    public static var currentLanguageCode: String { currentLocalize.code }


  public enum DetailScreen {
      /// Detail Info
      public static var title: String { AppLocale.tr("Localize", "DetailScreen.title") }
    public enum Model {
        /// Created
        public static var created: String { AppLocale.tr("Localize", "DetailScreen.Model.created") }
        /// Gender
        public static var gender: String { AppLocale.tr("Localize", "DetailScreen.Model.gender") }
        /// Location
        public static var location: String { AppLocale.tr("Localize", "DetailScreen.Model.location") }
        /// Origin
        public static var origin: String { AppLocale.tr("Localize", "DetailScreen.Model.origin") }
        /// Species
        public static var species: String { AppLocale.tr("Localize", "DetailScreen.Model.species") }
        /// Status
        public static var status: String { AppLocale.tr("Localize", "DetailScreen.Model.status") }
        /// Type
        public static var type: String { AppLocale.tr("Localize", "DetailScreen.Model.type") }
    }
  }

  public enum ListScreen {
      /// List
      public static var title: String { AppLocale.tr("Localize", "ListScreen.title") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

public extension AppLocale {
    static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        // swiftlint:disable:next nslocalizedstring_key
        let path = Bundle(for: BundleToken.self).path(forResource: AppLocale.currentLanguageCode, ofType: "lproj")
        let bundle = Bundle(path: path!) ?? Bundle(for: BundleToken.self)
        let format = NSLocalizedString(key, tableName: table, bundle: bundle, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
    static func tr(_ key: String) -> String {
        tr(Constants.defaultTable, key)
    }
}

private final class BundleToken {}
// swiftlint:enable all