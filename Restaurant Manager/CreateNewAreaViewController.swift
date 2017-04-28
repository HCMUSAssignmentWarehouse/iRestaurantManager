//
//  CreateNewAreaViewController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import CoreData


class CreateNewAreaViewController: UIViewController{

    
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var txtDescribe: UITextField!
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
         _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBrowser(_ sender: UIButton) {
    }
    @IBAction func btnSave(_ sender: UIBarButtonItem) {
        if (txtName.text == ""){
            let refreshAlert = UIAlertController(title: "Error", message: "Name is not nil!", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: "saveNewAreaSegue", sender: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func accessToPhotoLibrary(){
        var imagePicker = UIImagePickerController()
        //imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveNewAreaSegue"){
            sendNewArea()
        }
    }
    
    
    
    func sendNewArea(){
        var area: _Area = _Area()
        if (txtName.text != ""){
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            area.name = txtName.text
            area.describe = txtDescribe.text
            
            let image: _Image = _Image(id: "",url: "area.png",itemID: "")
            
            area.image = image
            
            FirstViewController.receiveArea = area
        }
    }

}
