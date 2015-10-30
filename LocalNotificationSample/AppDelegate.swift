//
//  AppDelegate.swift
//  LocalNotificationSample
//
//  Created by Ryota Iwai on 2015/10/28.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        LocalNotificationManager.setup()
        
        return true
    }
    
    // MARK: - Receive Local Notification
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("notification = \(notification)")
        
        if let viewController = self.window?.rootViewController as? ViewController {
            viewController.receiveLocalNotification(notification)
        }
    }
}

