//
//  FeedViewController.swift
//  instagram
//
//  Created by Josh Olumese on 6/27/17.
//  Copyright © 2017 Josh Olumese. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {

    @IBOutlet weak var tableVIew: UITableView!
    var feed: [PFObject] = []
    var refreshControl: UIRefreshControl!
    
    @IBAction func logOutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("user logged out")
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let userVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(userVC, animated: true, completion: nil)
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(FeedViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableVIew.insertSubview(refreshControl, at: 0)
        // construct PFQuery
        
        tableVIew.dataSource = self
        fetchFeed()
    
    }
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchFeed()
    }
    
    func fetchFeed(){
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            
            if let posts = posts {
                // do something with the data fetched
                self.feed = posts
                self.tableVIew.reloadData()
                self.refreshControl.endRefreshing()
            } else {
                // handle error
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let indexOfTheCellWeAreConfiguring = indexPath.row
        let post = feed[indexOfTheCellWeAreConfiguring]
        cell.feedLabel.text = post["caption"] as? String
        cell.instagramPost = post
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
