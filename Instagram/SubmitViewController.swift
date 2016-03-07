//
//  SubmitViewController.swift
//  Instagram
//
//  Created by XXY on 16/3/1.
//  Copyright © 2016年 XXY. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class SubmitViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var tapText: UILabel!
    
    @IBOutlet weak var captionField: UITextField!
    
    let vc = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Instantiate an imagePickerController
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // resize image
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    // selectPhoto
     @IBAction func selectPhoto(sender: AnyObject) {
        self.presentViewController(vc, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let pickedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            photoImage.image = pickedImage
            
            tapText.hidden = true
            
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    // submit
    @IBAction func submit(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        if (photoImage.image != nil) {
            UserMedia.postUserImage(photoImage.image, withCaption: captionField.text) { (boolean: Bool, error: NSError?) -> Void in
                self.performSegueWithIdentifier("submitSegue", sender: nil)
                print("Uploaded image")
                self.tapText = nil
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
        else{
            self.performSegueWithIdentifier("submitSegue", sender: nil)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
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
