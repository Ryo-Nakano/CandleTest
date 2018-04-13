//
//  Utils.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

//エラー処理をまとめて書いておく！
class Utils {
    static func createErrorObject(_ message: String, code: Int = 100) -> NSError {//NSError型の返り値返す関数！
        let domain = "jp.co.candle.app.marble"
        
        return NSError(domain: domain, code: 100, userInfo: [NSLocalizedDescriptionKey: message])//返り値としてNSError型のもの返す！
    }
    
    static func createViewController<T: StoryboardLoadable>() -> T {
        let sb = UIStoryboard(name: T.storyboardName, bundle: nil)
        return sb.instantiateInitialViewController() as! T
    }
}
