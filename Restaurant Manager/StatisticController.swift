//
//  StatisticController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/27/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit

import CoreData

class StatisticController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var smtTypeStatistic: UISegmentedControl!
    
    
    @IBAction func smtAction(_ sender: Any) {
        if (smtTypeStatistic.selectedSegmentIndex == 1){
            performSegue(withIdentifier: "SegueGetItem", sender: nil)
            StatisticController.bigType = 1
        }else{
            StatisticController.bigType = 0

        }
        
    }
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblFollowDay: UIButton!
    
    @IBAction func actionFollowDay(_ sender: Any) {
        self.type = 0
        let alertController = UIAlertController(title: "Enter day", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let date = alertController.textFields![0] as UITextField
            let month = alertController.textFields![1] as UITextField
            let year = alertController.textFields![2] as UITextField

           // if (Int(txtNumber.text!) != nil){
            self.date = Int(date.text!)!
            self.month = Int(month.text!)!
            self.year = Int(year.text!)!
            
            self.statisticList = [Statistic]()
            
            self.getList()
            
             self.tblStatistic.reloadData()
            self.setTotalText()
            //}
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter date"
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter month"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter year"
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var btnFollowMonth: UIButton!
    
    @IBAction func actionFollowMonth(_ sender: Any) {
        self.type = 1
        
        let alertController = UIAlertController(title: "Enter month", message: "", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let month = alertController.textFields![0] as UITextField
            
            // if (Int(txtNumber.text!) != nil){
            self.month = Int(month.text!)!
            
            self.statisticList = [Statistic]()
            
            self.getList()
            
            self.tblStatistic.reloadData()
            self.setTotalText()
            //}
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
      
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter month"
        }
       
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var btnFollowTime: UIButton!
    
    
    @IBAction func actionFollowTime(_ sender: Any) {
        self.type = 3
        
        let alertController = UIAlertController(title: "Enter day", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let date = alertController.textFields![0] as UITextField
            let month = alertController.textFields![1] as UITextField
            let year = alertController.textFields![2] as UITextField
            
            let todate = alertController.textFields![3] as UITextField
            let tomonth = alertController.textFields![4] as UITextField
            let toyear = alertController.textFields![5] as UITextField
            
            // if (Int(txtNumber.text!) != nil){
            self.date = Int(date.text!)!
            self.month = Int(month.text!)!
            self.year = Int(year.text!)!
            
            self.toDate = Int(todate.text!)!
            self.toMonth = Int(tomonth.text!)!
            self.toYear = Int(toyear.text!)!
            
            self.statisticList = [Statistic]()
            
            self.getList()
            
            self.tblStatistic.reloadData()
            self.setTotalText()
            //}
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter from date"
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter from month"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter from year"
        }
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter to date"
        }
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter to month"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter to year"
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)

        
    }
    
    
    @IBOutlet weak var btnYear: UIButton!
    
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var txtTotal: UITextField!
    
    @IBAction func actionYear(_ sender: Any) {
        self.type = 2
        let alertController = UIAlertController(title: "Enter month", message: "", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "OK", style: .default, handler: {
            alert -> Void in
            
            let year = alertController.textFields![0] as UITextField
            
            // if (Int(txtNumber.text!) != nil){
            self.year = Int(year.text!)!
            
            self.statisticList = [Statistic]()
            
            self.getList()
            
            self.tblStatistic.reloadData()
            self.setTotalText()
            //}
            
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter year"
        }
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)

    }
    
    @IBOutlet weak var tblStatistic: UITableView!
    
    var date:Int = 12
    var month:Int = 12
    var year:Int = 1996
    
    var toDate:Int = 27
    var toMonth:Int = 4
    var toYear:Int = 2017
    
    static var bigType = 0// 0: follow time, 1: follow item
    var currItem: _Item?
    var type = 0; //0: follow date, 1: folow month , 2: follow year, 3: folloew time to time
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initShow()
    }
    
    var statisticList: [Statistic] = [Statistic]()
    
    func initShow(){
        
        smtTypeStatistic.setTitle("Following Time", forSegmentAt: 0)
        smtTypeStatistic.setTitle("Following Item", forSegmentAt: 1)
        
        tblStatistic.delegate = self
        tblStatistic.dataSource = self
        tblStatistic.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

        
    }
    
    func setTotalText(){
        
        var total:Double = 0.0
        
        for element in statisticList{
            total += Double(element.numberOfItem) * searchItemCost(id: element.itemID!)
        }
        
        if SettingsController.unitOfMoney == 0{
            txtTotal.text = String(format: "%.2f", arguments: [total]) + "VND"

        }else{
            total = total / 22666.38
            txtTotal.text = String(format: "%.2f", arguments: [total]) + "$"

        }
        
    }
    
    func compareAbsoluteTwoDate(dateToCompare:Date) ->Bool{
        
        let calendar = Calendar.current
        
        let _date = calendar.component(.day, from: dateToCompare)
        let _month = calendar.component(.month, from: dateToCompare)
        let _year = calendar.component(.year, from: dateToCompare)

        if date == _date && month == _month && year == _year{
            return true
        }
        return false
    }
    
    func compareFollowTimeToTime(date_:Date) ->Bool{
        
        let calendar = Calendar.current
        
        let _date = calendar.component(.day, from: date_)
        let _month = calendar.component(.month, from: date_)
        let _year = calendar.component(.year, from: date_)
        
        let z = GetDateFromString(date:_date, month: _month, year:_year)
        let x = GetDateFromString(date:date, month: month, year:year)
        let y = GetDateFromString(date:toDate, month: toMonth, year:toYear)
    
        if (x <= z && z <= y){
            return true
        }
        
        return false
    }

    func GetDateFromString(date:Int, month: Int, year:Int)-> Date
    {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = date
        let date = calendar?.date(from: components as DateComponents)
        return date!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func compareFollowMonth(dateToCompare:Date) -> Bool{
        let calendar = Calendar.current
        
        let _month = calendar.component(.month, from: dateToCompare)
        if (month == _month){
            return true
        }
        return false
    }
    
    func compareFollowYear(dateToCompare:Date) -> Bool{
        let calendar = Calendar.current
        
        let _year = calendar.component(.year, from: dateToCompare)
        if (year == _year){
            return true
        }
        return false
    }
    
    func getList(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        var tempList = [Statistic]()
        tempList = try!context.fetch(Statistic.fetchRequest()) as! [Statistic]
        let x = currItem
        
        for element in tempList{
            
            
            let date:Date = element.date as! Date
            if (StatisticController.bigType == 0){
                if (type == 0 && compareAbsoluteTwoDate(dateToCompare: date)){
                    statisticList.append(element)
                }else if (type == 1 && compareFollowMonth(dateToCompare:date)){
                    statisticList.append(element)
                }else if (type == 2 && compareFollowYear(dateToCompare:date)){
                    statisticList.append(element)
                }else if (type == 3 && compareFollowTimeToTime(date_:date)){
                    statisticList.append(element)
                }
            }
            
            else if (element.itemID == currItem?.id ){
                if (type == 0 && compareAbsoluteTwoDate(dateToCompare: date)){
                    statisticList.append(element)
                }else if (type == 1 && compareFollowMonth(dateToCompare:date)){
                    statisticList.append(element)
                }else if (type == 2 && compareFollowYear(dateToCompare:date)){
                    statisticList.append(element)
                }else if (type == 3 && compareFollowTimeToTime(date_:date)){
                    statisticList.append(element)
                    
                }
            }
            
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statisticList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.layer.borderWidth = 0.5
        cell.layer.shadowColor = UIColor(red:208/255,green:236/255,blue:231/255, alpha:1.0).cgColor
        
        
        
        if(StatisticController.bigType == 0 &&  searchTableName(id: statisticList[indexPath.row].tableID!) != "" && searchItemName(id: statisticList[indexPath.row].itemID!) != ""){
            let tablName = searchTableName(id: statisticList[indexPath.row].tableID!)
            
            let itemName = searchItemName(id: statisticList[indexPath.row].itemID!)
            
            
            var text = "table: " + tablName
            text += "----" + "\(statisticList[indexPath.row].numberOfItem)"
            text += " " + itemName
            cell.textLabel?.text = text

        }else if (StatisticController.bigType == 1 &&  searchTableName(id: statisticList[indexPath.row].tableID!) != "" && searchItemName(id: statisticList[indexPath.row].itemID!) != ""){
            let tablName = searchTableName(id: statisticList[indexPath.row].tableID!)
            
            
            
            var text = "table: " + tablName
            text += "----Number is: " + "\(statisticList[indexPath.row].numberOfItem)"
            cell.textLabel?.text = text
            
        }
        else{
            cell.textLabel?.text = "information not exist!"
        }
        
        cell.layer.borderWidth = 0.5
        
        cell.layer.borderColor = UIColor(red:19/255,green:141/255,blue:117/255, alpha:1.0).cgColor
        cell.backgroundColor = UIColor(red:232/255,green:248/255,blue:245/255, alpha:1.0)

        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        cell.textLabel?.textColor = UIColor(red:26/255,green:82/255,blue:118/255, alpha:1.0)
        cell.textLabel?.textAlignment = .center
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func searchTableName(id: String) -> String{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
        var tempList = [Table]()
        tempList = try!context.fetch(Table.fetchRequest()) as! [Table]
        for element in tempList{
            if element.id == id{
                return element.name!
            }
        }
        return ""
    }
    
    func searchItemName(id: String) -> String{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var tempList = [Item]()
        tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
        for element in tempList{
            if element.id == id{
                return element.name!
            }
        }
        return ""
    }
    
    func searchItemCost(id: String) -> Double{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var tempList = [Item]()
        tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
        for element in tempList{
            if element.id == id{
                return element.cost
            }
        }
        return 0
    }

    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueGetItem"{
            let des = segue.destination as! MainMenuvarwController
            des.isSendingItem = true
        }
        
    }
  

}
