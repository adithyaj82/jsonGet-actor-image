//
//  ViewController.swift
//  jsonGet
//
//  Created by rajendra reddy on 3/9/18.
//  Copyright © 2018 rajendra reddy. All rights reserved.
//

import UIKit

class
ViewController:UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableview: UITableView!
    var nameArray = [String]()
   // var name = [String]()
    var URLreq :URLRequest?
    var URLSes = URLSession(configuration: URLSessionConfiguration.default)
    var URLData :URLSessionDataTask?
    override func viewDidLoad() {
        super.viewDidLoad()
        URLreq = URLRequest(url: URL(string:"http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors")!)
        URLreq?.httpMethod = "GET"
        URLData = URLSes.dataTask(with: URLreq!, completionHandler: { (data, response, error) in
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                let resultsArray = json["actors"] as! NSArray

                for i in 0..<resultsArray.count{
                    //print(appDetails["name"]!)
                    
                    let appDetails = resultsArray[i] as! NSDictionary
                    //let a = resultsArray[i] as! NSDictionary
                    //let b = a.value(forKey: "name")
                    let name = appDetails.value(forKey: "image") as! String
                    print(appDetails["image"]!)
                   // self.nameArray.append(name )
                    self.nameArray.append(name )
               // self.nameArray.append(name)
                    //
                }
            }
            catch{
                print("error")
            }
            
            OperationQueue.main.addOperation({
    self.tableview.reloadData()
            })
        })
           URLData?.resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewCell
        for i in self.nameArray{
            let str:String = i 
        
        cell.btn.setTitle( str , for: .normal)
        }
       // cell.thahir?.text = nameArray[indexPath.row]
       // cell.dobLabel.text = dobArray[indexPath.row]
        
        let imgURL = NSURL(string: nameArray[indexPath.row])

        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as URL?)!)
            cell.imgView.image = UIImage(data: data! as Data)
        }
        
        return cell
    }
    
    

    
}

