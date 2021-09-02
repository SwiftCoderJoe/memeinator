//
//  ViewController.swift
//  memeinator3000
//
//  Created by Joey C on 7/28/18.
//  Copyright © 2018 BytleBit. All rights reserved.
//
import UIKit
import GoogleMobileAds
import FirebaseAnalytics

class InputVC: UIViewController {
    
    // MARK: Global Vars & Constants
    // This holds the text that gets copied to clipboard when the copy button is clicked
    var workingClipboard: String = ""
    
    
    // MARK: IBOutlets
    
    // Banner ad view at the bottom
    @IBOutlet weak var bannerAd: GADBannerView!
    // Main memeinator spacing text field
    @IBOutlet weak var mainTextField: UITextField!
    // Label for button, shows either "copy to clipboard", or "copied!"
    @IBOutlet weak var buttonLabel: UILabel!
    // Button, disabled when the label shows "copied!"
    @IBOutlet weak var copyButton: UIButton!
    // Final meme label which should reflect workingClipboard
    @IBOutlet weak var finalMemeLabel: UILabel!
    
    // MARK: IBActions
    
    
    // Func triggered by memeinator spacing button, calls main processing func
    @IBAction func spacingButtonCalled(_ sender: Any) {
        spacingButtonFunction()
    }
    
    
    // Called whenever the text input's value changes
    @IBAction func textInputValueChanged(_ sender: Any) {
        MemeSettings.instance.setInputAndChangeState(input: mainTextField.text!)
    }
    
    @IBAction func returnFromUnwindActions(_ unwindSegue: UIStoryboardSegue) {
    }
    
    
    // MARK: Functions
    
    // Func called by the memeinator spacing button
    func spacingButtonFunction() {
        // Log event to Analytics
        Analytics.logEvent("spacing_button_pressed", parameters: [
            "spacing_selected": MemeSettings.instance.isSpaced,
            "spaces": MemeSettings.instance.spaces,
            "casing_selected": MemeSettings.instance.spaces,
            "furryspeak_selected": MemeSettings.instance.isFurryspeak
        ])
        // Add to clipboard
        UIPasteboard.general.string = MemeSettings.instance.currentGeneratedMeme
        
        // Edit the button to show COPIED
        buttonLabel.text = "COPIED!"
        copyButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.resetButtonState()
        })
    }
    
    func resetButtonState() {
        buttonLabel.text = "COPY TO CLIPBOARD"
        copyButton.isEnabled = true
    }
    
    @objc func onDidGenerateMeme() {
        finalMemeLabel.text = MemeSettings.instance.currentGeneratedMeme
    }
    
    // MARK: Class override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        // Use this during development, please!
        // BannerAd.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        // Use this in production, please!
        BannerAd.adUnitID = "ca-app-pub-4026820850636406/5034986759"
        
        BannerAd.rootViewController = self
        BannerAd.load(GADRequest())
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidGenerateMeme), name: .didGenerateMeme, object: nil)
        
    }
    
}
