//
//  DetailAreaController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/25/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//
import CoreData
import UIKit

class DetailAreaController: UIViewController {

    
    
    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func btnEdit(_ sender: Any) {
        if (!iEditing){
            txtName.isEnabled = true
            txtDescribe.isEnabled = true

            self.navigationItem.rightBarButtonItem?.title = "Save"
            iEditing = true
            
        }else{
            
            if (txtName.text == ""){
                let refreshAlert = UIAlertController(title: "Error", message: "Name is not nil!", preferredStyle: UIAlertControllerStyle.alert)
                
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                }))
                
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                }))
                
                present(refreshAlert, animated: true, completion: nil)
            }else{
                updateNewArea()
                performSegue(withIdentifier: "SegueSaveNewAreaID", sender: nil)
            }
            
            
            
        }
    }
    
    
    
    
    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBOutlet weak var txtDescribe: UITextField!
    
    var currArea: _Area?
    var iEditing = false
    var indexOfArea:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        // Do any additional setup after loading the view.
    }

    func initShow(){
        txtName.layer.borderWidth = 0.5
        txtDescribe.layer.borderWidth = 0.5
        txtName.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor
        txtDescribe.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor

        if (currArea != nil){
            txtName.text = currArea?.name
            txtDescribe.text = currArea?.describe
        }
        
        if (!iEditing){
            txtName.isEnabled = false
            txtDescribe.isEnabled = false
        }
        
    }
    
    func updateNewArea(){
        if (txtName.text != "" && txtDescribe.text != ""){
            var x = currArea?.id

            currArea?.id = x
            currArea?.name = txtName.text
            currArea?.describe = txtDescribe.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueSaveNewAreaID" && txtName.text != ""{
            let mainVC  = segue.destination as! FirstViewController
            mainVC.newAreaToUpdate = currArea
            mainVC.indexOfSelectedArea = indexOfArea
        }
    }


}
