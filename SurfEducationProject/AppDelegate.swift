//
//  AppDelegate.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 03.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
     
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        goToMain()
        window?.makeKeyAndVisible()
        return true
    }
    
    func goToMain() {
        window?.rootViewController = TabBarConfigurator().configure()
    }

}

