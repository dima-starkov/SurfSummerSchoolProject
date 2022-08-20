//
//  ProfileViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 06.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
//MARK: -Views
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var exitButton: UIButton!
    
    let warningView = WarningView(text: "Не удалось выйти, попробуйте еще раз")
    
//MARK: - Properties

    var userModel: UserModel?
    
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
        LogOutService().logOut { [weak self] isSuccess in
            if isSuccess{
                DispatchQueue.main.async {
                    let vc = LoginViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self?.showWarningView()
                    self?.hideWarningView()
                }
            }
        }
       
    }
    
}

//MARK: -Private Methods

private extension ProfileViewController {
    
    func configureAppearance() {
        configureTableView()
        configureExitButton()
        configureNavigationBar()
        confugureWarningView()
        userModel = ProfileService.shared.userProfileModel
    }
    
    func configureExitButton() {
        exitButton.backgroundColor = .black
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.setTitle("Выйти из профиля", for: .normal)
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "\(AvatarAndNameTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(AvatarAndNameTableViewCell.self)")
        tableView.register(UINib(nibName: "\(DescriptionTableViewCell.self)", bundle: .main),
                           forCellReuseIdentifier: "\(DescriptionTableViewCell.self)")
        tableView.isScrollEnabled = false
    }
    
    func configureNavigationBar() {
        navigationItem.title = "Профиль"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearchButton))
        searchButton.tintColor = .black
        navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc private func didTapSearchButton() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
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
        UIView.animate(withDuration: 0.7) {
                self.warningView.center.y += 93
                self.view.layoutIfNeeded()
        }
            }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.7,delay: 2) {
                self.warningView.center.y -= 93
                self.view.layoutIfNeeded()
            
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
