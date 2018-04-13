//
//  Article.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/13.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Realm//Realm使う為の準備！
//↑これもう必要無いよね？

//記事に関して、使うデータの集積場的なイメージかな？
class Article {
    
    let id: Int//IDによってどの記事がお気に入り登録されているのかを判別！
    let title: String
    let body: String
    let categoryId: Int
    let categoryName: String
//    let itemOrder: String
//    let modified: Int
//    let onePage: Int
//    let provider: String
    let published: Int
//    let thumb: String
    let thumbNormal: String
    let thumbOriginal: String
//    let thumbStatus: Int
//    let thumbUpdated: Date
    let userData: User
    
    var isLike = false//お気に入りしているかどうかを格納しておく為の変数(もちろん初期値はfalse)
    
    //Realmで管理するデータは切り離した方が良いのかな...？
    //↑一旦切り離してやってみた
    
    //初期化処理
    init(json: JSON) {//JSON型の引数jsonを取る。
        
        //▼▼▼以下、受け取ったjsonをどうする？の処理▼▼▼
//        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
//        print(json)
//        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")

        
        let article = json//そもそもここが入っていないだと！！なんてことだ！！
        //↑取って来るところの名前の指定がちゃんとできてなかっただけ。printで確認していく！
        
//        print("ArticleArticleArticleArticleArticleArticle")
//        print(article)
//        print("ArticleArticleArticleArticleArticleArticle")
        //ここまでは値入ってること確認できた！
        //でもなんでこれ以降値入ってない？
        
        id = article["user"]["id"].intValue//done
//        print("id : " + id.description)
        
        title = article["title"].stringValue//done
//        print("title : " + title)
        
        body = article["body"].stringValue//done
//        print("body : " + body)
        
        categoryId = article["app_category_id"].intValue//done
//        print("categoryId : " + categoryId.description)
        
        categoryName = article["app_category_name"].stringValue//done
//        print("categoryName : " + categoryName.description)
        
//        itemOrder = article["item_order"].stringValue
//        modified = article["modified"].intValue
//        onePage = article["one_page"].intValue
//        provider = json["provider"].stringValue
        published = article["published"].intValue//done
//        print("published : " + published.description)
        
//        thumb = article["thumb"].stringValue
        thumbNormal = article["thumb_normal"].stringValue//done
//        print("thumbNormal : " + thumbNormal)
        
        thumbOriginal = article["thumb_original"].stringValue//done
//        print("thumbOriginal : " + thumbOriginal)
        
//        thumbStatus = article["thumb_status"].intValue
//        thumbUpdated = Date.dateFromString(article["thumb_updated"].stringValue) ?? Date()//こんなもの存在しない
        
        
        userData = User(json: json["user"])//done
//        print(userData)
        
        
    }//『.intValue』とかっていう書き方は『ちゃんと値が来れば型変換するし、そうでなければ初期値として0返すよ』っていうやつ。便利！
    //自分が取りにいっている値はそもそも存在する？print()で確認！
}
