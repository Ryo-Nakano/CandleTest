//
//  ArticleTableViewCell.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/13.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var user: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //セル生成時に必ず通る
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindDataCell(article: Article) {//Article型の変数articleを引数にとる関数
        // 引数にArticleオブジェクトを受け取って、cellの作成を行います.
        // 現状まだ引数をいれずに適当な値を入れています.
        title.text = article.title
//        date.text = String(article.modified)
        desc.text = article.body
        desc.text = article.id.description
        user.text = article.userData.userName
        
        // 画像の描画に関して
        // if let構文で書くとき
        /* if let thumbnail = "https:i.vimeocdn.com/portrait/58832_300x300" {
         if let data = Data(contentsOf: URL(string: thumbnail)!) {
         thumbnail.image = UIImage(data: data)
         }
         }
         */
        
        // guard let で書くとき. ネストが深くならない、かつ、早期リターンできるのでこちら推奨.
        // WebImageを使うとパフォーマンスが向上します
        guard let thumbnailURL = URL(string: article.thumbNormal) else { return }//変数thumbnailURLの中身のnilチェック→nilでなければ秒でreturn(次の処理へ)
        //ここのURLが各記事のURLになってないとだめなのでは？→予想的中！(嬉しい。)
        
        guard let thumb = try? Data(contentsOf: thumbnailURL) else { return }//変数thumの中身のnilチェック→nilでなければ秒でreturn(次の処理へ)
        print(thumb)
        thumbnail.image = UIImage(data: thumb)//storyboard上のthumbnailのimageに受け取ったデータthumbを入れる！
        
    }
    
}
