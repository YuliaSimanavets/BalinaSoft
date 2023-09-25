//
//  NSMutableData.swift
//  BalinaSoft
//
//  Created by Yuliya on 25/09/2023.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding(rawValue: NSUTF8StringEncoding), allowLossyConversion: true)
        append(data!)
    }
}
