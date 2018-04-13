//
//  APIManager.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import Foundation
import SwiftyJSON
import APIKit
import BrightFutures//各種ライブラリを使う為の準備

struct APIManager {
//    static let shared = APIManager()//自身をインスタンス化→変数sharedに格納
    
    //返り値"Future<T.Response, SessionTaskError>"は非同期通信時、その通信が完了するまで値は入っておらず、その値がなくても先にプログラムを進めるために利用される。
    static func send<T: MarbleRequest>(request: T, callbackQueue queue: CallbackQueue? = nil) -> Future<T.Response, SessionTaskError> {
        
        let promise = Promise<T.Response, SessionTaskError>()
        
        Session.send(request, callbackQueue: queue) { result in//変数resultの中に『成功失敗』『json形式のデータ』が入っている
            //引数の中にリクエストを書く
            
            //基本的に下記の形を崩さずに書く！らしい
            switch result {//resultの値に応じて条件分岐
            case let .success(data)://成功してた時
                promise.success(data)
                
            case let .failure(error)://失敗してた時
                promise.failure(error)
            }
        }
        
        return promise.future
    }
    
}
