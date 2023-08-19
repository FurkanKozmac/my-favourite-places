//
//  CommentViewController.swift
//  
//
//  Created by Furkan Kozmaç on 19.08.2023.
//

import UIKit

class CommentViewController: UIViewController {
    
    var titleTextField = UITextField()
    var commentTextField = UITextField()
    private let saveLocationButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .close)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private func setupUI() {
        
        let containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.backgroundColor = .systemGray6
        view.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        let addLocationLabel = UILabel()
        addLocationLabel.text = "Add Place"
        addLocationLabel.textColor = .darkGray
        addLocationLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        addLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addLocationLabel)
        
        titleTextField.placeholder = "Place's name"
        titleTextField.backgroundColor = .white
        titleTextField.autocapitalizationType = .none
        titleTextField.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleTextField.autocorrectionType = .no
        titleTextField.layer.borderWidth = 0.8
        titleTextField.layer.borderColor = UIColor.systemGray3.cgColor
        titleTextField.layer.cornerRadius = 8
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextField.frame.height))
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        titleTextField.textColor = .darkGray
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleTextField)
        
        commentTextField.placeholder = "Comment"
        commentTextField.backgroundColor = .white
        commentTextField.autocapitalizationType = .none
        commentTextField.autocorrectionType = .no
        commentTextField.layer.borderWidth = 0.8
        commentTextField.layer.borderColor = UIColor.systemGray3.cgColor
        commentTextField.layer.cornerRadius = 8
        let paddingViewTwo = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: commentTextField.frame.height))
        commentTextField.leftView = paddingViewTwo
        commentTextField.leftViewMode = .always
        commentTextField.textColor = .darkGray
        commentTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(commentTextField)
        
        saveLocationButton.setTitle("Save Place", for: .normal)
        saveLocationButton.backgroundColor = .systemOrange
        saveLocationButton.tintColor = .white
        saveLocationButton.layer.cornerRadius = 8
        saveLocationButton.addTarget(self, action: #selector(saveLocationButtonTapped), for: .touchUpInside)
        saveLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveLocationButton)
        
        cancelButton.titleLabel?.text = "\(String(describing: UIImage(systemName: "xmark.circle")))"
        cancelButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cancelButton)
        
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        saveLocationButton.addSubview(activityIndicator)
        
        
        NSLayoutConstraint.activate([
            
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 300),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addLocationLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant:20),
            addLocationLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            
            titleTextField.topAnchor.constraint(equalTo: addLocationLabel.bottomAnchor, constant: 20),
            titleTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            titleTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.90),
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            commentTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            commentTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            commentTextField.widthAnchor.constraint(equalToConstant: view.frame.width * 0.90),
            commentTextField.heightAnchor.constraint(equalToConstant: 40),
            
            saveLocationButton.topAnchor.constraint(equalTo: commentTextField.bottomAnchor, constant: 20),
            saveLocationButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            saveLocationButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.90),
            saveLocationButton.heightAnchor.constraint(equalToConstant: 40),
            
            cancelButton.widthAnchor.constraint(equalToConstant: 35),
            cancelButton.heightAnchor.constraint(equalToConstant: 35),
            cancelButton.centerYAnchor.constraint(equalTo: addLocationLabel.centerYAnchor),
            cancelButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: saveLocationButton.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: saveLocationButton.centerYAnchor)
            
            
            
        ])
        
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func deactivateIndicator() {
        self.activityIndicator.stopAnimating()
        self.saveLocationButton.setTitle("Save Place", for: .normal)
        self.saveLocationButton.isUserInteractionEnabled = true
        self.titleTextField.text = ""
        self.commentTextField.text = ""
    }
    
    private func activateIndicator() {
        self.activityIndicator.startAnimating()
        self.saveLocationButton.setTitle("", for: .normal)
        self.saveLocationButton.isUserInteractionEnabled = false
    }
    
    private func getAlert(message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
        
    }
    
    private func handleSavingLocationToFirestore() {
        
    }
    
    @objc func saveLocationButtonTapped() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    
}
