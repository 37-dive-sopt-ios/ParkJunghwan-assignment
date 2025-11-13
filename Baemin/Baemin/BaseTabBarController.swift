//
//  BaseTabBarController.swift
//  Baemin
//
//  Created by 박정환 on 11/12/25.
//

import UIKit

final class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let shoppingVC = ShoppingViewController()
        shoppingVC.tabBarItem = UITabBarItem(
            title: "장보기·쇼핑",
            image: UIImage(systemName: "bag"),
            selectedImage: UIImage(systemName: "bag.fill")
        )

        let favoriteVC = FavoriteViewController()
        favoriteVC.tabBarItem = UITabBarItem(
            title: "찜",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )

        let orderVC = OrderHistoryViewController()
        orderVC.tabBarItem = UITabBarItem(
            title: "주문내역",
            image: UIImage(systemName: "doc.plaintext"),
            selectedImage: UIImage(systemName: "doc.text.fill")
        )

        let profileVC = MyBaeminViewController()
        profileVC.tabBarItem = UITabBarItem(
            title: "마이배민",
            image: UIImage(systemName: "person.circle"),
            selectedImage: UIImage(systemName: "person.circle.fill")
        )

        viewControllers = [homeVC, shoppingVC, favoriteVC, orderVC, profileVC]
        tabBar.tintColor = UIColor(named: "baemin_black")
        tabBar.backgroundColor = .white
    }
}

#Preview() {
    BaseTabBarController()
}
