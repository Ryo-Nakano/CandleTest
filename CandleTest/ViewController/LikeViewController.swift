//
//  LikeViewController.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/27.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Result
import RealmSwift//Realm使う為の準備

//お気に入り記事だけを表示する
class LikeViewController: UIViewController {
    private let viewmodel = ArticleViewModel()//ArticleViewModelをインスタンス化→変数viewmodelの中に格納
    var favoriteArticles: [Article] = []//お気に入り記事のデータを格納しておく為の変数
    
    // ViewModelに実際のデータをもたせているので、ここではget/setでViewModelにアクセスしている
    fileprivate var articles: [Article] {
        get {
            return viewmodel.articles
        }
        set(newValue) {
            viewmodel.articles = newValue
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()//Realmのインスタンス作成→変数realmに格納→Realmを使う準備が整った！
//    let realmData = RealmData()//RealmData型のオブジェクトを作成
    //↑別にこれやる必要無くない？だってRealmを参照してどの記事がお気に入り登録されているのかを把握したいだけだから、Realmにデータを保存する為にデータを入れておく為の箱であるRealmDataには用が無いはず。

    
    //==========以下、ライフサイクル==========
    
    override func loadView() {
        super.loadView()
        load()//記事読み込みの為の関数
        //ちょっとタイミング早めてみた！→ここで呼んでもだめだった...
    }
    
    //xib読み込み、UI作成時に1度だけ呼ばれる(既にインスタンス化されていたら呼ばれない)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "LikeArticles"
        initTableView()//TableViewの初期化
    }
    
    //ViewControllerが画面に表示される度に呼ばれる
    override func viewWillAppear(_ animated: Bool) {
        referrenceRealm()//Realmを参照→isLike == trueだけを引っ張って来る
        tableView.reloadData()//TableViewの更新
        tableView.tableFooterView = UIView()//不要な線を消す
        
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
    
    //Realmを参照→お気に入り記事か否かを判断
    private func referrenceRealm()
    {
        let favorites = realm.objects(RealmData.self).filter("isLike == true")//isLike == trueのやつだけ引っ張って来て、変数favoritesの中に入っているのが理想。
        
        print("favoritesfavoritesfavoritesfavorites")
        print(favorites)//ここに入っているのはRealmData型の値でIDとisLikeしか入っていない
        print(articles)//1回目の描画の段階ではこの中がカラってことが分かった→なんで？記事は表示されてるのに...？
        print("favoritesfavoritesfavoritesfavorites")
        
        favoriteArticles.removeAll()//配列favoriteArticles内の要素を全件削除(また改めて最新情報に則って要素を追加していく為)
        
        for article in self.articles {//配列articlesの中の1つ1つの要素articleに対して処理を行う
            //↑最初の描画ではarticlesが空だからこのforが1回も回ってない！
            for favorite in favorites{//favoritesの中の1つ1つの要素favoriteに対して処理を行う
                
                if article.id == favorite.realmId{//articleのIDとお気に入り済みのIDを全て見比べて、対象の記事(article)がお気に入り済みの記事データなのかどうかを判断！
                    
                    //ここの中で変数favoriteArticlesにIDが一致した記事データを追加していく
                    print("==============article.id②②②==============")
                    print(article.id)//なーぜか『6006』が3個あるぞーなんでだー→なんと元々の記事データとして"6006"が3つあった。一意じゃないんかい！笑
                    print(article)//記事データの存在確認済み
                    print("==============article.id②②②==============")//ここまではちゃんとできてる』
                    
                    favoriteArticles.append(article)//配列favoriteArticlesの中にarticleを格納
                    //↑配列favoriteArticlesの中に記事データを格納するところができない！なんで？
                }
            }
        }
        
        print("RealmReferenced！")
        print(favoriteArticles)//入った！！(相変わらず初回読み込み時はだめだけど...)
        print("②")
    }
    
    //記事読み込みの為の関数
    private func load() {
        
        //辞書型(key:value)で値保持するapramsを定義
        let params: [String: Any] = [
            "search_type": "category",
            "limit": 30,
            ]
        
        DispatchQueue.global().async{//非同期処理を行う
            self.viewmodel.fetchArticles(params: params)//viewmodelの中に記述してあるfetchArticle関数を呼ぶ
                
                //ライブラリ{『BrightFutures』を使うと例外処理がネスとせずに直列で書くことができる！
                .onSuccess { [weak self] data in//成功したら(変数dataの中にとって来たデータが入っている)
                    print("Succeeded!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")//←これが呼ばれるのが一番遅かった→単純にデータ取って来るのが遅くて初回の表示に間に合っていないぽい。どうすればいける？
                    //viewmodelの中のfetchArticleが呼ばれるのを待てばいい？早くすればいい？
                    
                    self?.articles = data.articles//artcles配列にdataの中に入っているarticlesの内容をブチ込む
                    self?.tableView.reloadData()//TableViewの読み込み直し
                }
                .onFailure { [weak self] error in//失敗したら
                    switch error {
                    case .connectionError(let err):
                        print(err)
                    case .requestError(let err):
                        print(err)
                    case .responseError(let err):
                        print(err)
                    }
                    self?.showErrorAlert(error.localizedDescription, completion: nil)//エラーアラートを表示
            }
        }
        
        print("①")//ちゃんとloadの方が早く呼ばれて早く処理は終わっているっぽい...
        //が、1発目うまくいかん。なんで？
        
        print(articles)
        //最初の読み込み時、シンプルにこれに値が入る前に"referenceRealm"が呼ばれちゃってる(コンソールで『Succeeded!』より『①』や『[]』が出力されている点より自明)
        //→これ順番どうにかならない？
        
    }
    
    //エラーアラートを表示する為の関数
    private func showErrorAlert(_ message: String, completion: ((UIAlertAction) -> Void)?) {
        
        //①AlertControllerを呼び出し
        let alert = UIAlertController(title: "MARBLE",
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        //②Actionの追加
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: completion))
        
        //③表示
        present(alert, animated: true, completion: nil)
    }
    
    //TableViewを初期化する為の関数(viewDidLoadから切り離している)
    private func initTableView() {
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 96.0
    }
    
    ///   - waitContinuation: 待機条件
    ///   - compleation: 通過後の処理
    //処理が終わるまで待つ関数→今回の用途には合わない感じするなあ...
    func wait(_ waitContinuation: @escaping (()->Bool), compleation: @escaping (()->Void)) {
        var wait = waitContinuation()
        // 0.01秒周期で待機条件をクリアするまで待ちます。
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            while wait {
                DispatchQueue.main.async {
                    wait = waitContinuation()
                    semaphore.signal()
                }
                semaphore.wait()
                Thread.sleep(forTimeInterval: 0.01)
            }
            // 待機条件をクリアしたので通過後の処理を行います。
            DispatchQueue.main.async {
                compleation()
            }
        }
    }

    
}



extension LikeViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    //①TableViewに表示するデータの個数指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteArticles.count//配列favoriteArticlesの数だけデータ表示
    }
    
    //②TableViewに表示する内容を指定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell//セルを取って来て、ArticleTableView型にダウンキャスト
        
        cell.bindDataCell(article: favoriteArticles[indexPath.row])//Articleオブジェクトを受け取って、cellの作成
        
        return cell
    }
    
    // セルが選ばれた時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let next: ArticleDetailViewController = Utils.createViewController()//Utilsの中に入ってるcreateViewController関数を使う！(プロトコルの使用)
        next.article = favoriteArticles[indexPath.row]//選択されている記事を
        navigationController?.pushViewController(next, animated: true)//次の画面にアニメーションありで遷移
    }
    
    // cellの高さを120にする
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
