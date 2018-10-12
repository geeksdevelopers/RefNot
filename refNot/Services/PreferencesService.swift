//
//  PreferencesService.swift
//  refNot
//
//  Created by Gleb Shendrik on 09/10/2018.
//  Copyright © 2018 geeksdevelopers. All rights reserved.
//

import Foundation

protocol HasPreferencesService {
    var preferencesService: PreferencesService { get }
}

/// Represents the keys that are used to store user defaults
struct UserPreferences {
    private init () {}
    
    /// key for onBoarded preference
    static let onBoarded = "onBoarded"
}

/// This service manage the user preferences
class PreferencesService {
    
    /// sets the onBoarded preference to true
    func setOnboarding () {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: UserPreferences.onBoarded)
    }
    
    /// Returns true if the user has already onboarded, false otherwise
    ///
    /// - Returns: true if the user has already onboarded, false otherwise
    func isOnboarded () -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: UserPreferences.onBoarded)
    }
}
