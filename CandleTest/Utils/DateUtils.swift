//
//  DateUtils.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//
import UIKit

//日付のフォーマットに関して実装する際その都度、書かないといけない処理をまとめておく！
extension Date {
    static func dateFromString(_ string: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        let dateFormatter = DateFormatter()//DataFormatter内のプロパティ？にアクセスする為に予め取得しておいて、変数dataFormatterに打ち込んでいる！(元々Xcodeが用意してくれているやつかな！)
        dateFormatter.locale = Locale(identifier: "ja_JP")//取得したい時間の地域の指定！(Xcodeが元々持ってるやつだからこういう指示の出し方っていうのを覚えるしかなさげ)
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: string)//色々やって、返り値として返す
    }
}

