//
//  FoodCategoryModel.swift
//  QuickFoodie
//
//  Created by Sathishkumar Muthukumar on 06/10/20.
//  Copyright © 2020 Sathishkumar Muthukumar. All rights reserved.
//

import Foundation

//This is the model for displaying All Data
struct FoodCategory:Decodable{
    let categoryName:String
    var foodItems:[FoodItems]
}

struct FoodItems:Decodable{
    let foodName:String
    let description:String
    let picture:String
    var selectedStatus:Bool
}

// Created JSON format string to provide all Food categories and items
let json = """
[{"categoryName":"Banner","foodItems":[{"foodName":"","description":"","picture":"banner1","selectedStatus":false},{"foodName":"","description":"","picture":"banner2","selectedStatus":false},{"foodName":"","description":"","picture":"banner3","selectedStatus":false},{"foodName":"","description":"","picture":"banner4","selectedStatus":false},{"foodName":"","description":"","picture":"banner5","selectedStatus":false},{"foodName":"","description":"","picture":"banner6","selectedStatus":false}]},


{"categoryName":"PIZZA","foodItems":[{"foodName":"Prosciutto Pizza","description":"Ah, prosciutto pizza! The epic collision of two titanic Italian inventions explodes with spectacular umami flavor, balanced here by the dreamy, delicate flavor of burrata, and the peppery zip of bright green arugula.","picture":"pizza1","selectedStatus":false},

{"foodName":"Buffalo Chicken Pizza","description":"“Buffalo-style pizza is typically a cup-and-char pepperoni pizza, one with a slim, sometimes non-existent crust coastline with ingredients out to and sometimes even over the edges, [and] a thick, airy undercarriage with little to no structural integrity that's topped by a sweet sauce and enough cheese to nearly always ...","picture":"pizza2","selectedStatus":false},

{"foodName":"Chicken Alfredo Pizza","description":"Domino's is more than just a pizza restaurant, but we can always serve up a delicious pizza to pair with this pasta crowd pleaser. With an unforgettable sauce and unique taste, Domino's Chicken Alfredo is sure to be the answer to what you've been craving.","picture":"pizza3","selectedStatus":false}]},

{"categoryName":"BURGER","foodItems":[{"foodName":"Portobello Mushroom Burgers","description":"Begin by removing the large, woody stem with your fingers and the dark gills of the mushroom by scraping them out with a spoon, leaving plenty of room for the stuffing. Pre-cook portobellos either in a skillet or in the oven, but first, cut three or four slits into the caps to help the water release quickly.","picture":"burger1","selectedStatus":false},

{"foodName":"Turkey Burgers","description":"As long as you buy high quality lean turkey, then it is healthier than an all-beef burger. The meat in the burger should be mostly white meat. As long as you choose carefully you will be able to buy healthy turkey burgers. ... Turkey burgers are healthy, but you must ensure you're choosing the healthiest burgers available.","picture":"burger2","selectedStatus":false},

{"foodName":"Wild Salmon Burgers","description":"Salmon burgers with lemon dill sauce are a nutritious protein-packed option for grilling season. When the barbecue comes out, and it’s time to grill burgers, most go with classic juicy Angus beef, but when you’re trying to get your body right for summer, it’s nice to try a lighter yet still satisfying alternative.","picture":"burger3","selectedStatus":false}]},

{"categoryName":"BEWERAGE","foodItems":[{"foodName":"Hard Seltzer Water & Sodas","description":"Hard sodas and hard seltzers are commonly categorized as flavored malt beverages even though many are produced using a fermented sugar, not derived from malt. Both segments are gaining popularity across demographics for various reasons.The beginning of the hard soda trend is often attributed to Not Your Father’s Root Beer, which became the best-selling craft beverage in the United States in 2015. New producers and flavor extensions have appeared. ","picture":"drink1","selectedStatus":false},

{"foodName":"Ready to Drink Cocktails & Wine","description":"The demand for convenience in food and beverage is at an all-time high. This has given rise to an increasing interest in ready-to-drink (RTD) or premixed, single-serve cocktails and wine. ","picture":"drink2","selectedStatus":false},

{"foodName":"Spirits & Distilled Liquors","description":"Spirits are distilled alcoholic beverages. Some of the more popular examples of spirits include tequila, rum, gin, vodka, whiskey, and bourbon. It’s hard to pinpoint the exact origin of distilled liquors, but scholars’ best guess puts the first distillation around the thirteenth century. Distillation is achieved by taking wine or other fermented fruit, plant, or starch material that has been brewed already, converting it into a vapor and then condensing it back into a liquid form.","picture":"drink3","selectedStatus":false}]},

{"categoryName":"SNACKS","foodItems":[{"foodName":"Healthy snack plate with hummus cracker bites","description":"Hard sodas and hard seltzers are commonly categorized as flavored malt beverages even though many are produced using a fermented sugar, not derived from malt. Both segments are gaining popularity across demographics for various reasons.The beginning of the hard soda trend is often attributed to Not Your Father’s Root Beer, which became the best-selling craft beverage in the United States in 2015. New producers and flavor extensions have appeared. ","picture":"snacks1","selectedStatus":false},

{"foodName":"Nut-butter dippers","description":"The demand for convenience in food and beverage is at an all-time high. This has given rise to an increasing interest in ready-to-drink (RTD) or premixed, single-serve cocktails and wine. ","picture":"snacks2","selectedStatus":false},

{"foodName":"Souped-up cereal","description":"Spirits are distilled alcoholic beverages. Some of the more popular examples of spirits include tequila, rum, gin, vodka, whiskey, and bourbon. It’s hard to pinpoint the exact origin of distilled liquors, but scholars’ best guess puts the first distillation around the thirteenth century. Distillation is achieved by taking wine or other fermented fruit, plant, or starch material that has been brewed already, converting it into a vapor and then condensing it back into a liquid form.","picture":"snacks3","selectedStatus":false}]}]
""".data(using: .utf8)!
