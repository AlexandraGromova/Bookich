//
//  MainScreen.swift
//  Bookich
//
//  Created by Sasha on 21.10.2024.
//

import Foundation
import UIKit
import SnapKit

class MainScreen: UIViewController {
    
    let textFieldName = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .bgrGray
    }
    
    func setup() {
    }
}

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создание экземпляров view-контроллеров для вкладок
        let mainViewController = MainScreen()
        let profileViewController = ProfileScreen()
        
        // Установка иконок и заголовков для вкладок
        mainViewController.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), tag: 0)
        profileViewController.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "gear"), tag: 1)
        
        // Добавление контроллеров в TabBar
        viewControllers = [mainViewController, profileViewController]
    }
}
