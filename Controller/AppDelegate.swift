//
//  AppDelegate.swift
//  KnightHacks
//
//  Created by KnightHacks on 8/26/18.
//  Copyright © 2018 KnightHacks. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rocketImages: [UIImage] = []
    var backgroundImages: [UIImageView] = []
    
    func setupImagesForLaunchAnimation(numImages: Int, imageNamePrefix: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        
        for imageCount in 1..<numImages {
            imageArray.append(UIImage(named: String("\(imageNamePrefix)-\(imageCount)"))!)
        }
        return imageArray
    }
    
    func startImageLaunchAnimation(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 0.4
        imageView.startAnimating()
    }
    
    func setupBackgroundCloudsForLaunchAnimation(rootController: UIViewController) {
        var imageHeightStartingPoint: CGFloat = -50
        var cloudGroup: Int = 0
        var imageSet: Int = 0
        // animationBackgroundImages value depends on the animation time.
        let animationBackgroundImages: Int = 8
        
        for imageCount in 0..<animationBackgroundImages {
            imageHeightStartingPoint -= 230
            
            if (imageSet == 0) {
                backgroundImages.append(UIImageView(frame: CGRect(x: 0, y: imageHeightStartingPoint - 30, width: UIScreen.main.bounds.width, height: 170)))
                if (imageCount % 2 == 0) {
                    cloudGroup = 3
                } else {
                    cloudGroup = 4
                }
                backgroundImages[imageCount].image = UIImage(named: "\(cloudGroup)")
            } else if (imageSet == 1) {
                backgroundImages.append(UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width) - CGFloat(75*(2 + arc4random() % 6)), y: imageHeightStartingPoint, width: 20, height: 20)))
                backgroundImages[imageCount].image = UIImage(named: "\(1 + arc4random() % 2)")
            } else if (imageSet == 2) {
                backgroundImages.append(UIImageView(frame: CGRect(x: 0, y: imageHeightStartingPoint + 90, width: UIScreen.main.bounds.width, height: 100)))
                backgroundImages[imageCount].image = UIImage(named: "cloud-combo")
            }
            
            imageSet = (imageSet + 1) % 3
            rootController.view.addSubview(backgroundImages[imageCount])
            rootController.view.bringSubviewToFront(backgroundImages[imageCount])
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootController = UIViewController()
        window?.rootViewController = rootController
        
        let rocketImage = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.maxX)/3, y: ((UIScreen.main.bounds.maxY)/3), width: 120, height: 280))
        
        rocketImage.center.y = rootController.view.frame.size.height/2
        rocketImage.center.x = rootController.view.frame.size.width/2
        rocketImage.animationImages = rocketImages
        
        let background = UIImageView(frame: CGRect(x: 0, y: -45, width: UIScreen.main.bounds.width, height: 2000))
        background.backgroundColor = DARK_PURPLE_COLOR
        
        rootController.view.addSubview(rocketImage)
        rootController.view.addSubview(background)
        
        rootController.view.bringSubviewToFront(background)
        rootController.view.bringSubviewToFront(rocketImage)
        
        setupBackgroundCloudsForLaunchAnimation(rootController: rootController)
        
        rocketImages = setupImagesForLaunchAnimation(numImages: 4, imageNamePrefix: "rocket")
        
        startImageLaunchAnimation(imageView: rocketImage, images: rocketImages)
        
        UIView.animate(withDuration: 2, delay: 4, animations: {
            rocketImage.layer.frame.origin.y -= 3000
        }, completion: nil)
        
        UIView.animate(withDuration: 6, animations: {
            for i in 0..<self.backgroundImages.count {
                self.backgroundImages[i].layer.frame.origin.y += 1300
            }
        }, completion: { finished in
            rootController.present(UINavigationController(rootViewController: HomeViewController()), animated: true, completion: nil)
        })
        return true
    }
}
