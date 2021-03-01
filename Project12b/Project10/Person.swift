//
//  Person.swift
//  Project10
//
//  Created by Görkem Gültekin on 10.02.2021.
//

import UIKit

class Person: NSObject, Codable {

    var name: String
    var image: String
    init(name:String, imageName: String){
        self.name = name
        self.image = imageName
        
    }
}
