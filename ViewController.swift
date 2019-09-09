//
//  ViewController.swift
//  Tip_Calculator
//
//  Created by Neha Swamy on 9/5/19.
//  Copyright © 2019 Neha Swamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var enterField: UITextField!
    @IBOutlet weak var tipController: UISegmentedControl!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    let locale = String(Locale.current.regionCode!)
    let defaults = SettingsViewController().getDefaults()
    let defaultTheme = SettingsViewController().getDefaultTheme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setLabels()
        enterField.keyboardType = UIKeyboardType.decimalPad
        enterField.keyboardAppearance = UIKeyboardAppearance.default
        enterField.becomeFirstResponder()
        self.title = "Tip Calculator"
        defaults.synchronize()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
        enterField.resignFirstResponder()
    }
    
    func setLabels() {
        enterField.text = getCurrency()
        tipLabel.text = getCurrency() + "0.00"
        totalLabel.text = getCurrency() + "0.00"
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        var enter = ""
        let text: String! = enterField.text
        for char in text {
            if (char == "$" || char == "£") {
                continue
                
            } else {
                enter.append(char)
            }
        }
        let bill = Double(enter) ?? 0
        let tipPercentageIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        if (tipPercentageIndex != 0) {
            tipController.selectedSegmentIndex = tipPercentageIndex - 1
            defaults.set(tipPercentageIndex, forKey: "defaultTipPercentageIndex")
            defaults.synchronize()
        }
        
        let tipPercentages = [0.15, 0.18, 0.2]
        let tipPercentage = tipPercentages[tipController.selectedSegmentIndex]
        
        let tip = bill * tipPercentage
        let total = bill + tip
        
        tipLabel.text = getCurrency() + String(format: "%.2f", tip)
        totalLabel.text = getCurrency() + String(format: "%.2f", total)
    }
    
    func getCurrency() -> String {
        var currency = ""
        if (locale == "US" || locale == "CA" || locale == "AU") {
            currency = "$"
            
        } else if (locale == "GB") {
            currency = "£"
            
        } else if (locale == "IN") {
            currency = "₹"
        }
        return currency
    }
    
    func setTheme() {
        let theme = defaultTheme.string(forKey: "theme")
        
        if (theme == "lightTheme") {
            self.view.backgroundColor = UIColor(red:0.82, green:1.00, blue:0.65, alpha:1.0)
            self.tipLabel.textColor = UIColor.gray
            self.tipLabel.backgroundColor = UIColor(red:0.62, green:1.00, blue:0.43, alpha:1.0)
            self.totalLabel.textColor = UIColor.black
            self.totalLabel.backgroundColor = UIColor(red:0.62, green:1.00, blue:0.43, alpha:1.0)
            self.tipController.tintColor = UIColor(red:0.45, green:1.00, blue:0.42, alpha:1.0)
            self.tipController.backgroundColor = UIColor.white
            self.enterField.textColor = UIColor.black
            self.enterField.backgroundColor = UIColor(red:0.82, green:1.00, blue:0.65, alpha:1.0)
            enterField.layer.borderColor = UIColor(red:0.82, green:1.00, blue:0.65, alpha:1.0).cgColor
            
        } else {
            self.view.backgroundColor = UIColor.black
            self.tipLabel.textColor = UIColor.white
            self.tipLabel.backgroundColor = UIColor(red:0.89, green:0.51, blue:1.00, alpha:1.0)
            self.totalLabel.textColor = UIColor.white
            self.totalLabel.backgroundColor = UIColor(red:0.89, green:0.51, blue:1.00, alpha:1.0)
            self.tipController.tintColor = UIColor(red:0.89, green:0.51, blue:1.00, alpha:1.0)
            self.tipController.backgroundColor = UIColor.black
            self.enterField.textColor = UIColor.white
            self.enterField.backgroundColor = UIColor.black
            enterField.layer.borderColor = UIColor.black.cgColor
        }
    }
}

