//
//  MainMenuViewController.swift
//  Restaurant Manager
//
//  Created by Nha T.Tran on 4/20/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import CoreData

class MainMenuvarwController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var ok: UIBarButtonItem!
    
    @IBAction func actionOk(_ sender: Any) {
        if (isChoosingItem == true){
            performSegue(withIdentifier: "SegueChooseItem", sender: nil)
        }
    }
    
    @IBOutlet weak var tblDrink: UITableView!
    
    @IBOutlet weak var tblPot: UITableView!
    
    @IBOutlet weak var tblGrill: UITableView!
    
    @IBAction func addAPot(_ sender: Any) {
        type = "1"
    }
    
    @IBAction func addADrink(_ sender: Any) {
        type = "2"
    }
    
    
    @IBAction func addAGrill(_ sender: Any) {
        type = "3"
    }
    
    @IBAction func btnAddNewFood(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addNewFood", sender: Any?.self)
    }
    var displayWidth: CGFloat?
    var tableHeight: CGFloat?
    var labelHeight:CGFloat?
    
    var pot:[_Item] = [_Item]()
    var drink:[_Item] = [_Item]()
    var grill:[_Item] = [_Item]()
    var temp:[String] = [String]()
    var myTableView2: UITableView!
    var timerForShowScrollIndicator: Timer?

    var recieveItem: _Item?
    var type:String?
    var willDeleteItem:Bool = false
    var newItemToUpdate: _Item?
    var isChoosingItem = false
    var tableID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWidth = self.view.frame.width - 20
        tableHeight = self.view.frame.height / 4
        labelHeight = self.view.frame.height / 15
        
        initTable()

        //load from core data
        
        //clearItem()
        
        //createDefaultItem()
        
        loadItemFromCoreData()
        addNewItem()
        updateItem()
        deleteItem()
       // saveAllDefaultItemToCoreData()
        
        // Do any additional setup after loading the view.
    }
    
    func deleteItem(){
        if willDeleteItem == true{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            var itemList = [Item]()
            itemList = try!context.fetch(Item.fetchRequest()) as! [Item]
            
            for element in itemList{
                if element.id == newItemToUpdate?.id{
                    if (element.type == "1"){
                        pot.remove(at: sendIndex!)
                        tblPot.reloadData()
                    }else if(element.type == "2"){
                        drink.remove(at: sendIndex!)
                        tblDrink.reloadData()
                    }else if(element.type == "3"){
                        grill.remove(at: sendIndex!)
                        tblGrill.reloadData()
                    }
                    
                    context.delete(element)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    return
                }
            }

        }
    }
    
    func addNewItem(){
        if (recieveItem != nil){
            if (type == "1"){
                pot.append(recieveItem!)
                tblPot.reloadData()
            }else if (type == "2"){
                drink.append(recieveItem!)
                tblDrink.reloadData()
            }else if (type == "3"){
                grill.append(recieveItem!)
                tblGrill.reloadData()
            }
            
            saveItemToCoreData(_item: recieveItem!)
        }
    }
    
    
    func updateItem(){
        if (newItemToUpdate != nil){
            
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
                var tempList = [Item]()
                tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
                
                var count:Int = 0
                
                for element in tempList{
                    
                    let x = newItemToUpdate?.id
                    
                    if (element.id == newItemToUpdate?.id){
                        
                        element.id = newItemToUpdate?.id
                        element.name = newItemToUpdate?.name
                        element.cost = (newItemToUpdate?.cost)!
                        element.describe = newItemToUpdate?.describe
                        
                        if (element.type == "1"){
                            pot.remove(at: sendIndex!)
                            pot.insert(newItemToUpdate!, at: sendIndex!)
                            tblPot.reloadData()
                        }else if(element.type == "2"){
                            drink.remove(at: sendIndex!)
                            drink.insert(newItemToUpdate!, at: sendIndex!)
                            tblDrink.reloadData()
                        }else if(element.type == "3"){
                            grill.remove(at: sendIndex!)
                            grill.insert(newItemToUpdate!, at: sendIndex!)
                            tblGrill.reloadData()
                        }
                        
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        return
                    }
                    
                    count += 1
                    
            }
        }
    }
    
    func loadItemFromCoreData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var tempList = [Item]()
        tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
        let imageList = try!context.fetch(Image.fetchRequest()) as! [Image]

        for element in tempList{
            var temp = [_Image]()
            for img in imageList{
                if (img.itemId == element.id){
                    var _img = _Image(id: img.id!,url: img.url!,itemID: img.itemId!)
                    temp.append(_img)
                }
            }
            
            var urlFirstImage:String
            if (tempList.count > 1){
                urlFirstImage = temp[0].url!
            }else{
                urlFirstImage = ""
            }
            
            var _item = _Item(id: element.id!,name: element.name!,cost: element.cost,describe: element.describe!,imageUrl: urlFirstImage,type:element.type!)
            let x = element.id
            
            if (element.type == "1"){
                pot.append(_item)
            }else if(element.type == "2"){
                drink.append(_item)
            }else if (element.type == "3"){
                grill.append(_item)
            }
           
            
        }

    }
    
    func clearItem(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        var tempList = [Item]()
        tempList = try!context.fetch(Item.fetchRequest()) as! [Item]
        
        for element in tempList{
            context.delete(element)
            
        }
        
        var tempList2 = [Image]()
        tempList2 = try!context.fetch(Image.fetchRequest()) as! [Image]
        
        for element in tempList2{
            context.delete(element)
            
        }

        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    func initTable(){
        tblPot.delegate = self
        tblPot.dataSource = self
        tblPot.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        
        tblDrink.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tblDrink.dataSource = self
        tblDrink.delegate = self
        
        tblGrill.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tblGrill.dataSource = self
        tblGrill.delegate = self
    }
    
    func createDefaultItem(){
        pot.append(_Item(id: "1",name: "Lẫu thái lớn",cost: 120000,describe: "For 4 people",imageUrl: "lauthai.jpg",type:"1"))
        
        pot.append(_Item(id: "2",name: "Lẫu thái nhỏ",cost: 80000,describe: "For 2 people",imageUrl: "lauthainho.jpg",type:"1"))
        pot.append(_Item(id: "3",name: "Lẫu thập cẩm",cost: 120000,describe: "For 4 people",imageUrl: "lauthapcam.jpg",type:"1"))
        pot.append(_Item(id: "4",name: "Lẫu hải sản",cost: 120000,describe: "For 4 people",imageUrl: "lauhaisan.jpg",type:"1"))
        pot.append(_Item(id: "5",name: "Lẫu cá diêu hồng",cost: 120000,describe: "For 4 people",imageUrl: "laucadieuhong.jpg",type:"1"))
        pot.append(_Item(id: "6",name: "Lẫu cá kèo",cost: 120000,describe: "For 4 people",imageUrl: "laucakeo.jpg",type:"1"))
        
        drink.append(_Item(id: "7",name: "7 Up",cost: 120000,describe: "",imageUrl: "7up.jpg",type:"2"))
        drink.append(_Item(id: "8",name: "Bò cụng",cost: 120000,describe: "",imageUrl: "bocung.jpg",type:"2"))
        drink.append(_Item(id: "9",name: "Nước suối",cost: 120000,describe: "",imageUrl: "nuocsuoi.jpg",type:"2"))
        drink.append(_Item(id: "10",name: "Trà xanh không độ",cost: 120000,describe: "",imageUrl: "traxanh.jpg",type:"2"))
        drink.append(_Item(id: "11",name: "Sài Gòn đỏ",cost: 120000,describe: "",imageUrl: "saigondo.jpg",type:"2"))
        drink.append(_Item(id: "12",name: "Tiger Bạc",cost: 120000,describe: "",imageUrl: "tigerbac.jpg",type:"2"))
        drink.append(_Item(id: "13",name: "Tiger chai",cost: 120000,describe: "",imageUrl: "tigerchai.jpg",type:"2"))
        drink.append(_Item(id: "14",name: "Tiger lon",cost: 120000,describe: "",imageUrl: "tigerlon.jpg",type:"2"))
        drink.append(_Item(id: "15",name: "Heineken Chai",cost: 120000,describe: "",imageUrl: "heinekenchai.jpg",type:"2"))
        drink.append(_Item(id: "16",name: "Heineken Lon",cost: 120000,describe: "",imageUrl: "heinekenlon.jpg",type:"2"))
        drink.append(_Item(id: "17",name: "Larue Chai",cost: 120000,describe: "",imageUrl: "laruechai.jpg",type:"2"))
        drink.append(_Item(id: "18",name: "Larue Lon",cost: 120000,describe: "",imageUrl: "laruelon.jpg",type:"2"))
        
        grill.append(_Item(id: "19",name: "Mờ gà nướng",cost: 120000,describe: "",imageUrl: "moganuong.jpg",type:"3"))
        grill.append(_Item(id: "20",name: "Tôm nướng",cost: 120000,describe: "",imageUrl: "tomnuong.jpg",type:"3"))
        grill.append(_Item(id: "21",name: "Sò nướng bơ",cost: 120000,describe: "",imageUrl: "sonuongbo.jpg",type:"3"))
        grill.append(_Item(id: "22",name: "Chân gà nướng",cost: 120000,describe: "",imageUrl: "changanuong.jpg",type:"3"))
        grill.append(_Item(id: "23",name: "Cút nướng",cost: 120000,describe: "",imageUrl: "cutnuong.jpg",type:"3"))
        grill.append(_Item(id: "24",name: "Thịt heo ba chỉ nướng sa tế",cost: 120000,describe: "",imageUrl: "bachinuongsate.jpg",type:"3"))

        

    }
    
    func saveAllDefaultItemToCoreData(){
        for element in pot{
            saveItemToCoreData(_item: element)
        }
        for element in drink{
            saveItemToCoreData(_item: element)
        }
        for element in grill{
            saveItemToCoreData(_item: element)
        }
    }
    
    func saveItemToCoreData(_item:_Item){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        let item = Item(context: context)
        item.id = _item.id
        item.name = _item.name
        item.describe = _item.describe
        item.cost = _item.cost!
        item.type = _item.type
        
        for element in _item.image{
            let table = Table (context: context)
            
            let image = Image(context: context)
            image.id = element.id
            image.url = element.url
            image.itemId = element.itemID
            
            item.images?.adding(image)
            
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
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

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (tableView.tag == 0){
            return pot.count
        }else if (tableView.tag == 1){
            return drink.count
        }else{
            return grill.count
        }
      
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        cell.textLabel?.text = "empty cell"
        cell.layer.borderWidth = 0.5
        var imageview:UIImageView!
        imageview = UIImageView(frame:CGRect(x:30,y:8,width:32,height:32))
        imageview.image = UIImage(named: "iconItem.png")
        cell.addSubview(imageview)

        if (tableView.tag == 0){

            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
            var title:String!
            title = pot[indexPath.row].name! + "-----"
            if (SettingsController.unitOfMoney == 0){
                var price:Double = (pot[indexPath.row].cost)!
    
                title = title + String(format: "%.2f", arguments: [price]) + "VND"

            }
            else{
                var price:Double = (pot[indexPath.row].cost)! / 22666.38
                var temp:String!
                
                
                title = title + String(format: "%.2f", arguments: [price]) + "$"
            }
            cell.textLabel?.text = title

            cell.textLabel?.textAlignment = .center
            
            
            
        }else if (tableView.tag == 1){
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
            var title:String!
            title = drink[indexPath.row].name! + "-----"
            if (SettingsController.unitOfMoney == 0){
                var price:Double = (drink[indexPath.row].cost)!
                
                title = title + String(format: "%.2f", arguments: [price]) + "VND"
                
            }
            else{
                var price:Double = (drink[indexPath.row].cost)! / 22666.38
                var temp:String!
                
                
                title = title + String(format: "%.2f", arguments: [price]) + "$"
            }
            cell.textLabel?.text = title
            
            cell.textLabel?.textAlignment = .center
            
            
        }else{
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium)
            var title:String!
            title = grill[indexPath.row].name! + "-----"
            if (SettingsController.unitOfMoney == 0){
                var price:Double = (grill[indexPath.row].cost)!
                
                title = title + String(format: "%.2f", arguments: [price]) + "VND"
                
            }
            else{
                var price:Double = (grill[indexPath.row].cost)! / 22666.38
                var temp:String!
                
                
                title = title + String(format: "%.2f", arguments: [price]) + "$"
            }
            cell.textLabel?.text = title
            cell.textLabel?.textAlignment = .center
            
            
            
        }
        
        
        return cell
    }
    
  
    
    var _item:_Item?
    var sendIndex:Int?
    var isSendingItem = false
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var temp:[String] = [String]()
        var element: _Item!
        sendIndex = indexPath.row

        if  tableView.tag == 0
        {
            element = pot[indexPath.row]
            
            
            _item = _Item(id: element.id!,name: element.name!,cost: element.cost!,describe: element.describe!,imageUrl: " ",type:(element.type)!)
            
        }else if tableView.tag == 1
        {
            element = drink[indexPath.row]
            _item = _Item(id: element.id!,name: element.name!,cost: element.cost!,describe: element.describe!,imageUrl: " ",type:element.type!)
            
        }else if tableView.tag == 2
        {
            element = grill[indexPath.row]
            _item = _Item(id: element.id!,name: element.name!,cost: element.cost!,describe: element.describe!,imageUrl: " ",type:element.type!)
            
        }
        
        if (isSendingItem == true){
            
            performSegue(withIdentifier: "SegueSendItem", sender: nil)
        }
        
        else if (isChoosingItem == false){
            
            self.performSegue(withIdentifier: "showDetailFood", sender: Any?.self)
        } else {
            let alertController = UIAlertController(title: "Choose Item for table", message: "", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Choose", style: .default, handler: {
                alert -> Void in
                
                let txtNumber = alertController.textFields![0] as UITextField
                
                if (Int(txtNumber.text!) != nil){
                    DetailTableViewController.chosenList.append(element)
                    DetailTableViewController.numberList.append(Int(txtNumber.text!)!)
                    
                    var statistic: _Statistic = _Statistic()
                    statistic.id = self.tableID! + element.id! + txtNumber.text!
                    statistic.tableID = self.tableID
                    statistic.itemID = element.id
                    statistic.date = NSDate() as Date
                    statistic.numberOfItem = Int32(txtNumber.text!)
                    DetailTableViewController.statisticList.append(statistic)
                    self.saveStatistic(_statistic: statistic)
                }
                
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Enter Number of Item or Choosing item not success"
            }

          

            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
       
        
    }
    
    
    func saveStatistic(_statistic: _Statistic){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Statistic")
        
        
        let statistic = Statistic(context: context)

        statistic.id = _statistic.id
        statistic.itemID = _statistic.itemID
        statistic.tableID = _statistic.tableID
        statistic.date = _statistic.date as NSDate?
        statistic.numberOfItem = _statistic.numberOfItem!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()

    }
    
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "showDetailFood")
        {
            
            let detail = segue.destination as! DetailFoodViewController
            detail.ritem = _item
            detail.recieveIndex = sendIndex
            
            /*detail.ritem?.id = _item?.id
            detail.ritem?.name = _item?.name
            detail.ritem?.cost = _item?.cost
            detail.ritem?.describe = _item?.describe
            detail.ritem?.type = _item?.type
            print( detail.ritem?.name)*/
            
            
        }
        if(segue.identifier == "saddNewFood")
        {
            
            let detail = segue.destination as! AddNewFoodViewController
        }
        
        if (segue.identifier == "addNewFood"){
            let createNewItemVC = segue.destination as! AddNewFoodViewController
            print ("\(type)")
            createNewItemVC.type = type
        }
        
        if (segue.identifier == "SegueChooseItem"){
            let detailVC  = segue.destination as! DetailTableViewController
            
        }
        if (segue.identifier == "SegueSendItem"){
            let des = segue.destination as! StatisticController
            des.currItem = _item
        }
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

}
