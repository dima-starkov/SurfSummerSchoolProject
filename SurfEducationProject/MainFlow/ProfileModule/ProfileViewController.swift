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
    @IBOutlet weak var exitButtonView: UIView!
    let exitButton = UIButton()
    let warningView = WarningView(text: "Не удалось выйти, попробуйте еще раз")
    
//MARK: - Properties

    var userModel: UserModel?
    
//MARK: - ViewContoller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(topbarHeight)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
    }
}

//MARK: -Private Methods

private extension ProfileViewController {
    
    func logout() {
        LogOutService().logOut { [weak self] isSuccess in
            guard let strongSelf = self else { return }
            if isSuccess{
                DispatchQueue.main.async {
                    let vc = UINavigationController(rootViewController: LoginViewController())
                    vc.modalPresentationStyle = .fullScreen
                    strongSelf.present(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.showWarningView(warningView: strongSelf.warningView)
                    strongSelf.hideWarningView(warningView: strongSelf.warningView)
                    strongSelf.exitButton.stopLoadAnimation()
                    strongSelf.exitButton.setTitle("Выйти из профиля", for: .normal)
                }
            }
        }
    }
    
    func configureAppearance() {
        configureTableView()
        configureExitButton()
        configureNavigationBar(title: "Профиль")
        configureWarningView(warningView: warningView)
        userModel = ProfileService.shared.userProfileModel
    }
    
    func configureExitButton() {
        exitButtonView.addSubview(exitButton)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: exitButtonView.topAnchor),
            exitButton.bottomAnchor.constraint(equalTo: exitButtonView.bottomAnchor),
            exitButton.leadingAnchor.constraint(equalTo: exitButtonView.leadingAnchor),
            exitButton.trailingAnchor.constraint(equalTo: exitButtonView.trailingAnchor)
        ])
        
        exitButton.backgroundColor = .standartBlack()
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitle("Выйти из профиля", for: .normal)
        exitButton.addTarget(self, action: #selector(didTapExitButton), for: .touchUpInside)
    }
    
    @objc func didTapExitButton() {
        presentAlert()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "\(AvatarAndNameTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(AvatarAndNameTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DescriptionTableViewCell.self)")
        tableView.isScrollEnabled = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight).isActive = true
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: "Внимание", message: "Вы точно хотите выйти из приложения?", preferredStyle: .alert)
        let outAction = UIAlertAction(title: "Да,точно", style: .default) { [weak self] _ in
            self?.exitButton.loadAnimation()
            self?.exitButton.setTitle(nil, for: .normal)
            self?.logout()
        }
        let cancelAction = UIAlertAction(title: "Нет", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(outAction)
        present(alert, animated: true)
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
