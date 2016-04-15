//
//  ResultCell.swift
//  RequestResponse
//
//  Created by Ravindra Mukund on 13/04/16.
//  Copyright © 2016 Ravindra Mukund. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var spotImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(result:Result) {
        nameLbl.text = result.name
        
//     
//        converting string to URL and displaying on console
        
//        let imageString = resultsDict["image"] as! String!
//        let imageUrl = NSURL(string: "\(imageString)")!
//        print("url = \(imageUrl)\n\n")
        
        
    let url = NSURL(string:"\(Result.imageUrl)")
    let data = NSData(contentsOfURL: url!)
    spotImage.image = UIImage(data: data!)
        
        
    }
}
