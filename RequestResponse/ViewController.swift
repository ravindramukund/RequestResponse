//
//  ViewController.swift
//  RequestResponse
//
//  Created by Ravindra Mukund on 05/04/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import UIKit
import SocketIOClientSwift

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var responseLbl:UILabel!
    @IBOutlet weak var SendBtn: UIButton!
    @IBOutlet weak var groupCountLbl:UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let result = results[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("ResultCell") as? ResultCell {
            cell.configureCell(result)
            return cell
        } else {
            let cell = ResultCell()
            cell.configureCell(result)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
        //after button is pressed
    @IBAction func SendBtnPressed(sender: AnyObject) {
        
        //start of response time
        let started = NSDate()
         print("the starting time of response is \(started) seconds")
        
        //pinging the url using the SocketIOClient
        
        let socket = SocketIOClient(socketURL: NSURL(string: "http://dev.io.spotcues.com")!, options: [.Log(false), .ForcePolling(false)])
        
        socket.on("connect") {data, ack in
            
        print("socket connected")
           
            //request dictionary
            let requestDict = [
                "p": "/channels",
                "d": ["ssid":"PramatiK2","latitude":0.0 ,"longitude":0.0,"user_Id":"56c2dcf4c5e6dfb65bac5ebb"]]
            
            //home ssid and location = ssid : Fatov, latitude:12.8938126, longitude:77.5813125
            
            //my ssid and location = ssid : "PramatiK2", latitude : 12.9380358 , longitude : 77.6055763
            
            socket.emit("q", requestDict)
        }
        socket.connect()
        socket.on("d") {data, ack in
            
        //parsing the name of spot and displaying it on the UI
            
        print("\(data)")
            
        let dct = data as NSArray;
            
        let resultDct = dct[0] as! NSDictionary;
            
        let resultsArray = resultDct["result"] as! NSArray;
            
        for resultsDict in resultsArray {
        let name = resultsDict["name"] as! String;
        print("\n\n\(name)")
            
        let imageStr = resultsDict["image"] as! String;
        
        //converting string to URL and displaying on console
        let imageString = resultsDict["image"] as! String
        let imageUrl = NSURL(string: "\(imageString)")!
        print("url = \(imageUrl)\n\n")

        let ResultsObj = Result(imageUrl:imageStr,name: name)
        self.results.append(ResultsObj);
        self.tableView.reloadData()
        
        //end of response time
        let interval = NSDate().timeIntervalSinceDate(started)
        let responseMessage = "The response time is \(interval) seconds"
        self.responseLbl.text = responseMessage
            
        }
        //display of number of groups
        print("\(self.results.count)")
        let spotInt = self.results.count
        let spotCount = "The number of spots is \(spotInt)"
        self.groupCountLbl.text = spotCount
         
        }
    }
}

