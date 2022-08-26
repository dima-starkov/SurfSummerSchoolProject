//
//  LoginViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
//MARK: -Views
    let loginTextField = OneLineTextField(font: .systemFont(ofSize: 18, weight: .regular))
    let passwordTextField = OneLineTextField(font: .systemFont(ofSize: 18, weight: .regular))
    let logInButton = UIButton()
    let showOrHidePasswordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
    let isEmptyLogin = UITextField()
    let isEmptyPassword = UITextField()
    let warningView = WarningView(text: "Логин или пароль введен неправильно")
    
//MARK: -Properties:
    
    var topbarHeight: CGFloat {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        }
    
//MARK: -UIViewContoller

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureAppearance()
        view.backgroundColor = .white
        navigationItem.title = "Вход"
        
    }
    
}

//MARK: - Private Methods

private extension LoginViewController {
    func configureAppearance() {
        confugureButton()
        configureTextFields()
        configureStackView()
        confugureWarningView()
    }
    
    func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [loginTextField,isEmptyLogin,passwordTextField,isEmptyPassword,logInButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 48),
            loginTextField.heightAnchor.constraint(equalToConstant: 55),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func configureTextFields() {
        loginTextField.placeholder = "Логин"
        passwordTextField.placeholder = "Пароль"
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.rightView = showOrHidePasswordButton
        passwordTextField.rightViewMode = .always
        
        showOrHidePasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        showOrHidePasswordButton.tintColor = .lightGray
        
        showOrHidePasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        isEmptyLogin.text = "Поле не может быть пустым"
        isEmptyLogin.textColor = .red
        isEmptyLogin.font = .systemFont(ofSize: 12, weight: .light)
        
        isEmptyPassword.text = "Поле не может быть пустым"
        isEmptyPassword.textColor = .red
        isEmptyPassword.font = .systemFont(ofSize: 12, weight: .light)
        
        isEmptyLogin.isHidden = true
        isEmptyPassword.isHidden = true
        
    }
    
    @objc func showPassword() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        passwordTextField.isSecureTextEntry ? showOrHidePasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal) : showOrHidePasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
    }
    
    func confugureWarningView() {
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
    
    func showWarningView() {
        warningView.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    func confugureButton() {
        logInButton.backgroundColor = .black
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitle("Войти", for: .normal)
        logInButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapLoginButton() {
        if checkLoginAndPassword() {
           logIn()
        }
    }
    
    func logIn(){
        guard let login = loginTextField.text, let password = passwordTextField.text else { return }
        let tempCredentials = AuthRequestModel(phone: login, password: password)
        AuthService().performLoginRequestAndSaveToken(credentials: tempCredentials) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    ProfileService.shared.getUserDataModel(from: result)
                    let vc = TabBarConfigurator().configure()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showWarningView()
                    self?.hideWarningView()
                }
            }
        }
    }
    
    func checkLoginAndPassword()-> Bool {
        let login = loginTextField.text
        let password = passwordTextField.text
        
        isEmptyLogin.isHidden = true
        isEmptyPassword.isHidden = true
        loginTextField.bottomViewColor = .lightGray
        passwordTextField.bottomViewColor = .lightGray

        
        if login == "" {
            isEmptyLogin.isHidden = false
            loginTextField.bottomViewColor = .red
            return false
        }
        if password == "" {
            isEmptyPassword.isHidden = false
            passwordTextField.bottomViewColor = .red
            return false
        }
        return true
    }
}
