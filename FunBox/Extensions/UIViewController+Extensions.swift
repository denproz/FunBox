//
//  UIViewController+Extensions.swift
//  FunBox
//
//  Created by Denis Prozukin on 15.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

extension UIViewController {
	func configureNavigationBar(backgoundColor: UIColor = .white, tintColor: UIColor = .black, title: String, preferredLargeTitle: Bool = false, isNavBarHidden: Bool = true) {
		if #available(iOS 13.0, *) {
			let navBarAppearance = UINavigationBarAppearance()
			navBarAppearance.configureWithOpaqueBackground()
			navBarAppearance.backgroundColor = backgoundColor
			
			navigationController?.navigationBar.standardAppearance = navBarAppearance
			navigationController?.navigationBar.compactAppearance = navBarAppearance
			navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
			
			navigationController?.navigationBar.prefersLargeTitles = preferredLargeTitle
			navigationController?.navigationBar.isTranslucent = false
			navigationController?.navigationBar.tintColor = tintColor
			navigationController?.navigationBar.isHidden = isNavBarHidden
			navigationItem.title = title
			
		} else {
			navigationController?.navigationBar.barTintColor = backgoundColor
			navigationController?.navigationBar.tintColor = tintColor
			navigationController?.navigationBar.isTranslucent = false
			navigationItem.title = title
		}
	}
	
	func configureTabBarItemWithSFSymbols(title: String, unselectedName: String, selectedName: String) {
		let unselectedImage = UIImage(systemName: unselectedName)
		let selectedImage = UIImage(systemName: selectedName)
		let tbItem = UITabBarItem(title: nil, image: unselectedImage, selectedImage: selectedImage)
		tbItem.title = title
		tabBarItem = tbItem
	}
}
