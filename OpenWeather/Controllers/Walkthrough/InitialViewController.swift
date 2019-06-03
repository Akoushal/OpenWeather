//
//  InitialViewController.swift
//  OpenWeather
//
//  Created by Koushal, KumarAjitesh on 2019/06/01.
//  Copyright © 2019 Koushal, KumarAjitesh. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    @IBOutlet weak var gifImgView: UIImageView?
    
    lazy var onboardingPages: [OnboardPage] = {
        let pageOne = OnboardPage(title: "Welcome",
                                  imageName: "",
                                  description: "OpenWeather is an easy to use productivity app designed to keep you updated with Weather Conditions all over the globe.")
        
        let pageTwo = OnboardPage(title: "Location Access",
                                    imageName: "onboarding3",
                                    description: "This app requires access to your location for best results !!")
        
        let pageThree = OnboardPage(title: "Forecast",
                                   imageName: "",
                                   description: "Based on your location, you can see weather details such as temperature and weather conditions !!")
        
        let pageFour = OnboardPage(title: "Detailed Forecast",
                                   imageName: "",
                                   description: "You can also see detailed forecast such as Wind Speed, Cloudiness etc !!",
                                   advanceButtonTitle: "Done")
        
        return [pageOne, pageTwo, pageThree, pageFour]
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImgView?.loadGif(name: "source")
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func showOnboardingScreensButtonTapped(_ sender: Any) {
        let tintColor = UIColor(red: 1.00, green: 0.52, blue: 0.40, alpha: 1.00)
        let titleColor = UIColor(red: 1.00, green: 0.35, blue: 0.43, alpha: 1.00)
        let boldTitleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        let mediumTextFont = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        let appearanceConfiguration = OnboardViewController.AppearanceConfiguration(tintColor: tintColor,
                                                                                    titleColor: titleColor,
                                                                                    textColor: .white,
                                                                                    backgroundColor: .black,
                                                                                    titleFont: boldTitleFont,
                                                                                    textFont: mediumTextFont)
        let onboardingVC = OnboardViewController(pageItems: onboardingPages,
                                                 appearanceConfiguration: appearanceConfiguration)
        onboardingVC.delegate = self
        onboardingVC.modalPresentationStyle = .formSheet
        onboardingVC.presentFrom(self, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeSegue" {
            _ = segue.destination as! HomeViewController
        }
    }
}

extension InitialViewController: WalkthroughCompleteDelegate {
    func walkthroughComplete() {
        performSegue(withIdentifier: "homeSegue", sender: nil)
    }
}
