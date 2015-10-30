//
//  ViewController.swift
//  LocalNotificationSample
//
//  Created by Ryota Iwai on 2015/10/28.
//  Copyright © 2015年 Ryota Iwai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelAllButton: UIButton!

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    // MARK: - Private property
    private var localNotifications: [UILocalNotification] = []
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addButton.layer.cornerRadius = self.addButton.frame.height / 2
        self.cancelAllButton.layer.cornerRadius = self.cancelAllButton.frame.height / 2
        
        self.tableView.contentInset.top = 64
    }

    // MARK: - Internal Methods
    func receiveLocalNotification(notification: UILocalNotification) {
        self.showAlert(notification)
        
        var index = 0
        for keepLocalNotification in self.localNotifications {
            if keepLocalNotification.fireDate == notification.fireDate {
                self.localNotifications.removeAtIndex(index)
                break
            }
            index++
        }
        
        self.tableView.reloadData()
    }

    // MARK: - Prvate methods
    private func showAlert(notification: UILocalNotification) {
        self.alertLabel.text = notification.alertBody
        
        self.alertView.alpha = 0.0
        self.alertView.hidden = false
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.alertView.alpha = 1.0
            }) { (finish) -> Void in
                let delay = 3.0 * Double(NSEC_PER_SEC)
                let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue(), {
                    self.alertView.alpha = 0.0
                    self.alertView.hidden = true
                })
        }
    }
    
    // MARK: - Action Methods
    @IBAction func tapAddButton(sender: AnyObject) {
        self.localNotifications.append(LocalNotificationManager.addLocalNotification())
        
        self.tableView.reloadData()
    }

    @IBAction func tapAllCancelButton(sender: AnyObject) {
        LocalNotificationManager.cancelAll()
        
        self.localNotifications.removeAll()
        
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.localNotifications.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("schedule.cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.localNotifications[indexPath.row].fireDate?.description ?? "no data"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}