//
//  AddNewItemViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var eventToAddItemTo:Event?
    var addNewItemHost:User?
    
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var itemGoalLabel: UILabel!
    @IBOutlet weak var itemGoalSlider: UISlider!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = eventToAddItemTo?.eventName

        let savePartyItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(savePartyItemButton))
        self.navigationItem.rightBarButtonItem = savePartyItem
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItemButton))
        self.navigationItem.leftBarButtonItem = cancel
        
        let pickImage = UITapGestureRecognizer(target: self, action: #selector(pickItemImage(pickImage:)))
        itemImageView.isUserInteractionEnabled = true
        itemImageView.addGestureRecognizer(pickImage)
        
    }


    func pickItemImage(pickImage: UITapGestureRecognizer) -> Void {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true) { 
            //code
        }
        print("image picked")
        itemImageView.image = info[UIImagePickerControllerOriginalImage] as! UIImage?
    }
    
    func savePartyItemButton() -> Void
    {
        //pop back to view controller and save it to database
        
        //save to firebase itemName -> itemNameTextField.text
        
        //truncate after decimal place
        let itemGoal = Int(itemGoalSlider.value)
        //save to firebase itemGoal -> Double(itemGoal)
        
        //save to firebase itemImage -> itemImageView.image
        
        //POST to firebase and create a new party item on this event
        
        
        print(itemGoal)
        print(itemNameTextField.text!)
        
        //name and ID of the host who posted it. Not sure if you need both but they are here
        let hostName = addNewItemHost?.name!
        let hostID = addNewItemHost?.userID!
        print(hostName!)
        print(hostID!)
        
        //check to see if they are nil or else do not pop back
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func itemGoalSliderAction(_ sender: UISlider) {
        
        let itemGoalInt = Int(itemGoalSlider.value)
        itemGoalLabel.text = "Item Goal: $\(itemGoalInt)"
    }
    func cancelItemButton() -> Void {
        
        //pop back do not save
        _ = self.navigationController?.popViewController(animated: true)

    }

}
