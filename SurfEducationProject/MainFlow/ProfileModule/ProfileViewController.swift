//
//  ProfileViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    
//MARK: -Views
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exitButton: UIButton!
    
    let warningView = WarningView(text: "Не удалось выйти, попробуйте еще раз")
    
//MARK: - Properties

    var userModel: UserModel?
    
    var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
    
//MARK: - ViewContoller
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
    }
    
//MARK: -Actions

    @IBAction func logOutOfProfile(_ sender: UIButton) {
       presentAlert()
    }
    
}

//MARK: -Private Methods

private extension ProfileViewController {
    
    func logout() {
        LogOutService().logOut { [weak self] isSuccess in
            if isSuccess{
                DispatchQueue.main.async {
                    let vc = UINavigationController(rootViewController: LoginViewController())
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self?.showWarningView()
                    self?.hideWarningView()
                    self?.exitButton.stopLoadAnimation()
                    self?.exitButton.setTitle("Выйти из профиля", for: .normal)
                }
            }
        }
    }
    
    func configureAppearance() {
        configureTableView()
        configureExitButton()
        configureNavigationBar(title: "Профиль")
        confugureWarningView()
        userModel = ProfileService.shared.userProfileModel
    }
    
    func configureExitButton() {
        exitButton.backgroundColor = .standartBlack()
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitle("Выйти из профиля", for: .normal)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight + 16).isActive = true //переопределил, чтобы во время анимации warningView tableView не уезжала вместе с navigationBar
        
        tableView.register(UINib(nibName: "\(AvatarAndNameTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(AvatarAndNameTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DescriptionTableViewCell.self)")
        tableView.isScrollEnabled = false
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите выйти из приложения?", preferredStyle: .alert)
        let outAction = UIAlertAction(title: "Да,точно", style: .default) { [weak self] _ in
            self?.exitButton.loadAnimation()
            self?.exitButton.setTitle(nil, for: .selected)
            self?.logout()
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(outAction)
        present(alert, animated: true)
    }
    
    func confugureWarningView() {
        view.addSubview(warningView)
        view.bringSubviewToFront(warningView)
        warningView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningView.bottomAnchor.constraint(equalTo: view.topAnchor),
            warningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            warningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            warningView.heightAnchor.constraint(equalToConstant: 93)
        ])
    }
    
    func showWarningView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.7) {
            self.warningView.center.y += self.topbarHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.7, delay: 2) {
            self.warningView.center.y -= self.topbarHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
}

//MARK: - UTableViewDelegate

extension ProfileViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userModel = userModel else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(AvatarAndNameTableViewCell.self)")
            if let cell = cell as? AvatarAndNameTableViewCell {
                cell.configure(with: userModel)
                return cell
            }
        case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(DescriptionTableViewCell.self)")
                if let cell = cell as? DescriptionTableViewCell {
                    cell.configure(infoType: "Город", info: "\(userModel.city)")
                    return cell
                }
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DescriptionTableViewCell.self)")
            if let cell = cell as? DescriptionTableViewCell {
                cell.configure(infoType: "Телефон", info: "\(userModel.phone)")
                return cell
            }
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DescriptionTableViewCell.self)")
            if let cell = cell as? DescriptionTableViewCell {
                cell.configure(infoType: "Почта", info: "\(userModel.email)")
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
