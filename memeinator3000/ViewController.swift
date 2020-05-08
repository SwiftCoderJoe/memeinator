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
    @IBOutlet weak var shek: UIImageView!
    //Main memeinator spacing text field
    @IBOutlet weak var boi: UITextField!
    //Main memeinator spacing slider to adjust spacing between characters
    @IBOutlet weak var stepper: UIStepper!
    //memeinator spacing memeness (spacing between characters) slider
    @IBOutlet weak var datlabeltho: UILabel!
    
    @IBAction func whywouldanyonedothis(_ sender: Any) {
        pleasestop()
    }
    @IBAction func StepValChanged(_ sender: Any) {
        datlabeltho.text = "Memeness: \(Int(stepper!.value))"
    }
    
    func pleasestop() {
        shek.isHidden = false
        
        var sendnudes:String = ""
        
        for letter in boi.text! {
            sendnudes.append("\(letter)")
            for _ in 1...Int(stepper!.value) {
                sendnudes.append(" ")
            }
        }
        shek.isHidden = true
        UIPasteboard.general.string = sendnudes
    }
    
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
