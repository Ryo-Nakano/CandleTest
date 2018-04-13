//
//  MainTabBarController.swift
//  CandleTest
//
//  Created by Ryohei Nanano on 2018/03/27.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Arrayにした方がきれいに見えそうです...
        let articleStoryboard = UIStoryboard(name: "Article", bundle: nil)
        let searchStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let likeStoryboard = UIStoryboard(name: "Like", bundle: nil)
        let mypageStoryboard = UIStoryboard(name: "Mypage", bundle: nil)
        let articleViewController = articleStoryboard.instantiateInitialViewController() as! UINavigationController
        let searchViewController = searchStoryboard.instantiateInitialViewController() as! UINavigationController
        let likeViewController = likeStoryboard.instantiateInitialViewController() as! UINavigationController
        let mypageViewController = mypageStoryboard.instantiateInitialViewController() as! UINavigationController
        let viewControllers = [articleViewController, searchViewController, likeViewController, mypageViewController]//ここで一番最初にあるやつから左から順番に表示されるっぽい。
        //articleViewController消してみたところクラッシュしたので、どうやら最初にどん画面にいるかは重要じゃなくて、何の画面が表示されようとしているのかが最重要事項っぽい。
        self.setViewControllers(viewControllers, animated: false)
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
