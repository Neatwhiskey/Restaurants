//
//  NewRestaurantController.swift
//  Restaurants
//
//  Created by Jamaaldeen Opasina on 05/01/2024.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController, UINavigationControllerDelegate{

    var restaurant: Restaurant!
    @IBOutlet var photoImageView: UIImageView!{
        didSet{
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet var nameTextField: RoundedTextField!{
        didSet{
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField!{
        didSet{
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField!{
        didSet{
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField!{
        didSet{
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 10.0
            descriptionTextView.layer.masksToBounds = true
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customize the navigation bar experience
        if let appearance = navigationController?.navigationBar.standardAppearance{
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0){
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named:"NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor:UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let photoSourceRequestController = UIAlertController(title: "", message: "choose your photo source", preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {(action)in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {(action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            //for Ipad
            if let popoverPresentationController = photoSourceRequestController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverPresentationController.sourceView = cell
                    popoverPresentationController.sourceRect = cell.bounds
                }
            }
            present(photoSourceRequestController, animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    // MARK: - Navigation

    @IBAction func saveButtonTapped(sender: AnyObject){
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
            restaurant.name = nameTextField.text!
            restaurant.type = typeTextField.text!
            restaurant.location = addressTextField.text!
            restaurant.phone = phoneTextField.text!
            restaurant.summary = descriptionTextView.text!
            restaurant.isFavorite = false
            
            if let imageData = photoImageView.image?.pngData(){
                restaurant.image = imageData
            }
            print ("saving data to context...")
            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }

}

extension NewRestaurantController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1){
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}

extension NewRestaurantController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}
