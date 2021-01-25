//
//  ViewController.swift
//  ParkingApp
//
//  Created by Rhulani Ndhlovu on 2021/01/23.
//

import UIKit
import AudioToolbox.AudioServices

enum Side {
    case rightSide
    case leftSide
    case allSides
}

class PayForParkingViewController: UIViewController {
    
    let payment = Payment()
    let mock = MockUpdata()
    let custommizeUi = CustomizeUI()
    var parkedHours = 0
    var amountDeducting = 0.00
    
    @IBOutlet weak var banner: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var amountPayingTextField: UITextField!
    @IBOutlet weak var pricingStackView: UIStackView!
    @IBOutlet weak var yButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var twoHrsView: UIView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var parkedhourBg: UIView!
    @IBOutlet weak var hrsLabel: UILabel!
    
    @IBOutlet weak var payButton: UIButton!
    
    let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
    let peek = SystemSoundID(1519)

    // 'Pop' feedback (strong boom)
    let pop = SystemSoundID(1520)

    // 'Cancelled' feedback (three sequential weak booms)
    let cancelled = SystemSoundID(1521)

    // 'Try Again' feedback (week boom then strong boom)
    let tryAgain = SystemSoundID(1102)

    // 'Failed' feedback (three sequential strong booms)
    let failed = SystemSoundID(1107)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        print("hours parked \(parkedHours)")
        NotificationCenter.default.addObserver(self, selector: #selector(PayForParkingViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PayForParkingViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.modalTransitionStyle = .coverVertical
        setup()
    }
    
    func setup(){
        configViews()
        parkedHours = mock.fakeParkedHours()
        hrsLabel.text = "\(parkedHours) hr(s)"
    }
    
    func configViews() {
        self.navigationController?.isNavigationBarHidden = true
        errorLabel.isHidden = true
        errorLabel.layer.opacity = 0.7
        
        amountPayingTextField.keyboardType = .numberPad
        
        //pricingStackView.isLayoutMarginsRelativeArrangement = true
        
        //pricingStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        custommizeUi.cornerRadius(for: banner.layer, with: 25, on: .rightSide)
        custommizeUi.shadow(for: banner.layer, with: 0.5, with: 10)

        custommizeUi.cornerRadius(for: bannerImage.layer, with: 25, on: .rightSide)
        custommizeUi.shadow(for: bannerImage.layer, with: 0.5, with: 10)
        
        custommizeUi.shadow(for: pricingStackView.layer, with: 0.5, with: 10)
        custommizeUi.cornerRadius(for: pricingStackView.layer, with: 15, on: .leftSide)
        
        custommizeUi.cornerRadius(for: twoHrsView.layer, with: 15, on: .leftSide)
        
        parkedhourBg.layer.cornerRadius = parkedhourBg.frame.width / 2
        custommizeUi.shadow(for: parkedhourBg.layer, with: 0.2, with: 6)
        
        custommizeUi.cornerRadius(for: payButton.layer, with: 10, on: .allSides)
        
        
    }
    
    @IBAction func initiatePayment(_ sender: UIButton ) {
        
        do {
            guard let amount = amountPayingTextField.text else {
                throw PaymentError.emptyFieldError
            }
            
            if amount == "" {
                AudioServicesPlaySystemSound(tryAgain)
                view.endEditing(true)
                throw PaymentError.emptyFieldError
            }
            
            if Double(amount) == nil {
                AudioServicesPlaySystemSound(tryAgain)
                view.endEditing(true)
                throw PaymentError.invalidValue
            }
            
            
            
            let change = try payment.processPayment(for: Double(amount)!, for: calculateAmountDeducting(for: Double(parkedHours)))
            amountPayingTextField.text = ""
            view.endEditing(true)
            
            AudioServicesPlaySystemSound(pop)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let successViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentSuccessViewController") as! PaymentSuccessViewController
            
            successViewController.change = change
            successViewController.amountpPayed = amount
            self.navigationController?.pushViewController(successViewController, animated: true)
            
        } catch {
            AudioServicesPlaySystemSound(tryAgain)
            print("error \(error)")
            
            if error as! PaymentError == PaymentError.emptyFieldError {
                errorLabel.text = "Amount text field cannot be left empty"
                
            }
            else if error as! PaymentError == PaymentError.invalidValue {
               errorLabel.text = "Amount entered is invalid"
               
           }
            else if error as! PaymentError == PaymentError.cannotBeZeroError {
                errorLabel.text = "Amount text field cannot be 0"
                
            }else if error as! PaymentError == PaymentError.notEnoughFundsError {
                errorLabel.text = "Amount is less than required"
                
            }
            errorLabel.isHidden = false
            view.endEditing(true)
        }
    }
    
}

extension PayForParkingViewController {
    
    func calculateAmountDeducting(for hours: Double) -> Double{
        if hours >= 9 {
            amountDeducting = 50.0
        }
        
        else if hours >= 7 {
            amountDeducting = 40.0
        }
        
        else if hours >= 5 {
            amountDeducting = 30.0
        }
        
        else if hours >= 3 {
            amountDeducting = 20
        }
        
        else {
            amountDeducting = 10
        }
        
        return amountDeducting
    }
}

extension PayForParkingViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        errorLabel.isHidden = true
        if self.yButtonConstraint.constant <= 10.0 {
            self.yButtonConstraint.constant += keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.yButtonConstraint.constant > 10.0 {
            self.yButtonConstraint.constant -= keyboardFrame.height
        }
    }

}
