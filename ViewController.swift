//
//  ViewController.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // tab bar 아이콘 설정 1
        let firstVC = UINavigationController(rootViewController: HomeScreen())
        let homeIcon = UIImage(named: "HomeIcon")
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        // tab bar 아이콘 설정 2
        let secondVC = UINavigationController(rootViewController: AddScreen())
        let addIcon = UIImage(named: "AddIcon")
        secondVC.tabBarItem = UITabBarItem(title: "Add", image: addIcon, tag: 1)
        // tab bar 아이콘 설정 3
        let thirdVC = MessageScreen()
        let messageIcon = UIImage(named: "MessageIcon")
        thirdVC.tabBarItem = UITabBarItem(title: "Message", image: messageIcon, tag: 2)
        // tab bar 아이콘 설정 4
        let fourthVC = MyPageScreen()
        let myPageIcon = UIImage(named: "MyPageIcon")
        fourthVC.tabBarItem = UITabBarItem(title: "MyPage", image: myPageIcon, tag: 3)

        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
}
