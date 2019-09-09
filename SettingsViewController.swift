//
//  SettingsViewController.swift
//  Tip_Calculator
//
//  Created by Neha Swamy on 9/5/19.
//  Copyright © 2019 Neha Swamy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var tipController: UISegmentedControl!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    var defaults = UserDefaults.standard
    var defaultTheme = UserDefaults.standard
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.defaults = defaults
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        tipController.selectedSegmentIndex = defaults.integer(forKey: "defaultTipPercentageIndex")
        if (defaultTheme.string(forKey: "theme") == "darkTheme") {
            themeSwitch.setOn(true, animated: true)
            darkTheme()
            
        } else {
            themeSwitch.setOn(false, animated: true)
            lightTheme()
        }
        defaults.synchronize()
        defaultTheme.synchronize()
    }
    
    @IBAction func switchTheme(_ sender: Any) {
        if (themeSwitch.isOn) {
            darkTheme()
            
        } else {
            lightTheme()
        }
        defaultTheme.synchronize()
    }
   
    @IBAction func saveTipPercentage(_ sender: Any) {
        let setTipPercentageIndex = tipController.selectedSegmentIndex
        defaults.set(setTipPercentageIndex, forKey: "defaultTipPercentageIndex")
        defaults.synchronize()
    }
    
    func getDefaults() -> UserDefaults {
        return defaults
    }
    
    func getDefaultTheme() -> UserDefaults {
        return defaultTheme
    }
    
    func lightTheme() {
        self.view.backgroundColor = UIColor(red:0.82, green:1.00, blue:0.65, alpha:1.0)
        self.label1.textColor = UIColor.black
        self.label2.textColor = UIColor.black
        self.themeSwitch.backgroundColor = UIColor(red:0.82, green:1.00, blue:0.65, alpha:1.0)
        self.themeSwitch.tintColor = UIColor.white
        self.tipController.tintColor = UIColor(red:0.45, green:1.00, blue:0.42, alpha:1.0)
        self.tipController.backgroundColor = UIColor.white
        defaultTheme.set("lightTheme", forKey: "theme")
    }
    
    func darkTheme() {
        self.view.backgroundColor = UIColor.black
        self.label1.textColor = UIColor.white
        self.label2.textColor = UIColor.white
        self.themeSwitch.backgroundColor = UIColor.black
        self.themeSwitch.tintColor = UIColor(red:0.89, green:0.51, blue:1.00, alpha:1.0)
        self.tipController.tintColor = UIColor(red:0.89, green:0.51, blue:1.00, alpha:1.0)
        self.tipController.backgroundColor = UIColor.black
        defaultTheme.set("darkTheme", forKey: "theme")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
