//
//  SettingsVC.swift
//  memeinator3000
//
//  Created by Kids on 1/18/21.
//  Copyright © 2021 BytleBit. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    // MARK: IBOutlets
    
    // Main label that shows memeinated meme
    @IBOutlet weak var mainLabel: UILabel!
    // Switch to enable furryspeak
    @IBOutlet weak var furryspeakSwitch: UISwitch!
    // Switch to select casing mode: 1 -> none; 2 -> mEmE; 3 -> rAnDOm
    @IBOutlet weak var casingSelector: BetterUISegmentedControl!
    // Label for spacing; should correspond to spacingStepper
    @IBOutlet weak var spacingLabel: UILabel!
    // Stepper for spacing number
    @IBOutlet weak var spacingStepper: UIStepper!
    // Main spacing switch
    @IBOutlet weak var textSpacingSwitch: UISwitch!
    
    // MARK: IBActions
    
    // Spacing switch clicked
    @IBAction func spacingEnableChanged(_ sender: Any) {
        MemeSettings.instance.isSpaced = textSpacingSwitch.isOn
        MemeSettings.instance.stateChanged()
    }
    
    // Stepper clicked
    @IBAction func stepperChanged(_ sender: Any) {
        spacingLabel.text = "Spacing: \(Int(spacingStepper.value))"
        MemeSettings.instance.spaces = Int(spacingStepper.value)
        MemeSettings.instance.stateChanged()
    }
    
    // Casing clicked
    @IBAction func casingChanged(_ sender: Any) {
        MemeSettings.instance.selectedCase = casingSelector.selectedSegmentIndex
        MemeSettings.instance.stateChanged()
    }
    
    // Furryspeak switch clicked
    @IBAction func furryspeakEnableChanged(_ sender: Any) {
        MemeSettings.instance.isFurryspeak = furryspeakSwitch.isOn
        MemeSettings.instance.stateChanged()
    }
    
    // MARK: Functions
    
    @objc func onDidGenerateMeme() {
        mainLabel.text = MemeSettings.instance.currentGeneratedMeme
    }
    
    // MARK: Class Overrides
    override func viewDidLoad() {
        // Configure views
        spacingStepper.wraps = true
        spacingStepper.autorepeat = false
        spacingStepper.maximumValue = 5
        spacingStepper.minimumValue = 1
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onDidGenerateMeme),
                                               name: .didGenerateMeme, object: nil)
        
        // Set settings to match current state
        mainLabel.text = MemeSettings.instance.currentGeneratedMeme
        
        textSpacingSwitch.isOn = MemeSettings.instance.isSpaced
        spacingStepper.value = Double(MemeSettings.instance.spaces)
        spacingLabel.text = "Spacing: \(Int(spacingStepper.value))"
        
        casingSelector.selectedSegmentIndex = MemeSettings.instance.selectedCase
        
        furryspeakSwitch.isOn = MemeSettings.instance.isFurryspeak

    }
}
