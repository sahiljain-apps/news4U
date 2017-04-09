//
//  ViewController.swift
//  News4U
//
//  Created by Sahil Jain on 3/24/17.
//  Copyright © 2017 Sahil Jain. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import BTNavigationDropdownMenu


class ViewController: UITableViewController{

    
    var array = [String?](repeating: nil, count: 5)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        let parameters = [
            "source": "time",
            "sortBy": "latest",
            "apiKey": "77bac442e4664377ab6602074c8faa89",
            ]
        
        let headers = [
            "Authorization" : "Basic NTU1ZjVjZWE2ZDIyNDllZjhlMDgxYTI3NDM1YzMwZWI6MmZhMmEzYjRlNmE5NGJjNzkzNzhjZDcxMDllYTRkN2E=",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        Alamofire.request("https://newsapi.org/v1/articles?", parameters: parameters, headers: headers).responseJSON { response in
            
            
            
            if let value = response.result.value{
                
                var json = JSON(value)
                json.array
                
                for index in 0...4 {
                    self.array[index] = json["articles"][index]["title"].stringValue
                    self.tableView.reloadData();
                }

                
            
                
                // Do what you need to with JSON here!
                // The rest is all boiler plate code you'll use for API requests
                
                
            }
            
            
        }
        
        let items = ["CNN", "Time", "Business Insider", "ESPN", "Top Picks"]
        let menuView = BTNavigationDropdownMenu(title: items[0], items: items as [AnyObject])
        self.navigationItem.titleView = menuView

        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            
            if(indexPath == 1) {
                self?.tableView.reloadData()
            }
        }
        

        
        
    }
    

    
        // Do any additional setup after loading the view, typically from a nib.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // 2
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 3
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        // 4
        
        if (array[0] != nil) {
            print(indexPath.hashValue)
            cell.textLabel?.text = array[indexPath.row]
        }
        else {
        
        cell.textLabel?.text = ""
            
        }
        
        // 5
        return cell
    }


}



