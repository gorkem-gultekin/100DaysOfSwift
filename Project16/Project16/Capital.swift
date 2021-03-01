//
//  Capital.swift
//  Project16
//
//  Created by Görkem Gültekin on 22.02.2021.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    var webAddress: String
    
    init(title:String, coordinate:CLLocationCoordinate2D, info:String,webAddress:String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        self.webAddress = webAddress
    }
}
