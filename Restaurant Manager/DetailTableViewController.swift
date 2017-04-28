//
//  DetailTableViewController.swift
//  Restaurant Manager
//
//  Created by Doan Thi Phuong Huyen on 4/22/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import CoreData

class DetailTableViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    

    var recievedtable:_Table = _Table()
    

    
    
    @IBOutlet weak var btnOption: UIBarButtonItem!
    
    @IBAction func actionOption(_ sender: UIBarButtonItem) {
        hideMenu()
        
    }
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
   
    
    @IBAction func actionBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    @IBOutlet var viewMenu: [UIView]!
        {
        didSet{
            viewMenu.forEach{
                $0.layer.borderWidth = 0.5
                $0.layer.borderColor = UIColor(red:72/255,green:201/255,blue:176/255, alpha:1.0).cgColor
                $0.isHidden = true
                $0.layer.cornerRadius = 3
            }
        }
    }
    func hideMenu()
    {
        UIView.animate(withDuration:0.3)
        {
            self.viewMenu.forEach{
                $0.isHidden = !$0.isHidden
            }
        }
        
    }

    @IBOutlet weak var lblID: UILabel!
     
    @IBOutlet weak var lblArea: UILabel!
    
    @IBOutlet weak var lblInfor: UILabel!
    
    @IBOutlet weak var information: UILabel!
    
   
    @IBOutlet weak var lblState: UILabel!
    
    @IBOutlet weak var txtID: UITextField!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var txtArea: UITextField!
    
    @IBOutlet weak var smtState: UISegmentedControl!
    
    @IBOutlet weak var btnMenu: UIButton!
    
    
    @IBAction func actionMenu(_ sender: Any) {
    }
    
    
    @IBOutlet weak var lblTotal: UILabel!
    
    
    
    @IBOutlet weak var txtTotsl: UILabel!
    
    
    
    @IBOutlet weak var tblListItem: UITableView!
    
    @IBOutlet weak var txtTotal: UITextField!
    
    @IBOutlet weak var ImgTable: UIImageView!
    
    
    @IBAction func actionState(_ sender: UISegmentedControl) {
            }
    
    
    @IBOutlet weak var btnSave: UIBarButtonItem!
   
    
    @IBAction func actionSave(_ sender: UIBarButtonItem) {
        if (txtID.text == ""){
            let refreshAlert = UIAlertController(title: "Error", message: "ID is not nil!", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        else{
            updateCurrTable()
            performSegue(withIdentifier: "SegueUpdateTable", sender: nil)
        }

    }
    
    
    @IBAction func Edit(_ sender: UIButton) {
        txtID.isEnabled = true
        txtTotsl.isEnabled = true
        
        self.btnSave.title = "Save"
        self.btnSave.isEnabled = true
        
        
        
        hideMenu()
    }
    
    @IBAction func Delete(_ sender: UIButton) {
        hideMenu()
        performSegue(withIdentifier: "SegueDeleteTable", sender: nil)
    }
    @IBAction func Cancel(_ sender: UIButton) {
        
        deleteStatistic()
        
        clearChoosenList()
        
        updateStatueTable(value: true)
        
        hideMenu()
        _ = navigationController?.popViewController(animated: true)

    }
    
   var alertmenu: UIAlertController!
    var txtFoodName: UITextField!
    var txtFoodPrice: UITextField!
    var txtFoodOtherInfo: UITextField!
    var typeList:[String]!
    var isTheFirstTime = true
    @IBOutlet weak var btnFoodAndDrink: UIButton!
    
   var rtable:_Table = _Table()
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)

    }
    
    static var chosenList:[_Item] = [_Item]()
    static var numberList:[Int] = [Int]()
    static var statisticList:[_Statistic] = [_Statistic]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //detailTable()
        
        print("so item : " + "\(DetailTableViewController.chosenList.count)")

        showTime()
        
        initShow()
        
        if (isTheFirstTime == true){
            loadStatistic()
            
            isTheFirstTime = false
        }
        
        updateStatueTable(value: false)
    }
    
    
    func clearChoosenList(){

        var count = 0
        while (count < DetailTableViewController.chosenList.count){
            DetailTableViewController.chosenList.remove(at: count)
            count += 1
        }
        
    }
    
    func loadStatistic(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        var tempList = [Statistic]()
        tempList = try!context.fetch(Statistic.fetchRequest()) as! [Statistic]
        
        for element in tempList{
            if (element.tableID == rtable.id){
                
                var item = searchItem(id: element.itemID!)
                DetailTableViewController.chosenList.append(item)
                
                var statistic: _Statistic = _Statistic()
                statistic.id = element.id
                statistic.tableID = element.tableID
                statistic.itemID = element.itemID
                statistic.date = element.date as Date?
                statistic.numberOfItem = element.numberOfItem
                DetailTableViewController.statisticList.append(statistic)
                
            }
            
        }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func deleteStatistic(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        var tempList = [Statistic]()
        tempList = try!context.fetch(Statistic.fetchRequest()) as! [Statistic]
        
        for element in tempList{
        
            for sub in DetailTableViewController.statisticList{
                if (element.id == sub.id){
                    context.delete(element)
                }
            }
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

    }
    
    func updateStatueTable(value:Bool){
        
        if (DetailTableViewController.chosenList.count > 0){
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
            var tableList = [Table]()
            tableList = try!context.fetch(Table.fetchRequest()) as! [Table]
            
            for element in tableList{
                if element.id == rtable.id{
                    
                    element.statue = value
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
            
        }
        
    }

    
    func searchItem(id: String) -> _Item{
        var result: _Item!
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var tempList = [Item]()
        tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
        
        
        for element in tempList{
            if (element.id == id){
                var item = _Item(id: id,name: element.name!,cost: element.cost,describe: element.describe!,imageUrl: "",type: element.type!)
                return item
            }
        
        }
        return result
    }
    
    func initShow(){
        if(rtable != nil){
            
            self.btnSave.title = ""
            self.btnSave.isEnabled = false

            
            tblListItem.delegate = self
            tblListItem.dataSource = self
            tblListItem.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

            smtState.setTitle("Available", forSegmentAt: 0)
            smtState.setTitle("Not available", forSegmentAt: 1)
            
            if rtable.statue == false{
                smtState.selectedSegmentIndex = 1
            }else{
                smtState.selectedSegmentIndex = 0
            }
            
            txtID.text = rtable.name
            txtArea.text = rtable.area?.name
            txtTotal.text = rtable.information
            
            var total = calcMoney()
            
            if (SettingsController.unitOfMoney == 0){
                total += "VND"
            }else{
                total += "$"
            }
            
            txtTotsl.text = total
            
            txtID.layer.borderWidth = 0.5
            txtID.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor
            txtID.isEnabled = false
            txtTotsl.layer.borderWidth = 0.5
            txtTotsl.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor
            txtTotsl.isEnabled = false
            txtTotal.layer.borderWidth = 0.5
            txtTotal.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor
            txtTotal.isEnabled = false
            txtArea.layer.borderWidth = 0.5
            txtArea.layer.borderColor = UIColor(red:213, green:219,blue: 219,alpha:1).cgColor
            txtArea.isEnabled = false
            
            
        }
        
    }
    
    
    func calcMoney() -> String{
        var total = 0.0
    
        var count = 0
        
        for item in DetailTableViewController.chosenList{
            
            var number = Double(DetailTableViewController.chosenList[count].cost!)
            
            var cost = Double(item.cost!)
            
            if (SettingsController.unitOfMoney == 1){
                cost = cost / 22666.38
            }
            
            total += cost * number
            
            count += 1
        }
        
        return String(format: "%.2f", arguments: [total])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (rtable != nil){
            return DetailTableViewController.chosenList.count
        }
        else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(red:19/255,green:141/255,blue:117/255, alpha:1.0).cgColor
        cell.backgroundColor = UIColor(red:232/255,green:248/255,blue:245/255, alpha:1.0)

        if ((DetailTableViewController.chosenList.count) > 0){
            var imageview:UIImageView!
            imageview = UIImageView(frame:CGRect(x:10,y:16,width:32,height:32))
            
            cell.textLabel?.textAlignment = .center

            imageview.image = UIImage(named: "delete.png")
            cell.addSubview(imageview)
            var number:Int32 = DetailTableViewController.statisticList[indexPath.row].numberOfItem!
            var temp = "\(number)" + " "
            cell.textLabel?.text = temp + (DetailTableViewController.chosenList[indexPath.row].name)!
            
        }else {
            cell.textLabel?.text = "No chosen item"
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        cell.textLabel?.textColor = UIColor(red:26/255,green:82/255,blue:118/255, alpha:1.0)

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func updateCurrTable(){
        rtable.name = txtID.text
        rtable.information = txtTotal.text
        
        if smtState.selectedSegmentIndex == 0{
            rtable.statue = true
        }else{
            rtable.statue = false
        }
        
        let area = rtable.area
        rtable.area = area
        
        
    }
    /*func hideMenu()
    {
        UIView.animate(withDuration:0.3)
        {
            self.viewMenu.forEach{
                $0.isHidden = !$0.isHidden
            }
        }
        
    }
    func hideViewNewFood()
    {
        UIView.animate(withDuration:0.3)
        {
            self.viewNewFood.forEach{
                $0.isHidden = !$0.isHidden
            }
        }
    }
    
    @IBAction func btnMenuTable(_ sender: UIBarButtonItem)
    {
        UIView.animate(withDuration:0.3)
        {
            self.viewMenu.forEach{
                $0.isHidden = !$0.isHidden
            }
            
        }
    }
    
    @IBAction func btnCreateNewFood(_ sender: Any) {
        
        UIView.animate(withDuration:0.3)
        {
            self.viewNewFood.forEach{
                $0.isHidden = !$0.isHidden
            }
        }
        hideMenu()
    }
    
    @IBAction func btnCancelViewFood(_ sender: Any) {
        hideViewNewFood()
    }
    @IBAction func btnCloseTable(_ sender: Any) {
        
        let confirm = UIAlertController(title: "Do you want to close this table ", message: "Close this table", preferredStyle: .alert)
        
        confirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{
            (action: UIAlertAction) in
            
            
        }))
        
        confirm.addAction(UIAlertAction(title: "OK", style: .default , handler:{
            (action: UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
            
        }))
        
     
        self.present(confirm, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func btnDeleteTable(_ sender: Any) {
        let confirm = UIAlertController(title: "Do you want to delete this table ", message: "Delete this table", preferredStyle: .alert)
        
        confirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{
            (action: UIAlertAction) in
            
            
        }))
        
        confirm.addAction(UIAlertAction(title: "OK", style: .default , handler:{
            (action: UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        
        self.present(confirm, animated: true, completion: nil)
        
        hideMenu()
        
        
    }
    
    
    @IBOutlet weak var txtNumberFood: UITextField!
    
    @IBAction func btnIncreateNumber(_ sender: Any) {
        
        let doubleNumber = Double(txtNumberFood.text!)!
        
        txtNumberFood.text = String(doubleNumber + 1)
        
        
        
    }
    
    @IBAction func btnDecreateNumber(_ sender: Any) {
        let doubleNumber = Double(txtNumberFood.text!)!
        if(doubleNumber > 0)
        {
            
            txtNumberFood.text = String(doubleNumber - 1)
        }
        
    }
    
    
    
    

    */
    
       func showTime ()
    {
      //  var date = Date()
        let todaydate : NSDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = " HH:mm:ss dd/MM/yyyy"
       // textDate.text =
       // lblshowTime.text = String(describing: date)
        lblTime.text = dateFormatter.string(from: todaydate as Date)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueDeleteTable"{
            let MainVC = segue.destination as! FirstViewController
            MainVC.willDeleteTable = true
            MainVC.table = rtable
        }
        if segue.identifier == "SegueUpdateTable"{
            let mainVC = segue.destination as! FirstViewController
            mainVC.table = rtable
            mainVC.willUpdateTable = true
        }
        if segue.identifier == "show_menu"{
            let menuVC = segue.destination as! MainMenuvarwController
            menuVC.isChoosingItem = true
            menuVC.tableID = rtable.id
        }
    }
}
