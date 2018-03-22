//
//  AppDelegate.swift
//  PizzaExample
//
//  Created by Ivan Smolin on 16/03/2018.
//  Copyright © 2018 Ivan Smolin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var appWindow: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)

        self.window = window

        return window
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        appWindow.changeRootController(controller: NavigationService.createPizzaListViewController())

        return true
    }

}

