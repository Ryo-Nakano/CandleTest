//
//  GetArticleRequest.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/14.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import Foundation
import APIKit
import SwiftyJSON//各種ライブラリを使う為の準備

//記事取って来る為のstruct
struct GetArticlesRequest: MarbleRequest {
    // typealiasは型に別名をつけます.APIKitのDocumentに実装すべきpropertyやmethodが書いてあるので確認してみてください.
    // maxは返ってきた記事数で、無限スクロールをする時に、次のページがあるかどうかの判別で使います.
    typealias Response = (max: Int, articles: [Article])
    
    // queryParametersは空でも動くように?をつけています.
    let queryParameters: [String : Any]? = ["search_type": "category", "category_id": "1", "limit": "10"]//格納型プロパティ
    var method: HTTPMethod { return .get }//計算型プロパティ
    var path: String = "/1/articles/list"
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> (max: Int, articles: [Article]) {
        
        let json = JSON(object)//JSON(？)のメソッド使う為にJSONのobjectを取って来て変数jsonの中にぶち込んでる！
        
        if let message = json["message"].string {//これは何がしたいんだ？
            throw ResponseError.unexpectedObject(message)
            
        }
        let max = json["meta"]["max"].intValue//done
        //↑書き方的にはちょっとずつ階層潜ってる感じ！
        
        
        //クロージャってやつ！(名前を持たない関数みたいなもん？)
        //引数jsonを取って、返り値としてArticl型のものを返す
        let articles = json["result"].arrayValue.map { json -> Article in//『map』は型変換みたいなもん！
            //mapって元々の性質としてクロージャってことかな？
            
//            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
//            print(Article(json: json))//現状こいつをプリントすると全然値が入っていない。→ちゃんと指定したところから値を取って来ることができていないのでは？
//            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            
            return Article(json: json)
        }//↓この書き方は上のやつを省略した書き方！
//        let articles = json["results"].arrayValue.map { Article(json: $0) }//『$0』には配列内の要素のそれぞれが入っている！
        //jsonの中の配列resultに対してArray型に変換(値が無かったら初期値として0返す)→変換後の配列内の全要素に対してstruct『Article』のinitを通している！
        
        return (max, articles)//maxはちゃんと値取れた。あとはarticles
    }
}


