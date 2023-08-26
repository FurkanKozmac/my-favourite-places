//
//  SettingsViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 6.08.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SettingsViewController: UIViewController {
    
    let db = Firestore.firestore()
    let currentUser = Auth.auth().currentUser
    var data: [String: Any] = [:]
    
    private let logoutButton = UIButton(type: .system)
    private let userNameLabel = UILabel()
    private let emailLabel = UILabel()
    
    private func setupUI() {
        
        let profiveView = UIView()
        profiveView.backgroundColor = .white
        profiveView.layer.cornerRadius = 12
        profiveView.layer.borderWidth = 0.8
        profiveView.layer.borderColor = UIColor.systemGray3.cgColor
        profiveView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profiveView)
        
        let settingsLabel = UILabel()
        settingsLabel.textColor = .darkGray
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        settingsLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsLabel)
        
        userNameLabel.textColor = .darkGray
        userNameLabel.text = "Loading..."
        userNameLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userNameLabel)
        
        emailLabel.textColor = .darkGray
        emailLabel.text = "Loading..."
        emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailLabel)
        
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.backgroundColor = .red
        logoutButton.tintColor = .white
        logoutButton.layer.cornerRadius = 8
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        
        NSLayoutConstraint.activate([
            
            settingsLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            settingsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            profiveView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.95),
            profiveView.heightAnchor.constraint(equalToConstant: 75),
            profiveView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profiveView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 30),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.95),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.leftAnchor.constraint(equalTo: profiveView.leftAnchor, constant: 10),
            userNameLabel.topAnchor.constraint(equalTo: profiveView.topAnchor, constant: 10),
            
            emailLabel.bottomAnchor.constraint(equalTo: profiveView.bottomAnchor, constant: -10),
            emailLabel.leftAnchor.constraint(equalTo: profiveView.leftAnchor, constant: 10)
            
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupUI()
        getUserData()
    }
    
    private func getUserData() {
        
        db.collection("userInfo").whereField("userID", isEqualTo: currentUser!.uid)
            .getDocuments() { (querySnapshot, err) in
                
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.data = document.data()
                        
                        if let userName = self.data["userName"] as? String {
                            self.userNameLabel.text = userName
                        }
                        
                        if let email = self.data["email"] as? String {
                            self.emailLabel.text = email
                        }
                    }
                }
            }
    }
    
    @objc private func didTapLogoutButton() {
        
        do {
            try Auth.auth().signOut()
            
            if let presentingViewController = self.presentingViewController {
                presentingViewController.dismiss(animated: false, completion: {
                    let vc = ViewController()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                })
                
            } else {
                
                let vc = ViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
            
        } catch {
            print("Çıkış işlemi başarısız: \(error.localizedDescription)")
        }
    }
    
    
    
    
}
