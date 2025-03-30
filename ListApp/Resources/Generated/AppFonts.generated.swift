// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
public typealias FontSwift = FontConvertible.FontSwift

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum AppFonts {
  public enum Chivo {
    public static let bold = FontConvertible(name: "Chivo-Bold", family: "Chivo", path: "Chivo-Bold.ttf")
    public static let extraBold = FontConvertible(name: "Chivo-ExtraBold", family: "Chivo", path: "Chivo-ExtraBold.ttf")
    public static let regular = FontConvertible(name: "Chivo-Regular", family: "Chivo", path: "Chivo-Regular.ttf")
    public static let all: [FontConvertible] = [bold, extraBold, regular]
  }
  public enum ZonaPro {
    public static let bold = FontConvertible(name: "ZonaPro-Bold", family: "Zona Pro", path: "ZonaPro-Bold.otf")
    public static let regular = FontConvertible(name: "ZonaPro-Regular", family: "Zona Pro", path: "ZonaPro-Regular.ttf")
    public static let thin = FontConvertible(name: "ZonaPro-Thin", family: "Zona Pro", path: "ZonaPro-Thin.otf")
    public static let all: [FontConvertible] = [bold, regular, thin]
  }
  public static let allCustomFonts: [FontConvertible] = [Chivo.all, ZonaPro.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct FontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias FontSwift = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias FontSwift = UIFont
  #endif
  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public typealias FontSwiftUI = SwiftUI.Font
  #endif

  public func font(size: CGFloat) -> FontSwift {
    guard let font = FontSwift(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if compiler(>=5.5)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func fontSwiftUI(size: CGFloat) -> FontSwiftUI {
    let font = self.font(size: size)
    let fontSwiftUI: FontSwiftUI = .init(font)

    return fontSwiftUI
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

public extension FontConvertible.FontSwift {
  convenience init?(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
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
// swiftlint:enable all