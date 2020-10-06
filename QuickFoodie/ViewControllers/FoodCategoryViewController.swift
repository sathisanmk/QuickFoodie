//
//  ViewController.swift
//  QuickFoodie
//
//  Created by Sathishkumar Muthukumar on 06/10/20.
//  Copyright © 2020 Sathishkumar Muthukumar. All rights reserved.
//
import UIKit
class FoodCategoryViewController: UIViewController{
    @IBOutlet weak var foodCategoryTableview: UITableView!
    var foodCategory = [FoodCategory]()
    var expandedSectionHeaderNumber = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    var kHeaderSectionTag = 6900
    var selectedIndexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup
        
        //Registering cells, headers 
        foodCategoryTableview.register(UINib(nibName: "CategoryHeader", bundle: .main), forHeaderFooterViewReuseIdentifier: "CategoryHeader")
        foodCategoryTableview.register(UINib(nibName: "BannerHeaderView", bundle: .main), forHeaderFooterViewReuseIdentifier: "BannerHeaderView")
        foodCategoryTableview.register(UINib(nibName: "FoodListTableViewCell", bundle: .main), forCellReuseIdentifier: "FoodListTableViewCell")
        foodCategoryTableview.delegate = self
        foodCategoryTableview.dataSource = self
        addingFoodsToCategory()
    }
    func addingFoodsToCategory(){
        //Parsing JSON to our custom data type
        let decoder = JSONDecoder()
        do {
            foodCategory = try decoder.decode([FoodCategory].self, from: json)
            reloadTableview()
        } catch let error  {
            print("Parsing Failed \(error.localizedDescription)")
        }
    }
    func reloadTableview(){
        DispatchQueue.main.async {
            self.foodCategoryTableview.reloadData()
        }
    }
    
}

extension FoodCategoryViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Section 0 is Banner
        if section == 0{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BannerHeaderView") as! BannerHeaderView
            headerView.bannerItems = foodCategory[section].foodItems
            return headerView
        }else{
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CategoryHeader") as! CategoryHeader
            headerView.backgroundImage.tag = kHeaderSectionTag + section
            headerView.categoryName.text = foodCategory[section].categoryName
            headerView.tag =  section
            let headerTapGesture = UITapGestureRecognizer()
            headerTapGesture.addTarget(self, action: #selector(FoodCategoryViewController.sectionHeaderWasTouched(_:)))
            headerView.addGestureRecognizer(headerTapGesture)
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //Section 0 is Banner
        if section == 0{
            return 120
        }else{
            return 75
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.expandedSectionHeaderNumber == section) {
            return self.foodCategory[section].foodItems.count
        }else{
            return 0
        }
    }
    
    //Displaying Category Items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodListTableViewCell", for: indexPath) as! FoodListTableViewCell
        let foodItem = foodCategory[indexPath.section].foodItems[indexPath.row]
        cell.foodName.text = foodItem.foodName
        cell.foodImage.image = UIImage(named: foodItem.picture)
        if foodItem.selectedStatus == true{
            cell.containerView.alpha = 0.2
            cell.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        }else{
            cell.containerView.alpha = 1
            cell.backgroundColor = UIColor.white
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = foodCategory[indexPath.section].foodItems[indexPath.row]
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController")as! ProductDetailsViewController
        destination.selectedIndexPath = indexPath
        destination.productDetails = product
        
        //This is the callback after selected state and pop to this viewcontroller
        destination.completionBlock = { (selectedIndexPath,clickedStatus) in
            self.highlightSelectedRow(selectedIndexPath, clickedStatus)
        }
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
    
    //Create Blur effect to selected state food items
    func highlightSelectedRow(_ indexPath:IndexPath, _ clickedStatus:Bool){
        selectedIndexPath = indexPath
        foodCategory[indexPath.section].foodItems[indexPath.row].selectedStatus = clickedStatus
        foodCategoryTableview.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}


extension FoodCategoryViewController{
    //Section Header Click Action
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
        let headerView = sender.view as! CategoryHeader
        let section    = headerView.tag
        let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
        if (self.expandedSectionHeaderNumber == -1) {
            self.expandedSectionHeaderNumber = section
            tableViewExpandSection(section, imageView: eImageView!, sender)
        } else {
            if (self.expandedSectionHeaderNumber == section) {
                tableViewCollapeSection(section, imageView: eImageView!,sender)
            } else {
                let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!,sender)
                tableViewExpandSection(section, imageView: eImageView!, sender)
            }
        }
    }
    
    
    //Collapse Tableview Section
    func tableViewCollapeSection(_ section: Int, imageView: UIImageView,_ sender: UITapGestureRecognizer) {
        let sectionData = self.foodCategory[section].foodItems as NSArray
        self.expandedSectionHeaderNumber = -1;
        if (sectionData.count == 0) {
            return;
        } else {
            imageView.isHidden = true
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.foodCategoryTableview!.beginUpdates()
            self.foodCategoryTableview.reloadSections(IndexSet(integer: section), with: .automatic)
            self.foodCategoryTableview!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.foodCategoryTableview!.endUpdates()
        }
    }
    
    
    
    //Expand Tableview Section
    func tableViewExpandSection(_ section: Int, imageView: UIImageView,_ sender: UITapGestureRecognizer) {
        let sectionData = self.foodCategory[section].foodItems as NSArray
        if (sectionData.count == 0) {
            self.expandedSectionHeaderNumber = -1;
            return;
        } else {
            imageView.isHidden = false
            var indexesPath = [IndexPath]()
            for i in 0 ..< sectionData.count {
                let index = IndexPath(row: i, section: section)
                indexesPath.append(index)
            }
            self.expandedSectionHeaderNumber = section
            self.foodCategoryTableview!.beginUpdates()
            self.foodCategoryTableview.reloadSections(IndexSet(integer: section), with: .automatic)
            self.foodCategoryTableview!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
            self.foodCategoryTableview!.endUpdates()
        }
    }
}
