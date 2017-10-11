//
//  AppState.swift
//  Nowhere
//
//  Created by Sam Warnick on 9/25/17.
//  Copyright © 2017 Sam Warnick. All rights reserved.
//

import Foundation
import UIKit

class AppState {
    
    static let sharedInstance = AppState()
    
    private let defaultTheme = STNTheme(
        primary: UIColor.white,
        secondary: UIColor.stnRichElectricBlue,
        text: UIColor.black,
        placeholder: UIColor.lightGray,
        other: UIColor.stnRichElectricBlue,
        icons: UIColor.stnColumbiaBlue)
    
    private let alternateTheme = STNTheme(
        primary: UIColor.stnRichElectricBlue,
        secondary: UIColor.white,
        text: UIColor.white,
        placeholder: UIColor.white,
        other: UIColor.stnColumbiaBlue,
        icons: UIColor.white)
    
    var currentTheme: STNTheme
    var usingAlternateTheme = false
    
    init() {
        currentTheme = defaultTheme
        loadTheme()
    }
    
    func useDefaultTheme() {
        usingAlternateTheme = false
        currentTheme = defaultTheme
        UserDefaults.standard.set(false, forKey: "Using Alternate Theme")
    }
    
    func useAlternateTheme() {
        usingAlternateTheme = true
        currentTheme = alternateTheme
        UserDefaults.standard.set(true, forKey: "Using Alternate Theme")
    }
    
    func loadTheme() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "Using Alternate Theme") {
            useAlternateTheme()
        } else {
            defaults.set(false, forKey: "Using Alternate Theme")
            useDefaultTheme()
        }
    }
}
