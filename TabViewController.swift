//
//  TabViewController.swift
//  MyFavoutitePlaces
//
//  Created by Furkan Kozmaç on 6.08.2023.
//

import UIKit
import FirebaseAuth

class TabViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .systemOrange
        tabBar.unselectedItemTintColor = .black
        
        // Do any additional setup after loading the view.
    }
    
    private func setupTabs() {
        let map = self.createNav(with: "Map", image: UIImage(systemName: "map.fill"), vc: MapViewController())
        let favourites = self.createNav(with: "Favourites", image: UIImage(systemName: "heart.fill"), vc: FavouritesViewController())
        let settings = self.createNav(with: "Settings", image: UIImage(systemName: "gearshape.fill"), vc: SettingsViewController())
        
        self.setViewControllers([map, favourites, settings], animated: true)
        
    }
    
    private func createNav(with title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    
}
