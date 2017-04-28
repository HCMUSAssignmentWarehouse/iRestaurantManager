//
//  AddNewFoodViewController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/26/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class AddNewFoodViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var lbName: UILabel!
    
    
    @IBOutlet weak var pVUnitOfMoney: UIPickerView!
    
    
    
    @IBOutlet weak var txtPrice: UITextField!
    
    @IBOutlet weak var btnChangePrice: UIButton!
    
    var cost: Double = 0
    var number: Int = 0
    var unit:[String] = [String]()
    @IBAction func btnActionChangePrice(_ sender: Any) {
        cost = Double(txtPrice.text!)!
        cost += 1
        txtPrice.text = "\(cost)"
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    @IBOutlet weak var txtDescribe: UITextField!
    
    @IBOutlet weak var lblDescribe: UILabel!
    
    
    
    
    
    
    
    
    @IBAction func btnSave(_ sender: Any) {
        
        print("\(txtName.text)")
        
        if (txtName.text == "" || txtPrice.text == ""){
            let refreshAlert = UIAlertController(title: "Error", message: "Information is not nil!", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var btnCancel: UIButton!
    
    
    @IBOutlet weak var txtName: UITextField!
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    

    var type:String?
    var indexUnit: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        unit = ["VND", "$"]
        pVUnitOfMoney.delegate = self
        pVUnitOfMoney.dataSource = self
        
        
        pVUnitOfMoney.selectRow(0, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
    }

    
    
    //MARK: -pickerview
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return unit[row]
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        indexUnit = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveNewFood"
        {
            if (txtName.text != "" && txtPrice.text != ""){
                
                var cost:Double?
                
                if indexUnit == 0{
                    cost = Double(txtPrice.text!)
                }else{
                    cost = 22666.38 * Double(txtPrice.text!)!
                }
                
                var temp: _Item = _Item(id: "",name: txtName.text!,cost: cost!,describe: txtDescribe.text!,imageUrl: "", type: type!)
                let mainMenuVC = segue.destination as! MainMenuvarwController
                mainMenuVC.recieveItem = temp
                mainMenuVC.type = type
            }
        }
    }
   

}
