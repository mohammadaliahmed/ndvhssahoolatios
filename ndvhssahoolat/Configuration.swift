//
//  Configuration.swift
//  ndvhssahoolat
//
//  Created by MIS on 04/02/2021.
//

import Foundation

class Configuration {

    static func value<T>(defaultValue: T, forKey key: String) -> T{

        let preferences = UserDefaults.standard
        return preferences.object(forKey: key) == nil ? defaultValue : preferences.object(forKey: key) as! T
    }

    static func value(value: Any, forKey key: String){

        UserDefaults.standard.set(value, forKey: key)
    }

}
