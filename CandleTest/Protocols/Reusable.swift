//
//  Reusable.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/24.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

protocol Reusable: class {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
