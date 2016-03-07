//
//  DetailViewController.swift
//  Instagram
//
//  Created by XXY on 16/3/1.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var photos: [PFObject]?
    
 
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.whereKey("caption", notEqualTo: "")
        query.limit = 20
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with the data fetched
                
                self.photos = posts
                
                self.tableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            } else {
                print("Failed.")
            }
        }
        self.tableView.reloadData()
    
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photos != nil {
            print(photos!.count)
            return photos!.count
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("photoCell", forIndexPath: indexPath) as! PhotoViewCell

        let photo = photos![indexPath.row]
        
        cell.caption?.text = photo.valueForKey("caption") as? String
        cell.username.text = PFUser.currentUser()!.username! as String
        
        let query = PFQuery(className: "UserMedia")
        query.getObjectInBackgroundWithId(photo.objectId!) {
            (post: PFObject?, error: NSError?) -> Void in
            if error == nil{
                if let image = photo.valueForKey("media")! as? PFFile{
                    image.getDataInBackgroundWithBlock({ (image: NSData?, error: NSError?) -> Void in
                        if error == nil{
                            cell.photoImage.image = UIImage(data: image!)
                        }
                    })
                }
                
            }
            else{
                print(error)
            }
        }

        return cell
        
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

