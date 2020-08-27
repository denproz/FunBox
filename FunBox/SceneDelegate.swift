//
//  SceneDelegate.swift
//  FunBox
//
//  Created by Denis Prozukin on 13.08.2020.
//  Copyright © 2020 Denis Prozukin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		
		if #available(iOS 13.0, *) {
			window?.overrideUserInterfaceStyle = .light
		}
		
		let tabBarContoller = HostTabBarVC()
		tabBarContoller.tabBar.tintColor = .systemGreen
		
		window?.rootViewController = tabBarContoller
		window?.makeKeyAndVisible()
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		(UIApplication.shared.delegate as? AppDelegate)?.saveContext()
	}
}

