//
//  ViewController.swift
//  Project18
//
//  Created by Görkem Gültekin on 22.02.2021.
//

import UIKit

class ViewController: UIViewController {

    var deneme = 231231
    override func viewDidLoad() {
        super.viewDidLoad()
        print(1,2,3,4,5, separator: "-") //elemanlar arasına - koyar
        print("some message", terminator:"deneme") //terminatorün içindekini sonuna ekler
        deneme = 111111
        assert(1 == 1, "Maths failure!")
//        assert(1 == 2, "Maths failure!")
//        assert(myReallySlowMethod() == true,"the slow method returned false, which is a bad thing")
        
        for i in 1...100{
            print(deneme)
            print("Got Number \(i)")
        }
        
    }
    func myReallySlowMethod()-> Bool{
        print("deneme")
        return false
    }


}

