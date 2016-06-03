//
//  InviteFriendsViewController.swift
//  m8s
//
//  Created by George Allen on 10/04/2016.
//  Copyright © 2016 George Allen. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var inviteFriendsTableView: UITableView!
    var searchController: UISearchController!
    var doneButton: UIBarButtonItem!
    var swipeViewController: UIViewController!
    var workingPlan: Plan!
    
    var friends = ["Friend One", "Friend Two", "Friend Three", "Friend Four", "Friend Five", "Friend Six",
                   "Friend Seven", "Friend Eight", "Friend Nine", "Friend Ten", "Friend Eleven", "Friend Twelve",
                   "Friend Thirteen", "Friend Fourteen", "Friend Fifthteen", "Friend Sixteen", "Friend Seventeen",
                   "Friend Eighteen", "Friend Nineteen", "Friend Twenty"];
    var filteredFriends = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let swipeViewController = storyboard.instantiateViewControllerWithIdentifier("SwipeViewController") as! SwipeViewController
        self.swipeViewController = UINavigationController(rootViewController: swipeViewController)
        
        //table view setup
        inviteFriendsTableView.delegate = self
        inviteFriendsTableView.dataSource = self
        
        //nav bar button setup
        doneButton = UIBarButtonItem(title: "SKIP", style: UIBarButtonItemStyle.Done, target: self, action: #selector(InviteFriendsViewController.doneTapped))
        navigationItem.rightBarButtonItem = doneButton
        
        //seach bar setup
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        inviteFriendsTableView.tableHeaderView = searchController.searchBar
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "INVITE"
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredFriends.count
        }
        return friends.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InviteFriendTableViewCell", forIndexPath: indexPath)
        
        if searchController.active && searchController.searchBar.text != "" {
            cell.textLabel!.text = filteredFriends[indexPath.row]
        } else {
            cell.textLabel!.text = friends[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = inviteFriendsTableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        updateDoneButton()
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = inviteFriendsTableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = UITableViewCellAccessoryType.None
        updateDoneButton()
    }
    
    func updateDoneButton() {
        if let _ = inviteFriendsTableView.indexPathsForSelectedRows {
            doneButton.title = "DONE"
        } else {
            doneButton.title = "SKIP"
        }
    }
    
    // MARK: - Search Controller
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredFriends = friends.filter { friend in
            return friend.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        inviteFriendsTableView.reloadData()
    }
    
    func doneTapped() {
        print("done")
        self.slideMenuController()?.changeMainViewController(self.swipeViewController, close: true)
        let viewControllers = self.navigationController?.viewControllers
        let filteredViewControllers = viewControllers?.filter({$0.isKindOfClass(WhenViewController)})
        self.navigationController?.viewControllers = filteredViewControllers!
    }
}

extension InviteFriendsViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
