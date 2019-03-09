//
//  Square.swift
//  BigCaro
//
//  Created by Le Van Vu on 4/7/16.
//  Copyright © 2016 thaotruong. All rights reserved.
//

import UIKit

class Square: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setSymbol(value: String){
        if value == "x"{
            image.image = UIImage(named: "icon_x")
        }
        else{
            if value == "o"{
                image.image = UIImage(named: "icon_o")
            }
            else{
                image.image = nil
            }
        }
    }
    
    func isEmpty() -> Bool{
        return image.image == nil
    }
}
