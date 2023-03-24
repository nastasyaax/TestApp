//
//  TabBarController.swift
//  TestApp
//
//  Created by Анастасия Хурдаян on 21.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    
    //MARK: - Private methods
    private func generateTabBar() {
        let controllers = [
            makeViewController(
                StoreViewController(viewModel: StoreViewModel(networkManager: .init())),
                image: UIImage(named: "home.tab.bar")),
            makeViewController(image: UIImage(named: "fav.tab.bar")),
            makeViewController(image: UIImage(named: "card.tab.bar")),
            makeViewController(image: UIImage(named: "meassage.tab.bar")),
            makeViewController(
                ProfileViewController(viewModel: ProfileViewModel()),
                image: UIImage(named: "profile.tab.bar")),
        ]
        viewControllers = controllers
        selectedIndex = controllers.count - 1
    }
    
    private func makeViewController(_ viewController: UIViewController = UIViewController(), image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return UINavigationController(rootViewController: viewController)
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 2
        let positionOnY: CGFloat = 15
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.frame.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX, y: tabBar.bounds.minY - positionOnY, width: width, height: height), cornerRadius: height / 3.3)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = UIColor(red: 127/255, green: 125/255, blue: 125/255, alpha: 1)
    }
    
    private func makeNavBar(viewController: UIViewController, title: String) -> UIViewController {
        let navVC = viewController
        navVC.title = title
        return UINavigationController(rootViewController: navVC)
    }
}
