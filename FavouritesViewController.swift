//
//  FavouritesViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 6.08.2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FavouritesViewController: UIViewController {
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    var tableView = UITableView()
    var latitudeArray = [String]()
    var longitudeArray = [String]()
    var titleArray = [String]()
    
    // MARK: Configure UI
    
    private func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 12
        tableView.layer.borderColor = UIColor.systemGray3.cgColor
        tableView.layer.borderWidth = 0.8
        tableView.separatorStyle = .none
        tableView.register(FavouritesCell.self, forCellReuseIdentifier: FavouritesCell.identifier)
        view.addSubview(tableView)
        
        let favouritesLabel = UILabel()
        favouritesLabel.textColor = .darkGray
        favouritesLabel.text = "Favourites"
        favouritesLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        favouritesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(favouritesLabel)
        
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.isHidden = true
        
        
        NSLayoutConstraint.activate([
            favouritesLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            favouritesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            tableView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.95),
            tableView.topAnchor.constraint(equalTo: favouritesLabel.bottomAnchor, constant: 30),
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
        
    }
    
    // MARK: Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        fetchPlacesFromFirestore()
    }
        
    private func fetchPlacesFromFirestore() {
        
        let ref = db.collection("savedPlaces").whereField("userID", isEqualTo: user!.uid)
        
        ref.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self else { return }
            
            guard let documents = querySnapshot?.documents else {
                print("An error occured: \(error?.localizedDescription ?? "Couldn't fetch document")")
                return
            }
            
            self.titleArray.removeAll()
            self.latitudeArray.removeAll()
            self.longitudeArray.removeAll()
            
            for document in documents {
                
                if let title = document.get("title") as? String {
                    self.titleArray.append(title)
                }
                
                if let latitude = document.get("latitude") as? String {
                    self.latitudeArray.append(latitude)
                }
                
                if let longitude = document.get("longitude") as? String {
                    self.longitudeArray.append(longitude)
                }
                
            }
            self.tableView.reloadData()
        }
        
    }
    
    
}

extension FavouritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouritesCell
        
        let placeTitle = self.titleArray[indexPath.row]
        cell.titleLabel.text = placeTitle
        
        let locationCoordinates = "\(self.latitudeArray[indexPath.row]), \(self.longitudeArray[indexPath.row])"
        cell.locationLabel.text = locationCoordinates
        
        return cell
    }
    
}

