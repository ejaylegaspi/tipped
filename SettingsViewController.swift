//
//  SettingsViewController.swift
//  Tipped
//
//  Created by Ejay Legaspi on 8/23/17.
//  Copyright © 2017 Ejay Legaspi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var taTipSettings: UISegmentedControl!
    
    @IBAction func settingsChanged(_ sender: Any) {
        let defaults = UserDefaults.standard // Swift 3 syntax, previously NSUserDefaults.standardUserDefaults()
        defaults.set(taTipSettings.selectedSegmentIndex, forKey: "default_tip")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = UserDefaults.standard
        taTipSettings.selectedSegmentIndex = defaults.integer(forKey: "default_tip")
        //let intValue = defaults.integer(forKey: "default_tip") ?? 0
        print("view will appear")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
