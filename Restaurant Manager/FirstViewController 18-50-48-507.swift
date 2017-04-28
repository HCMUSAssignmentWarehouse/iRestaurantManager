//
//  FirstViewController.swift
//  Food Store Manager
//
//  Created by Nha T.Tran on 4/17/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var myTableView: UITableView!
    var label: UILabel!
    var btnAdd: UIButton!
    var btnAdd2: UIButton!

    var myTableView2: UITableView!
    var label2: UILabel!
    
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    var displayWidth: CGFloat?
    var tableHeight: CGFloat?
    var labelHeight:CGFloat?
    var x:CGFloat = 0;
    
    static var tableManager: TableService = TableService()
    static var areaManager: AreaService = AreaService()
    static var itemList: ItemService = ItemService()
    static var receiveArea: _Area?
    static var isTheFirstOpen:Bool = true
    static var addingNewTable:Bool = false;
    
    static var isEditingErea = true
    var selectedArea: _Area?
    var indexOfSelectedArea: Int?
    
    static var receiveTable: _Table?
    var newAreaToUpdate: _Area?
    var isDeletingArea = false
    var willDeleteTable = false
    var willUpdateTable = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        displayWidth = self.view.frame.width-20
        tableHeight = self.view.frame.height / 4
        labelHeight = self.view.frame.height / 15
        view.addSubview(scrollView)
        //clear coredata
        
        /*let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
        var tempList = [Area]()
        tempList = try!context.fetch(Area.fetchRequest()) as! [Area]
        
        var count:Int = 0
        
        for element in tempList{
            context.delete(element)
        }
        
        let fetch2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
        var tempList2 = [Table]()
        tempList2 = try!context.fetch(Table.fetchRequest()) as! [Table]
        
        var count2:Int = 0
        
        for element in tempList2{
            context.delete(element)
        }
        
       (UIApplication.shared.delegate as! AppDelegate).saveContext()*/

        addTable ()
        
        saveArea()
        
        updateArea()
        
       deleteTable()
        
        updateTable()
        
        showList()
        

    }
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 1200)
    }
    
    
    
    func deleteTable(){
        if (willDeleteTable == true){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
            var tableList = [Table]()
            tableList = try!context.fetch(Table.fetchRequest()) as! [Table]
            
            for element in tableList{
                if element.id == table.id{
                    context.delete(element)
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }
        }
    }
    
    
    func updateTable() {
        if (willUpdateTable == true){
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Table")
            var tableList = [Table]()
            tableList = try!context.fetch(Table.fetchRequest()) as! [Table]
            
            for element in tableList{
                if element.id == table.id{
                   
                    element.name = table.name
                    element.information = table.information
                    element.statue = table.statue!
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
            }

            
        }
    }
    
    func updateArea(){
        
        if (newAreaToUpdate != nil){
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
            var tempList = [Area]()
            tempList = try!context.fetch(Area.fetchRequest()) as! [Area]
            
            var count:Int = 0
            
            for element in tempList{
                
                if (count == indexOfSelectedArea){
                    
                    element.name = newAreaToUpdate?.name
                    element.describe = newAreaToUpdate?.describe
                    
                    var temp: _Area = _Area()
                    temp.id = element.id!
                    temp.name = newAreaToUpdate?.name!
                    temp.describe = newAreaToUpdate?.describe!
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    
                    return
                }
                
                count += 1
                
            }

            
        }
        
        
    }
    
    func addTable (){
        if (FirstViewController.addingNewTable == true){
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
            var tempList = [Area]()
            tempList = try!context.fetch(Area.fetchRequest()) as! [Area]
            
            var count:Int = 0
            
            for element in tempList{
                
                if (count == CreateNewTableViewController.indexOfArea){
                    
                    let table = Table (context: context)
                    
                    table.name = FirstViewController.receiveTable?.name
                    table.id = FirstViewController.receiveTable?.id
                    table.information = FirstViewController.receiveTable?.information
                    table.statue = (FirstViewController.receiveTable?.statue)!
                    table.area = element
                    
                    let temp = FirstViewController.areaManager.getList()[CreateNewTableViewController.indexOfArea!]
                    temp.tables.append(FirstViewController.receiveTable!)
                    
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                }
                
                count += 1

            }
            
            FirstViewController.addingNewTable = false
            
            
            
        }
    }
    
    
    func saveArea(){
        
        if (FirstViewController.receiveArea != nil)
        {
            
            FirstViewController.areaManager.addArea(area: FirstViewController.receiveArea!)
        
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
            
        
            let area = Area(context: context)
            let images = Image(context: context)
        
            area.id = String(FirstViewController.areaManager.getNumberOfArea())
            area.name = FirstViewController.receiveArea?.name
            area.describe = FirstViewController.receiveArea?.describe
            images.url = FirstViewController.receiveArea?.image?.url
        
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            FirstViewController.receiveArea = nil
            
        }

    }
    
    
    
    func showList(){
        
        //clear all view in super view
        for v in scrollView.subviews{
            v.removeFromSuperview()
        }
        
        if (isDeletingArea == true || newAreaToUpdate != nil || FirstViewController.isTheFirstOpen == true || willDeleteTable == true || willUpdateTable == true){
            
            //reset List
            FirstViewController.areaManager = AreaService()
            
            //show
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
            var tempList = [Area]()
            tempList = try!context.fetch(Area.fetchRequest()) as! [Area]
            
            
            for element in tempList{
                
                var area: _Area = _Area()
                area.id = element.id
                area.name = element.name
                area.describe = element.describe
                
                let url = element.images?.url
                let image = _Image(id: "",url: "\(url)",itemID:"")
                area.image = image
                
                var tempTable = [Table]()
                var tableList = [_Table]()

                tempTable = try!context.fetch(Table.fetchRequest()) as! [Table]
                
                for subElement in tempTable{
                
                    if (subElement.area?.id == element.id){
                    
                        var table : _Table = _Table()
                        table.id = subElement.id
                        
                        let x = subElement.name
                        
                        table.name = subElement.name
                        table.information = subElement.information
                        table.area = area
                        table.statue = subElement.statue
                        tableList.append(table)
                    }
                    
                }
                
                area.tables = tableList
                FirstViewController.areaManager.addArea(area: area)
            }
            
            
            FirstViewController.isTheFirstOpen = false
        
        }
        
        let y = FirstViewController.areaManager.getNumberOfArea()
        print ("\(y)")
        
        x = 0
        
        while(Int(x) < FirstViewController.areaManager.getNumberOfArea()){
            
            
            var labelMarginTop:CGFloat?
            var btnMarginTop:CGFloat?
            var tblMarginTop:CGFloat?
            var imageMarginTop: CGFloat
            
            if (x == 0){
                
                imageMarginTop = 10 + x * (tableHeight! + labelHeight!)
                labelMarginTop = x * (tableHeight! + labelHeight!)
                btnMarginTop = 10 + x * tableHeight! + x * labelHeight!
                tblMarginTop = (x + 1) * labelHeight! + x * tableHeight!
            }else{
                imageMarginTop = 30 * x + x * (tableHeight! + labelHeight!)
                labelMarginTop = 30 * x + x * (tableHeight! + labelHeight!)
                btnMarginTop = 30 * x + x * tableHeight! + x * labelHeight!
                tblMarginTop = 30 * x + (x + 1) * labelHeight! + x * tableHeight!
            }
            
            
            var imageview:UIImageView!
            imageview = UIImageView(frame:CGRect(x:10,y: imageMarginTop,width:40,height:40))
            imageview.image = UIImage(named:"home.png")
            scrollView.addSubview(imageview)

            
            label2 = UILabel(frame: CGRect(x: 60, y: labelMarginTop! , width: displayWidth!,  height: labelHeight!))
            label2.text = FirstViewController.areaManager.getList()[Int(x)].name
            label2.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold)
            label2.textColor = UIColor(red:211/255,green:80/255,blue:0/255, alpha:1.0)
            label2.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            label2.addGestureRecognizer(tapGesture)

            let holdToDelete = UILongPressGestureRecognizer(target: self,action:#selector(self.longPressDelete))
            holdToDelete.minimumPressDuration = 1.00;
            label2.addGestureRecognizer(holdToDelete);

            
            scrollView.addSubview(label2)
            
            
            btnAdd2 = UIButton(frame: CGRect(x: displayWidth! * 2 / 3 + 20, y: btnMarginTop!, width: displayWidth! / 3 - 20, height: labelHeight! * 3 / 4))
            btnAdd2.setTitle("+", for: .normal)
            btnAdd2.setTitleColor(UIColor.white, for: .normal)
            btnAdd2.addTarget(self, action: #selector(self.action), for: .touchUpInside)
            btnAdd2.backgroundColor = UIColor(red:26/255, green:82/255, blue:118/255, alpha:1)
            btnAdd2.layer.borderWidth = 1
            btnAdd2.tag = Int(x)
            scrollView.addSubview(btnAdd2)
            
            
            
            myTableView2 = UITableView(frame: CGRect(x: 10, y: tblMarginTop!, width: displayWidth!, height: tableHeight!))
            myTableView2.dataSource = self
            myTableView2.delegate = self
            myTableView2.layer.borderWidth = 1
            myTableView2.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")

            myTableView2.layer.borderColor = UIColor(red:121/255,green:125/255,blue:127/255, alpha:1.0).cgColor
            myTableView2.backgroundColor = UIColor(red:127/255,green:140/255,blue:141/255, alpha:1.0)
            myTableView2.tag = Int(x)
            
            let numberOfSections2 = self.myTableView2.numberOfSections
            let numberOfRows2 = self.myTableView2.numberOfRows(inSection: numberOfSections2)
            
            let scrollOptionsButton2 = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: "showScrollOptions")
            self.navigationItem.rightBarButtonItem = scrollOptionsButton2
            
            
            let indexPath2 = IndexPath(row: 0 , section: numberOfSections2-1)
            self.myTableView2.scrollToRow(at: indexPath2, at: UITableViewScrollPosition.middle, animated: true)
            
            scrollView.addSubview(myTableView2)
            

            
            x += 1
            
        }

    }
    
    func longPressDelete(sender: UILongPressGestureRecognizer) {
        
        let refreshAlert = UIAlertController(title: "Delete Area", message: "Are you sure want to delete this area?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            self.isDeletingArea = true
            
            guard let text = (sender.view as? UILabel)?.text else { return }
            
            let index = FirstViewController.areaManager.searchArea(name: text)

            self.deleteArea(index: index)
            
            
        }))
        
        
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }

    
    func deleteArea(index: Int){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Area")
        var areaList = [Area]()
        areaList = try!context.fetch(Area.fetchRequest()) as! [Area]
        
        var count:Int = 0
        for element in areaList{
            if count == index{
                context.delete(element)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            count += 1
        }
        
        var x = index
        showList()

        
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        guard let text = (sender.view as? UILabel)?.text else { return }
        
        let index = FirstViewController.areaManager.searchArea(name: text)

        selectedArea =  FirstViewController.areaManager.getList()[index]
        indexOfSelectedArea = index
        performSegue(withIdentifier: "SegueDetailAreaID", sender: nil)

    }
    
    @objc func action(sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
    
        CreateNewTableViewController.indexOfArea = sender.tag
        performSegue(withIdentifier: "SegueCreateNewTable", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var tag:Int = 0
        var temp:Int?
        while (tag < FirstViewController.areaManager.getList().count){
            if (tableView.tag == tag){
                temp = FirstViewController.areaManager.getList()[tag].tables.count
                if (temp! < 1){
                    return 1
                }
                return temp!
            }
            tag += 1
        }
        

        return 1
    }
    
     var table:_Table = _Table()
    // show detail table
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var tag:Int = 0
        while (tag < FirstViewController.areaManager.getList().count)
        {
             if (tableView.tag == tag && FirstViewController.areaManager.getList()[tag].tables.count > 0)
             {
                
               
                table = FirstViewController.areaManager.getList()[tag].tables[indexPath.row]
                print(table.id)
                self.performSegue(withIdentifier: "showDetailTable", sender: Any?.self)
                return
            }
            tag = tag + 1
        }
       
        
        
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "showDetailTable")
       {
            
        let detail = segue.destination as! DetailTableViewController
            detail.rtable = table
            
        }
        else if (segue.identifier == "SegueDetailAreaID") {
            let detailAreaVC = segue.destination as! DetailAreaController
            
            detailAreaVC.currArea = selectedArea
            detailAreaVC.indexOfArea = indexOfSelectedArea
            
        }
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.layer.shadowColor = UIColor(red:208/255,green:236/255,blue:231/255, alpha:1.0).cgColor

        cell.layer.borderWidth = 0.5
        
        cell.layer.borderColor = UIColor(red:19/255,green:141/255,blue:117/255, alpha:1.0).cgColor
        cell.textLabel?.text = "no table"
       cell.backgroundColor =  UIColor(red:127/255,green:140/255,blue:141/255, alpha:1.0)
        var tag:Int = 0
        while (tag < FirstViewController.areaManager.getList().count){
            
            if (tableView.tag == tag && FirstViewController.areaManager.getList()[tag].tables.count > 0){
                var table:_Table = _Table()
                table = FirstViewController.areaManager.getList()[tag].tables[indexPath.row]
                if (table.statue == true){
                    cell.backgroundColor = UIColor(red:88/255,green:214/255,blue:141/255, alpha:1.0)
                }
                else{
                    cell.backgroundColor = UIColor(red:245/255,green:176/255,blue:65/255, alpha:1.0)
                }

                var imageview:UIImageView!
                imageview = UIImageView(frame:CGRect(x:10,y:8,width:56,height:56))
                
                
                imageview.image = UIImage(named: "table.png")
                cell.addSubview(imageview)
                
                cell.textLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold)
                cell.textLabel?.textColor = UIColor(red:26/255,green:82/255,blue:118/255, alpha:1.0)
                cell.textLabel?.text = table.name
                cell.textLabel?.textAlignment = .center
               
                }
            tag += 1
        }
        
        
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

