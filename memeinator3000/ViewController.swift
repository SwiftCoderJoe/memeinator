//
//  ViewController.swift
//  memeinator3000
//
//  Created by Joey C on 7/28/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//
import UIKit
import GoogleMobileAds
class ViewController: UIViewController {
    // MARK: Global Vars & Constants
    // This holds the text that gets copied to clipboard when the copy button is clicked
    var workingClipboard: String = ""
    
    // MARK: IBOutlets
    
    //Banner ad view at the bottom
    @IBOutlet weak var BannerAd: GADBannerView!
    //Single-frame processing easter egg (triggered by the memeinator spacing button)
    @IBOutlet weak var easterEgg: UIImageView!
    //Main memeinator spacing text field
    @IBOutlet weak var mainTextField: UITextField!
    //Main memeinator spacing slider to adjust spacing between characters
    @IBOutlet weak var stepper: UIStepper!
    //Label for button, shows either "copy to clipboard", or "copied!"
    @IBOutlet weak var buttonLabel: UILabel!
    //Button, disabled when the label shows "copied!"
    @IBOutlet weak var copyButton: UIButton!
    //memeinator spacing memeness (spacing between characters) slider
    @IBOutlet weak var stepperLabel: UILabel!
    // Spacing memeinator enable switch
    @IBOutlet weak var spaceEnableSwitch: UISwitch!
    // Spacing memeinator enabled label, should read "Enabled" or "Disabled" depending on switch state
    @IBOutlet weak var spaceEnableLabel: UILabel!
    // Final meme label which should reflect workingClipboard
    @IBOutlet weak var finalMemeLabel: UILabel!
    
    // MARK: IBActions
    
    // Func triggered when the spacing memeinator is disabled or enabled
    @IBAction func spacingEnableChanged(_ sender: Any) {
        stateChanged()
        spaceEnableLabel.text = "S p a c e d text: " + ( spaceEnableSwitch.isOn ? "Enabled" : "Disabled")
    }
    //Func triggered by memeinator spacing button, calls main processing func
    @IBAction func spacingButtonCalled(_ sender: Any) {
        stateChanged()
        spacingButtonFunction()
    }
    
    //Func triggered by a change in memeinator spacing slider, only changes label, stepper value accessed directly
    @IBAction func stepperValueChanged(_ sender: Any) {
        stateChanged()
        stepperLabel.text = "Spacing: \(Int(stepper!.value))"
    }
    
    // Called whenever the text input's value changes
    @IBAction func textInputValueChanged(_ sender: Any) {
        stateChanged()
    }
    
    // MARK: Functions
    
    // Func called every time any memeinator option is changed
    func stateChanged() {
        // This variable holds the text to add to clipboard
        workingClipboard = ""
        
        // Iterate through each character
        for letter in mainTextField.text! {
            
            workingClipboard.append("\(letter)")
            
            // Add a space for each stepper value if spacing is enabled
            if spaceEnableSwitch.isOn {
                for _ in 1...Int(stepper!.value) {
                    workingClipboard.append(" ")
                }
            }
            
        }
        
        // If spacing is enabled and there is text in the textbox, delete the last space(s)
        if spaceEnableSwitch.isOn && workingClipboard != "" {
            workingClipboard = workingClipboard[0..<(workingClipboard.count - Int(stepper.value))]
        }
        
        // Finally, update the finalMemeLabel to reflect the new workingClipboard
        finalMemeLabel.text = workingClipboard
    }
    
    //func called by the memeinator spacing button
    func spacingButtonFunction() {
        //single-frame easter egg show
        easterEgg.isHidden = false
        //add to clipboard
        UIPasteboard.general.string = workingClipboard
        buttonLabel.text = "COPIED!"
        copyButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.resetButtonState()
        })
        //unhide single-frame easter egg
        easterEgg.isHidden = true
    }
    
    func resetButtonState() {
        buttonLabel.text = "COPY TO CLIPBOARD"
        copyButton.isEnabled = true
    }
    
    // MARK: Class override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        BannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerAd.rootViewController = self
        BannerAd.load(GADRequest())
        stepper.wraps = true
        stepper.autorepeat = false
        stepper.maximumValue = 5
        stepper.minimumValue = 1
    }
    
}
