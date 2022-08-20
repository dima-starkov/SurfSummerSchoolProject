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
        } else {
            let tempCredentials = AuthRequestModel(phone: "+71234567890", password: "qwerty")
            AuthService().performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
                switch result {
                case .success:
                    self?.goToMain()
                case .failure:
                    //TODO: - handle error
                    break
                }
            }
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

