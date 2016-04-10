//
//  MenuTableViewController.swift
//  m8s
//
//  Created by George Allen on 03/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

enum Menu : Int {
    case Home = 0
    case Preferences
    case Settings
    case About
}

protocol MenuProtocol : class {
    func changeViewController(menu: Menu)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MenuProtocol {

    @IBOutlet weak var menuTableView: UITableView!
    var mainViewController: UIViewController!
    var preferencesViewController: UIViewController!
    var settingsViewController: UIViewController!
    var aboutViewController: UIViewController!
    var menus = ["Home", "Preferences", "Settings", "About"];

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let preferencesViewController = storyboard.instantiateViewControllerWithIdentifier("WhenViewController") as! WhenViewController
        self.preferencesViewController = UINavigationController(rootViewController: preferencesViewController)
        
        let settingsViewController = storyboard.instantiateViewControllerWithIdentifier("SettingsViewController") as! SettingsViewController
        self.settingsViewController = UINavigationController(rootViewController: settingsViewController)
        
        let aboutViewController = storyboard.instantiateViewControllerWithIdentifier("AboutViewController") as! AboutViewController
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)

        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeViewController(menu: Menu) {
        switch menu {
        case .Home:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .Preferences:
            self.slideMenuController()?.changeMainViewController(self.preferencesViewController, close: true)
        case .Settings:
            self.slideMenuController()?.changeMainViewController(self.settingsViewController, close: true)
        case .About:
            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
        }
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuTableViewCell", forIndexPath: indexPath)

        cell.textLabel!.text = menus[indexPath.row]

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = Menu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
