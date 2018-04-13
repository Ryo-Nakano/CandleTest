//
//  ArticleViewModel.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/13.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import BrightFutures
import SwiftyJSON
import APIKit

class ArticleViewModel {
    
    var max: Int = 0
    var articles = [Article]()//とって来た記事データを格納しておく為の配列articles
    
    //記事を取って来る関数？
    func fetchArticles(params: [String: Any])//引数として配列とる(記事が配列データとして取られてくるのかな？)
        -> Future<GetArticlesRequest.Response, SessionTaskError> {//取り敢えず、GetArticlesRequest呼んでる！
        
        return APIManager.send(request: GetArticlesRequest())//返り値としてAPIリクエスト飛ばしてるのかな→結果記事取ってこれる！
    }
}
