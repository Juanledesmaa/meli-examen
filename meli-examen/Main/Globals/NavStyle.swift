//
//  NavStyle.swift
//  meli-examen
//
//  Created by juan ledesma on 12/1/18.
//  Copyright © 2018 juan ledesma. All rights reserved.
//
import Foundation
import UIKit

class NavStyle {
    static func setupNavBarAppearance() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = Colors.mainBlue
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        UINavigationBar.appearance().isTranslucent = true
    }
}
