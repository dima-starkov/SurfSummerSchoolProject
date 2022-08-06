//
//  TabBarConfigurator.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import Foundation
import UIKit

class TabBarConfigurator {
    
    private var allTabs: [TabBarModel] = [.main,.favourite,.profile]
    
    func configure()-> UITabBarController {
        return getTabBarController()
    }
    
}

private extension TabBarConfigurator {
    func getTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.viewControllers = getControllers()
        return tabBarController
    }
    
    func getControllers()-> [UIViewController] {
        var controllers: [UIViewController] = []
        allTabs.forEach { tab in
            let controller = getCurrentViewController(tab: tab)
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = tabBarItem
            controllers.append(controller)
        }
        return controllers
    }
    
    func getCurrentViewController(tab: TabBarModel)-> UIViewController {
        switch tab {
        case .main:
            return MainViewController()
        case .favourite:
            return FavouriteViewController()
        case .profile:
            return ProfileViewController()
        }
    }
}
