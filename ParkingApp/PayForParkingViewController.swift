//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class PayForParkingViewController: UIViewController {

    let payment = Payment()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            let change = try payment.processPayment(for: 0, for: 50)
            print(change)
        } catch {
            print(error)
        }
    }


}

