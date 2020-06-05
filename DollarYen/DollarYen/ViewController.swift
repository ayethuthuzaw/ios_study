//
//  ViewController.swift
//  DollarYen
//
//  Created by Aye Thu Thu Zaw on 2020/06/05.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var input = Double()
    var result = Double()
    var rate = Double()
    var isYenToDollar = Bool()

    @IBOutlet weak var inputfield: UITextField!
    @IBOutlet weak var inputCurrency: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rate = 120.0
        input = 0
        result = 0

        rateLabel.text = String(format: "%.1f", rate)
        isYenToDollar = true
        inputfield.delegate = self;
    }
    
    func convert() {
        
        if isYenToDollar == true {
            result = input / rate;
            resultLabel.text = String(format: "%.2f", result)

        } else if isYenToDollar == false {
            result = input * rate;
            resultLabel.text = String(format: "%.0f", result)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        input = atof(textField.text!)
        textField.resignFirstResponder()
        self.convert()
        return true
    }
    
    @IBAction func changeCalcMethod(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0 {
            isYenToDollar = true
            inputCurrency.text = "円"
            resultCurrency.text = "ドル"

        } else if (sender as AnyObject).selectedSegmentIndex == 1 {
            isYenToDollar = false
            inputCurrency.text = "ドル"
            resultCurrency.text = "円"
        }
        self.convert()
    }
    


}

