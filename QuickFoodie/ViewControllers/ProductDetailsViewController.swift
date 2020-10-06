//
//  ProductDetailsViewController.swift
//  QuickFoodie
//
//  Created by Sathishkumar Muthukumar on 06/10/20.
//  Copyright © 2020 Sathishkumar Muthukumar. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var buyButton: UIButton!
    var selectedIndexPath = IndexPath()
//    var selectedStatus = Bool()
    var productDetails:FoodItems?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assigning Selected item details
        productImage.image = UIImage(named: productDetails!.picture)
        productName.text = productDetails?.foodName
        productDescription.text = productDetails?.description
        buyButton.setTitle(productDetails?.selectedStatus == true ? "Selected":"Click to Select", for: .normal)
    }
    
    //back button click action
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //select button click action
    @IBAction func buyAction(_ sender: Any) {
        returnStatusToCategoryViewController()
        self.navigationController?.popViewController(animated: true)
    }
    typealias buttonCallBack = (_ IndexPath :IndexPath, _ clickedStatus:Bool) ->()

    var completionBlock:buttonCallBack?

    //Share selected status to Category ViewController, IndexPath to reload selected row
    func returnStatusToCategoryViewController() {
        guard let completion = completionBlock else {return}
        completion(selectedIndexPath, !productDetails!.selectedStatus)
    }
}
