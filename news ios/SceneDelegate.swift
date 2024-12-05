//
//  SceneDelegate.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let mainViewController = NewsViewController(nibName: "NewsViewController", bundle: nil)
		let navigationController = UINavigationController(rootViewController: mainViewController)
		
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
}
