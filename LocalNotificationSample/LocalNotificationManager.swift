//
//  LocalNotificationManager.swift
//  LocalNotificationSample
//
//  Created by Ryota Iwai on 2015/10/28.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

class LocalNotificationManager {

    class func setup() {
        let type: UIUserNotificationType = [.Badge, .Alert, .Sound]
        let settings = UIUserNotificationSettings(forTypes: type, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    class func addLocalNotification() -> UILocalNotification{
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 60)
        localNotification.alertBody = "This Is Test Notification!"
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        return localNotification
    }
    
    class func cancelAll() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    class func showAlert() {
        
    }
}