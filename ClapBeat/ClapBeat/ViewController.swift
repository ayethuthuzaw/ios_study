//
//  ViewController.swift
//  ClapBeat
//
//  Created by Aye Thu Thu Zaw on 2020/06/05.
//  Copyright © 2020 ALJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return repeatNumbersForPicker[row] as? String
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        repeatCount = row+1
    }

    @IBOutlet weak var PickerView: UIPickerView!

    let clapInstance = Clap()
    var repeatNumbersForPicker = NSMutableArray()
    var repeatNumbersArray: [String] = []
    var repeatCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         repeatCount = 1
               
           for i in 0 ..< 10 {
            let numberText = String(format: "%d回", i+1)
               repeatNumbersForPicker[i] = numberText
               repeatNumbersArray.append(numberText)
           }
        
        PickerView.delegate = self
        PickerView.dataSource = self
        
        
    }

    @IBAction func play(_ sender: Any) {
        clapInstance.repeatClap(count: repeatCount)
    }
    
}

