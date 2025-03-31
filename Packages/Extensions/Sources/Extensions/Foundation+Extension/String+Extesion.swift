//
//  String+Extesion.swift
//  Extensions
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation

public extension String {
    var link: URL? { URL(string: self) }
}
