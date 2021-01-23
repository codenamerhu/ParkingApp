//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class PayForParkingViewController: UIViewController {
    
    let payment = Payment()
    let parkedHours = MockUpdata()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        do {
            let change = try payment.processPayment(for: 0, for: 50)
            print(change)
        } catch {
            print(error)
        } */
    }

}

