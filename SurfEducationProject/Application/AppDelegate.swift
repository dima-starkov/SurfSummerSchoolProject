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
    var tokenContainer = BaseTokenStorage()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        startApplicationProcess()
        window?.makeKeyAndVisible()
        return true
    }
    
    func startApplicationProcess() {
        runLaunchScreen()
        if let tokenContainer = try? tokenContainer.getToken(), !tokenContainer.isExpired {
            self.goToMain()
            ProfileService.shared.getUserDataFromUserDefaults()
        } else {
            let vc = UINavigationController(rootViewController: LoginViewController())
            self.window?.rootViewController = vc
        }
    }
    
    func goToMain() {
        DispatchQueue.main.async {
            self.window?.rootViewController = TabBarConfigurator().configure()
        }
    }
    
    func runLaunchScreen() {
        let launchScreenVC = UIStoryboard(name: "LaunchScreen", bundle: .main).instantiateInitialViewController()
        window?.rootViewController = launchScreenVC
    }

}

