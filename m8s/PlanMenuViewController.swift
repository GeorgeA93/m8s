//
//  PlanMenuViewController.swift
//  m8s
//
//  Created by George Allen on 28/06/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

enum PlanMenu : Int {
    case Plans = 0
}

protocol PlanMenuProtocol : class {
    func changeViewController(planMenu: PlanMenu)
}

class PlanMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PlanMenuProtocol {

    @IBOutlet weak var menuHeaderView: MenuHeaderView!
    @IBOutlet weak var menuTableView: UITableView!
    var plansViewController: UIViewController!
    var menus = ["Plans"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let plansViewController = storyboard.instantiateViewControllerWithIdentifier("PlansViewController") as! PlansViewController
        self.plansViewController = UINavigationController(rootViewController: plansViewController)
        
        // self.menuHeaderView!.setup()
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeViewController(menu: PlanMenu) {
        switch menu {
        case .Plans:
            self.slideMenuController()?.changeMainViewController(self.plansViewController, close: true)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanMenuTableViewCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = menus[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let menu = PlanMenu(rawValue: indexPath.item) {
            self.changeViewController(menu)
        }
    }


}
