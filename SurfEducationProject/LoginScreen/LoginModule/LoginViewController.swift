//
//  LoginViewController.swift
//  SurfEducationProject
//
//  Created by Дмитрий Старков on 20.08.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
//MARK: -Views
    let loginTextField = OneLineTextField(font: .regular18())
    let passwordTextField = OneLineTextField(font: .regular18())
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
    
    let presenter = LoginViewPresenter()
    
//MARK: -UIViewContoller

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
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
        showOrHidePasswordButton.tintColor = .grayLight()
        
        showOrHidePasswordButton.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        
        isEmptyLogin.text = "Поле не может быть пустым"
        isEmptyLogin.textColor = .warningRed()
        isEmptyLogin.font = .regular12()
        
        isEmptyPassword.text = "Поле не может быть пустым"
        isEmptyPassword.textColor = .warningRed()
        isEmptyPassword.font = .regular12()
        
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
    
    func confugureButton() {
        logInButton.backgroundColor = .standartBlack()
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setTitle("Войти", for: .normal)
        logInButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapLoginButton() {
        if checkLoginAndPassword() {
            logInButton.loadAnimation()
            logInButton.setTitle(nil, for: .normal)
            presenter.loginUser(phone: loginTextField.text, password: passwordTextField.text)
        }
    }
    
    func checkLoginAndPassword()-> Bool {
        let login = loginTextField.text
        let password = passwordTextField.text
        
        isEmptyLogin.isHidden = true
        isEmptyPassword.isHidden = true
        loginTextField.bottomViewColor = .grayLight()
        passwordTextField.bottomViewColor = .grayLight()
        
        if login == "" && password == "" {
            isEmptyLogin.isHidden = false
            loginTextField.bottomViewColor = .warningRed()
            isEmptyPassword.isHidden = false
            passwordTextField.bottomViewColor = .warningRed()
            return false
        }
        
        if login == "" {
            isEmptyLogin.isHidden = false
            loginTextField.bottomViewColor = .warningRed()
            return false
        }
        if password == "" {
            isEmptyPassword.isHidden = false
            passwordTextField.bottomViewColor = .warningRed()
            return false
        }
        return true
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginIsSuccesed() {
        let vc = TabBarConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func presentWarningView() {
        showWarningView()
        hideWarningView()
        logInButton.stopLoadAnimation()
        logInButton.setTitle("Войти", for: .normal)
    }
    
    func showWarningView() {
        warningView.isHidden = false
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.5) {
            self.warningView.center.y += self.topbarHeight
                self.view.layoutIfNeeded()
        }
            }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.5, delay: 2) {
            self.warningView.center.y -= self.topbarHeight
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}
