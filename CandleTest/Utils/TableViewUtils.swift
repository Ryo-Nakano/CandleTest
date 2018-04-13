//
//  TableViewUtils.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/24.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell>(registerCell _: T.Type) where T: Reusable & NibLoadable  {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
