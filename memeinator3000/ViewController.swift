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
    
    @IBOutlet weak var BannerAd: GADBannerView!
    @IBOutlet weak var shek: UIImageView!
    @IBOutlet weak var boi: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var datlabeltho: UILabel!
    
    @IBAction func whywouldanyonedothis(_ sender: Any) {
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
    @IBAction func StepValChanged(_ sender: Any) {
        datlabeltho.text = "Memeness: \(Int(stepper!.value))"
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
