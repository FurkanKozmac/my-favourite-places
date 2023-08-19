//
//  ViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 4.08.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    private let mailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let registerButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: Initializing Views
    
    private func setupUI() {
        
        let headerView = UIView()
        headerView.backgroundColor = .systemOrange
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let cornerRadius: CGFloat = 64.0
        headerView.layer.cornerRadius = cornerRadius
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner]
        view.addSubview(headerView)
        
        let logoView = UIImageView()
        logoView.image = UIImage(named: "logo.png")
        logoView.contentMode = .scaleToFill
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
        
        let loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        loginLabel.textColor = .darkGray
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        mailTextField.placeholder = "Email"
        mailTextField.backgroundColor = .white
        mailTextField.autocapitalizationType = .none
        mailTextField.autocorrectionType = .no
        mailTextField.layer.borderWidth = 0.8
        mailTextField.layer.borderColor = UIColor.systemGray3.cgColor
        mailTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: mailTextField.frame.height))
        mailTextField.leftView = paddingView
        mailTextField.leftViewMode = .always
        mailTextField.textColor = .darkGray
        mailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mailTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.layer.borderWidth = 0.8
        passwordTextField.layer.borderColor = UIColor.systemGray3.cgColor
        passwordTextField.layer.cornerRadius = 8
        let secondPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftView = secondPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = .darkGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemOrange
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        registerButton.setTitle("Create an Account", for: .normal)
        registerButton.setTitleColor(.link, for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        view.addSubview(registerButton)
        
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addSubview(activityIndicator)
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            logoView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 20),
            logoView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 150),
            logoView.heightAnchor.constraint(equalToConstant: 150),
            
            loginLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 30),
            mailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            mailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
            
        ])
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGray6
        setupUI()
    }
    
    private func getAlert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
    
    private func deactivateIndicator() {
        self.activityIndicator.stopAnimating()
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.isUserInteractionEnabled = true
        self.mailTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    private func activateIndicator() {
        self.activityIndicator.startAnimating()
        self.loginButton.setTitle("", for: .normal)
        self.loginButton.isUserInteractionEnabled = false
    }
    
    @objc func didTapLoginButton() {
        
        activateIndicator()
        
        guard let email = mailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else{
            getAlert(message: "Email and password cannot be empty.")
            deactivateIndicator()
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            
            if error != nil {
                strongSelf.getAlert(message: "Invalid email or password. Please try again.")
                strongSelf.deactivateIndicator()
                return
            }
            let vc = TabViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            strongSelf.present(nav, animated: true)
            strongSelf.deactivateIndicator()
        }
        
    }
    
    @objc func didTapRegisterButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

