//
//  PostDetailsViewController.swift
//  instagram
//
//  Created by Josh Olumese on 6/29/17.
//  Copyright © 2017 Josh Olumese. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PostDetailsViewController: UIViewController {

    
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var photoInDetails: PFImageView!
    @IBOutlet weak var timeCreated: UILabel!
    var postDetails: PFObject!
    var instagramPost: PFObject! {
        didSet {
            self.photoInDetails.file = instagramPost["media"] as? PFFile
            self.photoInDetails.loadInBackground()
        }
    }
    
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableVIew.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        //let indexOfTheCellWeAreConfiguring = indexPath.row
        //let post = feed[indexOfTheCellWeAreConfiguring]
        //cell.feedLabel.text = post["caption"] as? String
        //cell.instagramPost = post
    //}

    
    override func viewDidLoad() {
        super.viewDidLoad()

        instagramPost = postDetails
        timeCreated.text = postDetails["caption"] as? String
        
        if let date = postDetails.createdAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: date)
            timeStamp.text = dateString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let feedViewController = segue.destination as! PostDetailsViewController
//        let cell = sender as! UITableViewCell
//    
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
