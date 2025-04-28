//
//  SettingsHelper.swift
//  EveryMinute
//
//  Created by Julian Schumacher on 27.04.25.
//

import Foundation
import CoreData

private enum Settings : String, RawRepresentable {
    case appVersion = "app_version_setting"
    case buildVersion = "build_version_setting"
    case eraseData = "erase_data_setting"
}

internal struct SettingsHelper {
    
    /// Setup function to call when starting the app
    internal static func setUp(context : NSManagedObjectContext) -> Void {
        updateVersion()
        if checkEraseData() {
            eraseAllData(context: context)
        }
    }
    
    /// Update the Version and Build Number of this App in the Settings
    /// App of the System
    private static func updateVersion() -> Void {
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleShortVersionString"], forKey: Settings.appVersion.rawValue)
        UserDefaults.standard.set(Bundle.main.infoDictionary!["CFBundleVersion"], forKey: Settings.buildVersion.rawValue)
    }
    
    /// Checks whether to erase all data of this app or not
    private static func checkEraseData() -> Bool {
        let erase = UserDefaults.standard.bool(forKey: Settings.eraseData.rawValue)
        if erase {
            UserDefaults.standard
                .set(false, forKey: Settings.eraseData.rawValue)
        }
        return erase
    }
    
    /// Actually erases data on the system
    internal static func eraseAllData(context : NSManagedObjectContext) -> Void {
        Storage.eraseAllData(context: context)
    }
}
