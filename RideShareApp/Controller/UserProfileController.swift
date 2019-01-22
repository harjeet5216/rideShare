//
//  UserProfileController.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/21/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import Firebase



class UserProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    var tapGesture = UIGestureRecognizer()
    
    let storageFef =
    
    let ref = Database.database().reference(fromURL: "gs://rideshareucdavis.appspot.com/")
    
    @IBAction func updateProfile(_ sender: Any) {
        
        
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserProfileController.handleSelectProfileImageView))
        self.userImage.addGestureRecognizer(tapGesture)
        self.userImage.isUserInteractionEnabled = true
    }
    
    @objc func handleSelectProfileImageView() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])  {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            userImage.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled hit")
        dismiss(animated: true, completion: nil)
    }
}

