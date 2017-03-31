//
//  AddNewItemViewController.swift
//  FacebookAPI
//
//  Created by Scott Hetland on 2017-03-28.
//  Copyright © 2017 Scott Hetland. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var eventToAddItemTo:Event?
    var addNewItemHost:User?
    
    var arrayOfImages = [UIImage]()
    

    @IBOutlet weak var itemGoalLabel: UILabel!
    @IBOutlet weak var itemGoalSlider: UISlider!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavButtons()
        addAllImagesToArray()
        
    }
    
    func savePartyItemButton() -> Void
    {
        
        //pop back to view controller and save it to database
        
        //save to firebase itemName -> itemNameTextField.text
        
        //truncate after decimal place
        let itemGoal = Int(itemGoalSlider.value)
        let itemImage = String()
        //save to firebase itemGoal -> Double(itemGoal)
    
        //save to firebase itemImage -> itemImageView.image
        
        //POST to firebase and create a new party item on this event
        
        
        print(itemGoal)
        print(itemNameTextField.text!)
        
        //must initialize new partyItem with all things we got, and gotta save to the eventsArray
        //add error handlers
        let newPartyItem = PartyItem(name: itemNameTextField.text!,
                                     goal: Double(itemGoal),
                                     image: String(itemImage),
                                     itemEventID: (eventToAddItemTo?.eventID)!)
        
        eventToAddItemTo?.partyItems.append(newPartyItem)
        
        FirebaseManager.writeToFirebaseDBEvents(partyItemName: itemNameTextField.text!, eventID: (eventToAddItemTo?.eventID)!, partyItemsArray: eventToAddItemTo?.partyItems)
        FirebaseManager.writeToFirebaseDBPartyItem(partyItemName: itemNameTextField.text!, eventID: (eventToAddItemTo?.eventID)!, partyItemsArray: eventToAddItemTo?.partyItems)
        //name and ID of the host who posted it. Not sure if you need both but they are here
        let hostName = addNewItemHost?.name!
        let hostID = addNewItemHost?.userID!
        print(hostName!)
        print(hostID!)
        
        //check to see if they are nil or else do not pop back
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func itemGoalSliderAction(_ sender: UISlider)
    {
        
        let itemGoalInt = Int(itemGoalSlider.value)
        itemGoalLabel.text = "Item Goal: $\(itemGoalInt)"
    }
    
    func cancelItemButton() -> Void
    {
        
        //pop back do not save
        _ = self.navigationController?.popViewController(animated: true)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newItemImageCell", for: indexPath)
        
        return cell
        
    }
    
    func setUpNavButtons() -> Void
    {
        
        self.navigationItem.title = eventToAddItemTo?.eventName
        
        let savePartyItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(savePartyItemButton))
        self.navigationItem.rightBarButtonItem = savePartyItem
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelItemButton))
        self.navigationItem.leftBarButtonItem = cancel
        
    }
    
    func addAllImagesToArray() -> Void
    {
        
        
        
    }

}
