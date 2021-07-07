// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal enum Assets {
    internal static let btnBack = ImageAsset(name: "btnBack")
    internal static let btnClose = ImageAsset(name: "btnClose")
    internal static let btnGameOff = ImageAsset(name: "btnGameOff")
    internal static let btnGameOn = ImageAsset(name: "btnGameOn")
    internal static let btnGameTreasurebox = ImageAsset(name: "btnGameTreasurebox")
    internal static let btnHome = ImageAsset(name: "btnHome")
    internal static let btnMonthOff = ImageAsset(name: "btnMonthOff")
    internal static let btnMonthOn = ImageAsset(name: "btnMonthOn")
    internal static let btnMypage = ImageAsset(name: "btnMypage")
    internal static let btnQr = ImageAsset(name: "btnQr")
    internal static let btnResetOff = ImageAsset(name: "btnResetOff")
    internal static let btnResetOn = ImageAsset(name: "btnResetOn")
    internal static let btnSaveOff = ImageAsset(name: "btnSaveOff")
    internal static let btnSaveOn = ImageAsset(name: "btnSaveOn")
    internal static let btnSearch = ImageAsset(name: "btnSearch")
    internal static let btnSetting = ImageAsset(name: "btnSetting")
    internal static let btnVideoPause = ImageAsset(name: "btnVideoPause")
    internal static let btnVideoPlay = ImageAsset(name: "btnVideoPlay")
    internal static let icAdd = ImageAsset(name: "icAdd")
    internal static let icAmen = ImageAsset(name: "icAmen")
    internal static let icAmen100 = ImageAsset(name: "icAmen100")
    internal static let icArrow = ImageAsset(name: "icArrow")
    internal static let icBasicProfileBoy = ImageAsset(name: "icBasicProfileBoy")
    internal static let icBasicProfileGirl = ImageAsset(name: "icBasicProfileGirl")
    internal static let icBible = ImageAsset(name: "icBible")
    internal static let icCheckNodata = ImageAsset(name: "icCheckNodata")
    internal static let icCheckOff = ImageAsset(name: "icCheckOff")
    internal static let icCheckOfflineOn = ImageAsset(name: "icCheckOfflineOn")
    internal static let icCheckOnlineOn = ImageAsset(name: "icCheckOnlineOn")
    internal static let icChurchDay = ImageAsset(name: "icChurchDay")
    internal static let icChurchNight = ImageAsset(name: "icChurchNight")
    internal static let icDayAbsent = ImageAsset(name: "icDayAbsent")
    internal static let icDayAttendance = ImageAsset(name: "icDayAttendance")
    internal static let icDelete = ImageAsset(name: "icDelete")
    internal static let icFriday = ImageAsset(name: "icFriday")
    internal static let icFullScreenOff = ImageAsset(name: "icFullScreenOff")
    internal static let icFullScreenOn = ImageAsset(name: "icFullScreenOn")
    internal static let icGameResultFailed = ImageAsset(name: "icGameResultFailed")
    internal static let icGameResultGoldkey1 = ImageAsset(name: "icGameResultGoldkey1")
    internal static let icGameResultGoldkey2 = ImageAsset(name: "icGameResultGoldkey2")
    internal static let icGameResultNul = ImageAsset(name: "icGameResultNul")
    internal static let icGameRouletteArrow = ImageAsset(name: "icGameRouletteArrow")
    internal static let icGameTreasureboxArrow = ImageAsset(name: "icGameTreasureboxArrow")
    internal static let icGoldkey = ImageAsset(name: "icGoldkey")
    internal static let icGoldkeyGage = ImageAsset(name: "icGoldkeyGage")
    internal static let icKeyboardDelete = ImageAsset(name: "icKeyboardDelete")
    internal static let icLive = ImageAsset(name: "icLive")
    internal static let icMoodAngry = ImageAsset(name: "icMoodAngry")
    internal static let icMoodSad = ImageAsset(name: "icMoodSad")
    internal static let icMoodSurprised = ImageAsset(name: "icMoodSurprised")
    internal static let icMoodThanks = ImageAsset(name: "icMoodThanks")
    internal static let icMoodWorry = ImageAsset(name: "icMoodWorry")
    internal static let icNightAbsent = ImageAsset(name: "icNightAbsent")
    internal static let icNightAttendance = ImageAsset(name: "icNightAttendance")
    internal static let icOnBadge = ImageAsset(name: "icOnBadge")
    internal static let icProfileConnection = ImageAsset(name: "icProfileConnection")
    internal static let icQrFrameLeftBottom = ImageAsset(name: "icQrFrameLeftBottom")
    internal static let icQrFrameLeftTop = ImageAsset(name: "icQrFrameLeftTop")
    internal static let icQrFrameRightBottom = ImageAsset(name: "icQrFrameRightBottom")
    internal static let icQrFrameRightTop = ImageAsset(name: "icQrFrameRightTop")
    internal static let icSearch = ImageAsset(name: "icSearch")
    internal static let icSelectOff = ImageAsset(name: "icSelectOff")
    internal static let icSelectOn = ImageAsset(name: "icSelectOn")
    internal static let icStampBgOff = ImageAsset(name: "icStampBgOff")
    internal static let icStampBgOn = ImageAsset(name: "icStampBgOn")
    internal static let icTag = ImageAsset(name: "icTag")
    internal static let icWarning = ImageAsset(name: "icWarning")
    internal static let icGoldkeyNumberImg = ImageAsset(name: "ic_goldkey_number_img")
    internal static let icInfoLevelImg = ImageAsset(name: "ic_info_level_img")
    internal static let illustrationApril = ImageAsset(name: "illustrationApril")
    internal static let illustrationAugust = ImageAsset(name: "illustrationAugust")
    internal static let illustrationDecember = ImageAsset(name: "illustrationDecember")
    internal static let illustrationFeburary = ImageAsset(name: "illustrationFeburary")
    internal static let illustrationJanuary = ImageAsset(name: "illustrationJanuary")
    internal static let illustrationJuly = ImageAsset(name: "illustrationJuly")
    internal static let illustrationJune = ImageAsset(name: "illustrationJune")
    internal static let illustrationMarch = ImageAsset(name: "illustrationMarch")
    internal static let illustrationMay = ImageAsset(name: "illustrationMay")
    internal static let illustrationNovember = ImageAsset(name: "illustrationNovember")
    internal static let illustrationOctober = ImageAsset(name: "illustrationOctober")
    internal static let illustrationSeptember = ImageAsset(name: "illustrationSeptember")
    internal static let imgCharactersSet = ImageAsset(name: "imgCharactersSet")
    internal static let imgGameRouletteBg = ImageAsset(name: "imgGameRouletteBg")
    internal static let imgGameRoulettePin = ImageAsset(name: "imgGameRoulettePin")
    internal static let imgGameThumbRoulette = ImageAsset(name: "imgGameThumbRoulette")
    internal static let imgGameThumbTreasurebox = ImageAsset(name: "imgGameThumbTreasurebox")
    internal static let imgGameTreasureboxBody = ImageAsset(name: "imgGameTreasureboxBody")
    internal static let imgGameTreasureboxLid = ImageAsset(name: "imgGameTreasureboxLid")
    internal static let imgLevelUp = ImageAsset(name: "imgLevelUp")
    internal static let imgSaveCheck = ImageAsset(name: "imgSaveCheck")
    internal static let imgAppbarDay = ImageAsset(name: "img_appbar_day")
    internal static let imgAppbarNight = ImageAsset(name: "img_appbar_night")
    internal static let imgSplashText = ImageAsset(name: "img_splash_text")
    internal static let splashAppicon = ImageAsset(name: "splash_appicon")
  }
  internal enum Color {
    internal static let goldkeyYellow = ColorAsset(name: "GoldkeyYellow")
    internal static let gray1 = ColorAsset(name: "Gray1")
    internal static let gray2 = ColorAsset(name: "Gray2")
    internal static let gray3 = ColorAsset(name: "Gray3")
    internal static let gray4 = ColorAsset(name: "Gray4")
    internal static let gray5 = ColorAsset(name: "Gray5")
    internal static let gray6 = ColorAsset(name: "Gray6")
    internal static let lemon = ColorAsset(name: "Lemon")
    internal static let gray10 = ColorAsset(name: "gray10")
    internal static let gray7 = ColorAsset(name: "gray7")
    internal static let gray8 = ColorAsset(name: "gray8")
    internal static let gray9 = ColorAsset(name: "gray9")
    internal static let main = ColorAsset(name: "main")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
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
