//
//  Person.swift
//  Project10
//
//  Created by Görkem Gültekin on 10.02.2021.
//

import UIKit

class Person: NSObject, NSCoding {

    var name: String
    var image: String
    init(name:String, imageName: String){
        self.name = name
        self.image = imageName
    }
    required init(coder aDecoder: NSCoder){
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
}
