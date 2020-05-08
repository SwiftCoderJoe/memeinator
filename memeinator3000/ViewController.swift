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
    
    // MARK: IBOutlets
    
    //Banner ad view at the bottom
    @IBOutlet weak var BannerAd: GADBannerView!
    //Single-frame processing easter egg (triggered by the memeinator spacing button)
    @IBOutlet weak var easterEgg: UIImageView!
    //Main memeinator spacing text field
    @IBOutlet weak var mainTextField: UITextField!
    //Main memeinator spacing slider to adjust spacing between characters
    @IBOutlet weak var stepper: UIStepper!
    //memeinator spacing memeness (spacing between characters) slider
    @IBOutlet weak var stepperLabel: UILabel!
    
    // MARK: IBActions
    
    //Func triggered by memeinator spacing button, calls main processing func
    @IBAction func spacingButtonCalled(_ sender: Any) {
        spacingButtonFunction()
    }
    
    //Func triggered by a change in memeinator spacing slider, only changes label, stepper value accessed directly
    @IBAction func stepperValueChanged(_ sender: Any) {
        stepperLabel.text = "Memeness: \(Int(stepper!.value))"
    }
    
    // MARK: Functions
    
    //func called by the memeinator spacing button
    func spacingButtonFunction() {
        //single-frame easter egg show
        easterEgg.isHidden = false
        
        //This variable holds the text to add to clipboard
        var workingClipboard:String = ""
        
        //iterate through each character, adding a space between
        for letter in mainTextField.text! {
            workingClipboard.append("\(letter)")
            //Add a space for each stepper value
            for _ in 1...Int(stepper!.value) {
                workingClipboard.append(" ")
            }
        }
        //unhide sing-frame easter egg
        easterEgg.isHidden = true
        //add to clipboard
        UIPasteboard.general.string = workingClipboard
    }
    
    // MARK: Class override functions
    
    override func viewDidLoad() {
        BannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        BannerAd.rootViewController = self
        BannerAd.load(GADRequest())
        stepper.wraps = true
        stepper.autorepeat = false
        stepper.maximumValue = 5
        stepper.minimumValue = 1
    }
    
}
