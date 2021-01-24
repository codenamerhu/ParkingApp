//
//  PaymentSuccessViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit

class PaymentSuccessViewController: UIViewController {

    var change = ""
    var amountpPayed = ""
    
    let customUI = CustomizeUI()
    
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiViewsConfig()
        changeLabel.text = change
    }
    
    func uiViewsConfig() {
        self.view.backgroundColor = .systemBackground
        customUI.cornerRadius(for: doneButton.layer, with: 10, on: .allSides)
    }
    
    @IBAction func done(_ sender: UIButton ) {
        self.navigationController?.modalTransitionStyle = .coverVertical
        self.navigationController?.popToRootViewController(animated: true)
        
        
        /*
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let paymentViewController = storyBoard.instantiateViewController(withIdentifier: "PayForParkingViewController") as! PayForParkingViewController
         
         paymentViewController.modalPresentationStyle = .fullScreen
         
         self.present(paymentViewController, animated: true)
         
         */
    }

}
