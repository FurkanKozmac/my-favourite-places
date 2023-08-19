//
//  FavouritesViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 6.08.2023.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    let tableView = UITableView()
    
    // MARK: Configure UI
    
    private func setupUI() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 12
        tableView.frame.size.height = tableView.contentSize.height
        tableView.layer.borderColor = UIColor.systemGray3.cgColor
        tableView.layer.borderWidth = 0.8
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        let favouritesLabel = UILabel()
        favouritesLabel.textColor = .darkGray
        favouritesLabel.text = "Favourites"
        favouritesLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        favouritesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favouritesLabel)
        
        NSLayoutConstraint.activate([
            favouritesLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            favouritesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.95),
            tableView.topAnchor.constraint(equalTo: favouritesLabel.bottomAnchor, constant: 30),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = true
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame.size.height = tableView.contentSize.height
    }
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Favourite Location: 36-42KP, 26-45DM"
        return cell
    }
    
}
