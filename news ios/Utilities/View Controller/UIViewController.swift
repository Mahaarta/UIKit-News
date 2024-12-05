//
//  UIViewController.swift
//  news ios
//
//  Created by Minata on 05/12/24.
//

import UIKit

extension UIViewController {
	
	// MARK: View
	static func loadFromNib() -> Self {
		func instantiateFromNib<T: UIViewController>() -> T {
			return T.init(nibName: String(describing: T.self), bundle: nil)
		}
		
		return instantiateFromNib()
	}
	
}
