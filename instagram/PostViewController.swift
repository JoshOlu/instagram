//
//  PostViewController.swift
//  instagram
//
//  Created by Josh Olumese on 6/28/17.
//  Copyright © 2017 Josh Olumese. All rights reserved.
//
//
import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var editedImage: UIImage?

    @IBAction func choosePhotoButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
            vc.sourceType = .photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func takePhotoButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var photoPreview: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let userImage = info[UIImagePickerControllerEditedImage] as! UIImage
        editedImage = resize(image: userImage, newSize: CGSize(width: 750, height: 750))
        photoPreview.image = editedImage
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func sharePost(_ sender: Any) {
        if self.editedImage == nil {
            print("error")
        }
        
        else {Post.postUserImage(image: editedImage, withCaption: captionTextField.text) { (success:Bool, error:Error?) in
            if success == true {
                print("Success!")
                self.captionTextField.text = ""
            } else if let error = error {
                print("Problem \(error.localizedDescription)")
            }
        }
    }
}
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
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
