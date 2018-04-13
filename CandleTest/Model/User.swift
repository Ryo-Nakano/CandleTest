//
//  User.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import SwiftyJSON

//Userについて使う情報を貯めておく！
struct User {
    
    let id: Int
//    let screenName: String
    let userName: String
    
    init(id: Int, screenName: String, userName: String) {
        self.id = id
//        self.screenName = screenName
        self.userName = userName
    }
    
    init(json: JSON) {
        id = json["id"].int ?? 0//『?? 0』は『空だったら初期値として0入れておくで』っていうことかな？
//        screenName = json["screenname"].string ?? ""//こんなもの存在しない。
        userName = json["username"].string ?? ""
    }
}
