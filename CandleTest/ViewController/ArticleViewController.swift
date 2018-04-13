//
//  ArticleViewController.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/13.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Result//各種ライブラリ使用の為の準備

class ArticleViewController: UIViewController {
    //ここで一気にDelegateを書くこと可能だけど、それだとチーム開発時に分かりにくい？のでextentionで分割して行う！
    
    private let viewmodel = ArticleViewModel()//ArticleViewModelをインスタンス化→変数viewmodelの中に格納
//    private let apiManager: APIManager = APIManager.sharedInstance //そもそもいらん。だってここで使ってないじゃん。これ取って来る必要無し。１
    
    // ViewModelに実際のデータをもたせているので、ここではget/setでViewModelにアクセスしている
    fileprivate var articles: [Article] {
        get {
            return viewmodel.articles
        }
        set(newValue) {
            viewmodel.articles = newValue
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    
    //==========以下、ライフサイクル==========
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "MARBEL"
        load()
        initTableView()//TableViewの初期化
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //画面が遷移先から戻って来た時にセルの選択状態を解除
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //==========以下、関数==========
    
    private func load() {
        
        //辞書型(key:value)で値保持するapramsを定義
        let params: [String: Any] = [
            "search_type": "category",
            "limit": 30,
            ]
        viewmodel.fetchArticles(params: params)
            .onSuccess { [weak self] data in
                self?.articles = data.articles
                self?.tableView.reloadData()
                print(data.articles)
            }
            .onFailure { [weak self] error in
                switch error {
                case .connectionError(let err):
                    print(err)
                case .requestError(let err):
                    print(err)
                case .responseError(let err):
                    print(err)
                }
                self?.showErrorAlert(error.localizedDescription, completion: nil)
        }
    }
    
    private func showErrorAlert(_ message: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "MARBLE",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)//AlertControllerを呼び出し
        
        //Actionの追加
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: completion))
        
        //表示
        present(alert, animated: true, completion: nil)
    }
    
    //viewDidLoadから切り出している
    //TableViewの初期化
    private func initTableView() {
        //別ファイルで作ったArticleTableViewCellをcellとして登録
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension//cellの高さは可変です。(これやってても結局cellの高さ指定してあげないといけなかった気が...)
        tableView.estimatedRowHeight = 96.0//cellの見積もりの高さをあげる(これやっておくと処理が軽くなるらしい...？)
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    //①TableViewに表示するデータの個数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    //②TableViewに表示する内容を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell//セルを取って来て、ArticleTableView型にダウンキャスト
        
        cell.bindDataCell(article: articles[indexPath.row])//Articleオブジェクトを受け取って、cellの作成
        return cell
    }
    
    // セルが選ばれた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next: ArticleDetailViewController = Utils.createViewController()//Utilsの中に入ってるcreateViewController関数を使う！(プロトコルの使用)
        next.article = articles[indexPath.row]//選択されている記事を
        navigationController?.pushViewController(next, animated: true)//次の画面にアニメーションありで遷移
    }
    
    // cellの高さを120にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    

}

// MARK - StoryboardLoadable
extension UIViewController: StoryboardLoadable {}
