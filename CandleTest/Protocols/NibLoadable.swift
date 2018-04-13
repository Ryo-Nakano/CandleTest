//
//  NibLoadable.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/24.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

protocol NibLoadable: class {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    
}


