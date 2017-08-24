//
//  ViewController.swift
//  Tipped
//
//  Created by Ejay Legaspi on 8/22/17.
//  Copyright © 2017 Ejay Legaspi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tbBill: UITextField!
    
    @IBOutlet weak var lblTip: UILabel!
    
    @IBOutlet weak var lblTotal: UILabel!
    
    @IBOutlet weak var taTip: UISegmentedControl!
    
    @IBOutlet weak var lblSplit: UILabel!
    
    @IBOutlet weak var lblSplitInto: UILabel!
    
    @IBOutlet weak var stpSplit: UIStepper!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        taTip.selectedSegmentIndex = defaults.integer(forKey: "default_tip")
        calculateTip()
        calculateSplit()
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func splitChanged(_ sender: Any) {
        // calculate split
        calculateSplit()
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        calculateTip()
        // calculate split
        calculateSplit()
    }
    
    func formatAmount(amount:Double) -> String {
        return String(format:"$%.2f", amount)
    }
    
    func calculateTip() {
        let tip_perc = [0.15, 0.20, 0.25]
        
        if let amountString = tbBill.text?.currencyInputFormatting() {
            tbBill.text = amountString
        }
        
        let bill_value = Double(tbBill.text!.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")) ?? 0
        
        let tip_value = bill_value * tip_perc[taTip.selectedSegmentIndex]
        
        let total_value = bill_value + tip_value
        
        lblTip.text = formatAmount(amount: tip_value)
        lblTotal.text = formatAmount(amount: total_value)

    }

    
    func calculateSplit() {
        lblSplitInto.text = String(format:"%.0f", stpSplit.value)
        
        let total_value = Double(lblTotal.text!.replacingOccurrences(of: "$", with: "")) ?? 0
        
        let split_value = total_value/stpSplit.value
        
        lblSplit.text = formatAmount(amount: split_value)
    }

}

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return "$0.00"
        }
        
        return formatter.string(from: number)!
    }
}

