//
//  SettingsController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/26/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBOutlet weak var smtLanguage: UISegmentedControl!
    
    @IBAction func smtActionLanguage(_ sender: Any) {
        if (smtLanguage.selectedSegmentIndex == 0){
            SettingsController.language = 0
        }else{
            SettingsController.language = 1
        }
    }
    
    @IBOutlet weak var lblUnitOfMoney: UILabel!
    
    @IBOutlet weak var smtUnitOfMoney: UISegmentedControl!
    
    @IBAction func smtActionUnitOfMoney(_ sender: Any) {
        if (smtUnitOfMoney.selectedSegmentIndex == 0){
            SettingsController.unitOfMoney = 0
        }else{
            SettingsController.unitOfMoney = 1
        }
    }
    
    static var language = 0 //0: Vietnamese 1: English
    static var unitOfMoney = 0 //0: NVND 1: USD

    override func viewDidLoad() {
        super.viewDidLoad()
        initShow()
        // Do any additional setup after loading the view.
    }

    func initShow(){
        smtLanguage.setTitle("VietNamese", forSegmentAt: 0)
        smtLanguage.setTitle("English", forSegmentAt: 1)
        
        smtUnitOfMoney.setTitle("VND", forSegmentAt: 0)
        smtUnitOfMoney.setTitle("USD", forSegmentAt: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
