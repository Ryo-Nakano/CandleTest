//
//  ArticleDetailViewController.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/13.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import RealmSwift//Realm使う為の準備！
//↑Swiftの時は『RealmSwift』を使うことになっているらしい！
//▶︎表の表層的な機能面だけ使う→RealmSwift
//▶︎内部的なところまでいじる(overrideとか)→Realm

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var text: UITextView!
    
    var article: Article?//記事のデータが入っているArticle型の変数article
    
    let realm = try! Realm()//Realmのインスタンス作成→変数realmに格納→Realmを使う準備が整った！
    //Realmクラスが持っているメソッドを使う為、Realmにアクセスする為にRealmをインスタンス化してる
    
    let realmData = RealmData()//RealmData型のオブジェクトを作成
    //Realmに保存するデータを格納する為のデータ型を定義しているのがRealmData→この中に値をぶち込んで、Realmクラスが持っているメソッドを使ってデータの永続化を行う！
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)//Realmのデータベースの場所をConsoleに表示！

        if let article = article {
            text.text = article.body//記事の内容を表示
            text.isEditable = false//記事内容を編集不可に
        }
        
        print("==========================")
        print(article?.body)//bodyは元々空のデータ取って来てるからいいんだ！
        print(article?.id)//ちゃんとIDは取って来れてた
        print("==========================")
    }
    
    //別の画面に遷移する直前に処理
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    //メモリ足りない時
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //====================以下、関数====================
    
    //Likeボタン押された時の処理
    @IBAction func pushedLikeButton()//Article型の引数articleを取る
    {
        if let realmObj = realm.object(ofType: RealmData.self, forPrimaryKey: article?.id) {//Realmの中の、特定のPrimarykeyを持つものを取得→それがあった時...
            //既にあるrowのデータに上書き保存====================
            if realmObj.isLike == true{
                try! realm.write {
                    realmObj.isLike = false//falseに変更
                    realm.add(realmData, update: true)//データが無ければ追加、あったら上書き
                }
            }
            else{//realmObj.isLike == falseの時
                try! realm.write {
                    realmObj.isLike = true//trueに変更
                    realm.add(realmData, update: true)//データが無ければ追加、あったら上書き
                }
            }
            print("=====================================")
            print(realmObj)
            print("=====================================")
        }
        else{//realmObjに値がない時→初セーブの時
        
            //新しくrowを作って保存する処理====================
            print("Created New Row !!")
            try! realm.write {
                realmData.realmId = (article?.id)!//articleのidの値をrealm上に保存
                realmData.isLike = true//trueをrealm上に保存
                
                realm.add(realmData, update: true)//データが無ければ追加、あったら上書き
            }
            print("=====================================")
            print(realmData)
            print("=====================================")
        }
        // 最後に変更事項をRealmオブジェクトへの書き込み
        try! realm.write {
            realm.add(realmData, update: true)//データが無ければ追加、あったら上書き
        }
    }
    

}
