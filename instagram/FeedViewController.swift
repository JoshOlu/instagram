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
        
        tableVIew.dataSource = self
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVIew.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
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
