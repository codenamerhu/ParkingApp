//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(processPayment(for: 50, for: 10))
    }
    
    func processPayment(for amountPaying:Double, for amountDeducting: Double) -> String {
        
        guard amountPaying != nil  else {
            throw 
        }
        var changeIs = 0.0
        
        changeIs = amountPaying - amountDeducting
        
        return "\(changeIs) ZAR"
    }


}

