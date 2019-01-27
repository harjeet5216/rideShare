//
//  UserProfileController.swift
//  RideShareApp
//
//  Created by Harjeet  on 1/21/19.
//  Copyright © 2019 Harjeet . All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage




class UserProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    
    var tapGesture = UIGestureRecognizer()
    
   
    
    let ref = Database.database().reference(fromURL: "https://rideshareucdavis.firebaseio.com/")
    
    @IBAction func updateProfile(_ sender: Any) {
        
        let imageName = NSUUID().uuidString
        let uid = Auth.auth().currentUser?.uid
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
        
       // let values = ["userName" : userName, "email" : Auth.auth().currentUser!.email, ""]
        if let uploadData = self.userImage.image!.pngData() {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (_, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                storageRef.downloadURL(completion: { (url, err) in
                    if let err = err {
                        print(err)
                        return
                    }
                    
                    guard let url = url else { return }
                    let values = ["displayName": Auth.auth().currentUser?.displayName, "email": Auth.auth().currentUser?.email, "profileImageUrl": url.absoluteString, "userName" : self.userName.text!]
                    
                    self.updateUserIntoDatabaseWithUID(uid!, values: values as [String : AnyObject])
                })
                
            })
        }
    }
    
    fileprivate func updateUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
           self.navigationController!.popViewController(animated: true)
        })
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

