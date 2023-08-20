//
//  ViewController.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import UIKit
import CoreData

// 임의로 userId 발급받게 해줬습니다. 추후 수정
let globalUserId: UUID = UUID()

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.delegate = self
        
        // 임의로 userId 발급받게 해줬습니다. 추후 수정
        UserDataManager.shared.createUser(globalUserId)
        
        // tab bar 아이콘 설정 1
        let firstVC = UINavigationController(rootViewController: HomeScreen())
        let homeIcon = UIImage(named: "HomeIcon")
        firstVC.tabBarItem = UITabBarItem(title: "Home", image: homeIcon, tag: 0)
        // tab bar 아이콘 설정 2
        let secondVC = AddScreen()
        let addIcon = UIImage(named: "AddIcon")
        secondVC.tabBarItem = UITabBarItem(title: "Add", image: addIcon, tag: 1)
        // tab bar 아이콘 설정 3
        let thirdVC = MessageScreen()
        let messageIcon = UIImage(named: "MessageIcon")
        thirdVC.tabBarItem = UITabBarItem(title: "Message", image: messageIcon, tag: 2)
        // tab bar 아이콘 설정 4
        let fourthVCStoryBoard = UIStoryboard(name: "MyPageStoryBoard", bundle: nil)
        
        let fourthVC = fourthVCStoryBoard.instantiateViewController(withIdentifier: "MyPageStoryBoard") as! MyPageScreen
        
        //선택시 이동
        navigationController?.pushViewController(fourthVC, animated: true)
        if let navigationController = viewControllers?[3] as? UINavigationController { navigationController.pushViewController(fourthVC, animated: false)
        }
        
        let myPageIcon = UIImage(named: "MyPageIcon")
        fourthVC.tabBarItem = UITabBarItem(title: "MyPage", image: myPageIcon, tag: 3)

        UITabBar.clearShadow()
        tabBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        viewControllers = [firstVC, secondVC, thirdVC, fourthVC]
    }
    
    // AddScreen에서는 modal을 띄우기 위한 function 
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddScreen { // 선택된 뷰 컨트롤러가 AddScreen인 경우
            let addVC = AddScreen() // AddScreen 인스턴스 생성
            let navigationController = UINavigationController(rootViewController: addVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil) // 모달로 표시
            return false // 선택한 탭을 처리한 후에는 선택을 취소
        }
        return true // 다른 탭은 기본 동작 수행
    }
}
