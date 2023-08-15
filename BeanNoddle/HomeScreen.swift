//
//  HomeScreen.swift
//  BeanNoddle
//
//  Created by Daisy Hong on 2023/08/14.
//

import Foundation
import UIKit

class HomeScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        btn.backgroundColor = .orange
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        view.addSubview(btn)

    }
    
    @objc func btnAction() {
        let vc = DetailScreen()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
