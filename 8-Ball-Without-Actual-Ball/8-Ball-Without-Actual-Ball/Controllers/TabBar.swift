//
//  TabBar.swift
//  8-Ball-Without-Actual-Ball
//
//  Created by Alexey on 29.01.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVC()
    }

    private func setupVC() {
        guard let imageTabHomeVC = UIImage(systemName: "questionmark.circle") else {
            print("Image not found")
            return
        }
         
        guard let imageTabSettingsVC = UIImage(systemName: "gearshape.fill") else {
            print("Image not found")
            return
        }
        
        viewControllers = [
            createNavController(for: HomeVC(), title: NSLocalizedString("Quetion", comment: ""), image: imageTabHomeVC),
            createNavController(for: SettingsVC(), title: NSLocalizedString("Settings", comment: ""), image: imageTabSettingsVC)
        ]
    }

    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title

        return navController
    }
}
