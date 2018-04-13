//
//  StoryboardLoadable.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/27.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

protocol StoryboardLoadable: class {
    static var storyboardName: String { get }
}

extension StoryboardLoadable where Self: UIViewController {
    
    static var storyboardName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!.replacingOccurrences(of: "ViewController", with: "")
    }
    
}

