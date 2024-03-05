//
//  InformationViewController.swift
//  FriendList
//
//  Created by Ajay Kumar on 04/03/24.
//

import UIKit

protocol InformationViewControllerDelegate: AnyObject {
    
    func addOrUpdateFriend(friend: Friend, index: Int)
    func deleteFriend(index: Int)
}

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var submitbtn: UIButton!
    @IBOutlet weak var imgBackView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    
    var friendData: Friend?
    weak var delegate: InformationViewControllerDelegate?
    var currentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
       
    }
    
    
    func setUpUI(){
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imgView.addGestureRecognizer(tapGesture)
        imgView.isUserInteractionEnabled = true
        
        firstName.layer.cornerRadius = 12
        firstName.clipsToBounds = true
        
        lastName.layer.cornerRadius = 12
        lastName.clipsToBounds = true
        
        contact.layer.cornerRadius = 12
        contact.clipsToBounds = true
        
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        guard let firstNameText = firstName.text, !firstNameText.isEmpty,
              let lastNameText = lastName.text, !lastNameText.isEmpty,
              let contactText = contact.text, !contactText.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        let newFriend = Friend(firstName: firstNameText, lastName: lastNameText, contact: contactText, profilePicture: nil)
        
        if let index = currentIndex {
            delegate?.addOrUpdateFriend(friend: newFriend, index: index)
        } else {
            delegate?.addOrUpdateFriend(friend: newFriend, index: -1)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func imageTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.contentMode = .scaleAspectFit
            imgView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
