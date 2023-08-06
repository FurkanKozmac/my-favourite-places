//
//  RegisterViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 4.08.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    let titleLabel = UILabel()
    private let firstNameTextField = UITextField()
    private let lastNameTextField = UITextField()
    private let mailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let registerButton = UIButton(type: .system)
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
    // MARK: Setting up UI
    
    func setupUI() {
        
        titleLabel.text = "Create an Account"
        titleLabel.textColor = .darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        firstNameTextField.placeholder = "First name"
        firstNameTextField.backgroundColor = .white
        firstNameTextField.autocapitalizationType = .none
        firstNameTextField.autocorrectionType = .no
        firstNameTextField.layer.borderWidth = 0.8
        firstNameTextField.layer.borderColor = UIColor.systemGray3.cgColor
        firstNameTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: firstNameTextField.frame.height))
        firstNameTextField.leftView = paddingView
        firstNameTextField.leftViewMode = .always
        firstNameTextField.textColor = .darkGray
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(firstNameTextField)
        
        lastNameTextField.placeholder = "Last name"
        lastNameTextField.backgroundColor = .white
        lastNameTextField.autocapitalizationType = .none
        lastNameTextField.autocorrectionType = .no
        lastNameTextField.layer.borderWidth = 0.8
        lastNameTextField.layer.borderColor = UIColor.systemGray3.cgColor
        lastNameTextField.layer.cornerRadius = 8
        let secondPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: firstNameTextField.frame.height))
        lastNameTextField.leftView = secondPaddingView
        lastNameTextField.leftViewMode = .always
        lastNameTextField.textColor = .darkGray
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lastNameTextField)
        
        mailTextField.placeholder = "Email"
        mailTextField.backgroundColor = .white
        mailTextField.autocapitalizationType = .none
        mailTextField.autocorrectionType = .no
        mailTextField.layer.borderWidth = 0.8
        mailTextField.layer.borderColor = UIColor.systemGray3.cgColor
        mailTextField.layer.cornerRadius = 8
        let thirdPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: firstNameTextField.frame.height))
        mailTextField.leftView = thirdPaddingView
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
        let fourthPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: firstNameTextField.frame.height))
        passwordTextField.leftView = fourthPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.textColor = .darkGray
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemOrange
        registerButton.tintColor = .white
        registerButton.layer.cornerRadius = 8
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addSubview(activityIndicator)
        
        // MARK: Constraints
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            
            firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            firstNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 15),
            lastNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lastNameTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            mailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 15),
            mailTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            mailTextField.heightAnchor.constraint(equalToConstant: 50),
            mailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: mailTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: registerButton.centerYAnchor)
            
            
        ])
        
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Register"
        setupUI()
    }
    
    private func activateIndicator() {
        activityIndicator.startAnimating()
        self.registerButton.setTitle("", for: .normal)
        registerButton.isUserInteractionEnabled = false
    }
    
    private func deactivateIndicator() {
        self.activityIndicator.stopAnimating()
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.isUserInteractionEnabled = true
    }
    
    private func generateAlert(message: String) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    
    private func generateUser() {
        
        self.db.collection("userInfo").addDocument(data: [
            "firstName" : "\(self.firstNameTextField.text!)",
            "lastName" : self.lastNameTextField.text!,
            "email" : self.mailTextField.text!,
            "password" : self.passwordTextField.text!,
            "userName" : "\(self.firstNameTextField.text!) \(self.lastNameTextField.text!)",
            "userID" : "\(auth.currentUser!.uid)"
        ])
        
    }
    
    @objc func registerButtonTapped() {
        
        activateIndicator()
        
        guard let email = mailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let name = firstNameTextField.text, !name.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty
        else {
            generateAlert(message: "Please enter all informations.")
            deactivateIndicator()
            return
        }
        
        if isValidEmail(email) {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    self.generateAlert(message: "An error occurred: \(error.localizedDescription)")
                    self.deactivateIndicator()
                } else {
                    self.generateUser()
                    self.deactivateIndicator()
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
        } else {
            
            self.generateAlert(message: "Invalid email format. Please enter a valid email address.")
            self.deactivateIndicator()
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
}
