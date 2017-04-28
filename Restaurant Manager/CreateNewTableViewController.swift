//
//  CreateNewTableViewController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/18/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class CreateNewTableViewController: UIViewController {

    @IBAction func btnBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if (txtNumber.text == ""){
            let refreshAlert = UIAlertController(title: "Error", message: "Number is not nil!", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }else {
            performSegue(withIdentifier: "saveNewTableSegue", sender: nil)
        }
    }
   
    @IBOutlet weak var txtNumber: UITextField!
    
    
    @IBOutlet weak var txtInfor: UITextField!
   
    
    static var indexOfArea:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveNewTableSegue"){
            if (txtNumber.text != ""){
                
                var table: _Table = _Table()
                table.id = txtNumber.text
                table.information = txtInfor.text
                table.statue = true
                table.name = txtNumber.text
                
                let area = FirstViewController.areaManager.getList()[CreateNewTableViewController.indexOfArea!]
                table.area = area
                
                FirstViewController.receiveTable = table
                
                FirstViewController.addingNewTable = true
            }
        }
        
    }
    
}
