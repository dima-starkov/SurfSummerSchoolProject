//
//  UIViewController + WarningView.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 04.09.2022.
//

import UIKit

extension UIViewController {
    
    var topbarHeight: CGFloat {
        var top = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
    
    func configureWarningView(warningView: UIView) {
        view.addSubview(warningView)
        warningView.isHidden = true
        warningView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningView.bottomAnchor.constraint(equalTo: view.topAnchor),
            warningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            warningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            warningView.heightAnchor.constraint(equalToConstant: 93)
        ])
    }
    
    func showWarningView(warningView: UIView) {
        warningView.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.5) {
            warningView.center.y += self.topbarHeight
                self.view.layoutIfNeeded()
        }
            }
    
    func hideWarningView(warningView: UIView) {
        UIView.animate(withDuration: 0.5, delay: 2) {
            warningView.center.y -= self.topbarHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
}
