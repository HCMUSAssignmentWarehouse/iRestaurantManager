//
//  DetailFoodViewController.swift
//  Restaurant Manager
//
//  Created by Doan Thi Phuong Huyen on 4/24/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class DetailFoodViewController: UIViewController {

    @IBAction func btnEdit(_ sender: UIBarButtonItem) {
        if (!iEditing){
            txtName.isEnabled = true
            txtDescribe.isEnabled = true
            txtPrice.isEnabled = true
            
            self.navigationItem.rightBarButtonItem?.title = "Save"
            iEditing = true
            
        }else{
            
            if (txtName.text == "" || txtPrice.text == "" ){
                let refreshAlert = UIAlertController(title: "Error", message: "Information is not nil!", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            } else if (Double(txtPrice.text!) == nil){
                let refreshAlert = UIAlertController(title: "Error", message: "Wrong format of Price (Just number)!", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                present(refreshAlert, animated: true, completion: nil)

            }
            else {
                updateNewItem()
                performSegue(withIdentifier: "SegueUpdateItem", sender: nil)
            }
            
            
            
        }

    }
    
    
    @IBOutlet weak var edit: UIBarButtonItem!
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtType: UITextField!
    
    
    @IBOutlet weak var txtPrice: UITextField!
    
    
    @IBOutlet weak var delete: UIBarButtonItem!
    
    
    @IBAction func btnDelete(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var txtDescribe: UITextField!
    
    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var lbPrice: UILabel!
   
    
    @IBOutlet weak var showImageFood: UIImageView!
    var iEditing = false

    var ritem:_Item?
    var recieveIndex:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
    }

    func initShow(){
        if (ritem != nil){
            txtName.text = ritem?.name
            txtType.text = ritem?.type
            var price:Double = (ritem?.cost)!
            txtPrice.text = "\(price)"
            txtDescribe.text = ritem?.describe
            
            txtName.isEnabled = false
            txtType.isEnabled = false
            txtDescribe.isEnabled = false
            txtPrice.isEnabled = false
            
        }
    }
    
    
    func updateNewItem(){
        let id = ritem?.id
        ritem?.id = id
        ritem?.name = txtName.text
        ritem?.cost = Double(txtPrice.text!)
        let x = txtPrice.text!
        
    }


  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueUpdateItem"{
            let mainMenuVC = segue.destination as! MainMenuvarwController
            mainMenuVC.newItemToUpdate = ritem
            mainMenuVC.sendIndex = recieveIndex
        }else if segue.identifier == "SegueDeleteItem"{
            let mainMenuVC = segue.destination as! MainMenuvarwController
            mainMenuVC.willDeleteItem = true
            mainMenuVC.newItemToUpdate = ritem
            mainMenuVC.sendIndex = recieveIndex
        }
        
    }
 

}
