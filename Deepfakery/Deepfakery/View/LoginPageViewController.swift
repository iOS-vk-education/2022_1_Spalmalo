//
//  LoginPageViewController.swift
//  Deepfakery
//
//  Created by Jasur Tursunov on 19.04.2022.
//

import UIKit
import SwiftUI
import Firebase


class LoginPageViewController: UIViewController {
    @StateObject var loginModel: LoginViewModel = LoginViewModel()
    
    private let collectionView: UICollectionView = .init(frame: CGRect(x: 0,
                                                                       y: 0,
                                                                       width: UIScreen.main.bounds.width,
                                                                       height: UIScreen.main.bounds.height),
                                                         collectionViewLayout:UICollectionViewLayout.init())
    private let emailField =  UITextField()
    private let passwordField = UITextField()
    private let retryPasswordField = UITextField()
    private let logInButton = UIButton()
    private let registerButton = UIButton()
    private let backButton = UIButton()
    private let textLabel = LabelButton()
    private var registerFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.emailField.becomeFirstResponder()
    }
    
    private func configureUI() {
        self.addCollectionView()
    }
    
    private func addCollectionView() {
        self.view.addSubview(self.collectionView)
        self.collectionView.backgroundColor = .kek
        
        
        if registerFlag {
            
            self.collectionView.addSubview(self.retryPasswordField)
            self.retryPasswordField.translatesAutoresizingMaskIntoConstraints = false
            self.retryPasswordField.autocapitalizationType = .none
            self.retryPasswordField.attributedPlaceholder = NSAttributedString(string: "Confirm password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            self.retryPasswordField.textColor = .black
            self.retryPasswordField.backgroundColor = .white
            self.retryPasswordField.layer.cornerRadius = 10
            self.retryPasswordField.isSecureTextEntry = true
            self.retryPasswordField.leftViewMode = .always
            self.retryPasswordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            NSLayoutConstraint.activate([
                self.retryPasswordField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 30),
                self.retryPasswordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.retryPasswordField.widthAnchor.constraint(equalToConstant: 300),
                self.retryPasswordField.heightAnchor.constraint(equalToConstant: 45)
            ])
            
            
            self.collectionView.addSubview(self.registerButton)
            self.registerButton.backgroundColor = .serik
            self.registerButton.layer.cornerRadius = 20
            self.registerButton.setTitle("Register", for: .normal)
            self.registerButton.setTitleColor(.black, for: .normal)
            self.registerButton.translatesAutoresizingMaskIntoConstraints = false
            self.registerButton.showsTouchWhenHighlighted = true
            NSLayoutConstraint.activate([
                self.registerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.registerButton.topAnchor.constraint(equalTo: self.retryPasswordField.bottomAnchor, constant: 30),
                self.registerButton.widthAnchor.constraint(equalToConstant: 150),
                self.registerButton.heightAnchor.constraint(equalToConstant: 45)
            ])
            self.registerButton.addTarget(self, action: #selector(self.onClickRegisterButton(sender:)), for: .touchUpInside)
            
            self.collectionView.addSubview(self.backButton)
            self.backButton.backgroundColor = .serik
            self.backButton.layer.cornerRadius = 20
            self.backButton.setTitle("Back", for: .normal)
            self.backButton.setTitleColor(.black, for: .normal)
            self.backButton.translatesAutoresizingMaskIntoConstraints = false
            self.backButton.showsTouchWhenHighlighted = true
            NSLayoutConstraint.activate([
                self.backButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.backButton.topAnchor.constraint(equalTo: self.registerButton.bottomAnchor, constant: 30),
                self.backButton.widthAnchor.constraint(equalToConstant: 150),
                self.backButton.heightAnchor.constraint(equalToConstant: 45)
            ])
            self.backButton.addTarget(self, action: #selector(self.onClickBackButton(sender:)), for: .touchUpInside)
            
        }
        
        self.collectionView.addSubview(self.emailField)
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.emailField.autocapitalizationType = .none
        self.emailField.autocorrectionType = .no
        self.emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.emailField.textColor = .black
        self.emailField.backgroundColor = .white
        self.emailField.leftViewMode = .always
        self.emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        self.emailField.layer.cornerRadius = 10
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.5 - 90),
            self.emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailField.widthAnchor.constraint(equalToConstant: 300),
            self.emailField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        
        self.collectionView.addSubview(self.passwordField)
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.autocapitalizationType = .none
        self.passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        self.passwordField.textColor = .black
        self.passwordField.backgroundColor = .white
        self.passwordField.layer.cornerRadius = 10
        self.passwordField.isSecureTextEntry = true
        self.passwordField.leftViewMode = .always
        self.passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        NSLayoutConstraint.activate([
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 30),
            self.passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.passwordField.widthAnchor.constraint(equalToConstant: 300),
            self.passwordField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
//        if Auth.auth().currentUser == nil
        
        self.collectionView.addSubview(self.logInButton)
        self.logInButton.backgroundColor = .serik
        self.logInButton.layer.cornerRadius = 20
        self.logInButton.setTitle("Log In", for: .normal)
        self.logInButton.setTitleColor(.black, for: .normal)
        self.logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.logInButton.showsTouchWhenHighlighted = true
        NSLayoutConstraint.activate([
            self.logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logInButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 30),
            self.logInButton.widthAnchor.constraint(equalToConstant: 150),
            self.logInButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        self.logInButton.addTarget(self, action: #selector(self.onClickLogInButton(sender:)), for: .touchUpInside)
        
        self.collectionView.addSubview(self.textLabel)
        self.textLabel.textColor = .white
        self.textLabel.text = "Нет аккаунта? Зарегистрироваться"
        self.textLabel.textColor = .white
        self.textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.textLabel.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 50),
            self.textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        self.textLabel.onClick = {
            print("Yahoo")
            self.registerFlag = true
            self.viewDidLoad()
            self.textLabel.isHidden = true
            self.logInButton.isHidden = true
            self.retryPasswordField.isHidden = false
            self.registerButton.isHidden = false
            self.backButton.isHidden = false
            
            
        }
    }
    
    @objc
    private func onClickLogInButton(sender: UIButton) {
        //добавить алерт на пустую строку
        guard let email = self.emailField.text, !email.isEmpty,
              let password = self.passwordField.text, !password.isEmpty else {
                  self.showErrorEmptyInputAlert()
                  return
              }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            guard error == nil else {
                self.showErrorLogInAlert()
                return
            }
            print("success Log IN")
        }
    }
    
    @objc
    private func onClickRegisterButton(sender: UIButton) {
        guard let email = self.emailField.text, !email.isEmpty,
              let password = self.passwordField.text, !password.isEmpty,
              let retryPassword = self.retryPasswordField.text, !retryPassword.isEmpty else {
                  self.showErrorEmptyInputAlert()
                  return
              }
        guard password == retryPassword else {
            self.showErrorPasswordsNotMatchAlert()
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (result, error) in
            guard let self = self else { return }
            
            guard error == nil else { return }
            print("Succsessfully registered")
        })
    }
    
    @objc
    private func onClickBackButton(sender: UIButton) {
        self.registerFlag = false
        self.viewDidLoad()
        self.retryPasswordField.isHidden = true
        self.registerButton.isHidden = true
        self.backButton.isHidden = true
        self.logInButton.isHidden = false
        self.textLabel.isHidden = false
       
    }
    
    private func showErrorLogInAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Incorrect password or email\nTry again",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in }))
        
        present(alert, animated: true)
    }
    
    
    private func showErrorEmptyInputAlert() {
        let alert = UIAlertController(title: "Alert",
                                      message: "Empty input\nAdd email or password",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in }))
        
        present(alert, animated: true)
    }
    
    private func showErrorPasswordsNotMatchAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Passwords don't match\nTry again",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { _ in }))
        
        present(alert, animated: true)
    }
}
        


open class LabelButton: UILabel {
    var onClick: () -> Void = {}
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onClick()
    }
}
