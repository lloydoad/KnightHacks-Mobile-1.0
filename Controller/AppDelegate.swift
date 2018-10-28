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
            imageArray.append(UIImage(named: String("\(imageNamePrefix)-\(imageCount).png"))!)
        }
        return imageArray
    }
    
    func startImageLaunchAnimation(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 0.4
        imageView.startAnimating()
    }
    
    func setupBackgroundCloudsForLaunchAnimation(rootController: UIViewController) {
        var yFixedPosition: CGFloat = -50
        var cloudGroup: Int = 3
        var imageSet: Int = 0
        
        for imageCount in 0..<10 {
            yFixedPosition -= 230
            
            if (imageSet == 0) {
                backgroundImages.append(UIImageView(frame: CGRect(x: 0, y: yFixedPosition - 30, width: UIScreen.main.bounds.width, height: 170)))
                cloudGroup = 3 + (imageCount % 2)
                backgroundImages[imageCount].image = UIImage(named: "\(cloudGroup).png")
            } else if (imageSet == 1) {
                backgroundImages.append(UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width) - CGFloat(75*(Int.random(in: 2...5))), y: yFixedPosition, width: 20, height: 20)))
                backgroundImages[imageCount].image = UIImage(named: "\(Int.random(in: 1...2)).png")
            } else if (imageSet == 2) {
                backgroundImages.append(UIImageView(frame: CGRect(x: 0, y: yFixedPosition + 90, width: UIScreen.main.bounds.width, height: 100)))
                backgroundImages[imageCount].image = UIImage(named: "cloud-combo.png")
            }
            
            imageSet = (imageSet + 1) % 3
            rootController.view.addSubview(backgroundImages[imageCount])
            rootController.view.bringSubview(toFront: backgroundImages[imageCount])
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootController = UIViewController()
        window?.rootViewController = rootController
        
        let rocketImage = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.maxX)/3, y: ((UIScreen.main.bounds.maxY)/3), width: 120, height: 280))
        
        rocketImage.center.y = rootController.view.frame.size.height/2
        rocketImage.center.x = rootController.view.frame.size.width/2
        rocketImage.animationImages = rocketImages
        
        let background = UIImageView(frame: CGRect(x: 0, y: -45, width: UIScreen.main.bounds.width, height: 2000))
        background.backgroundColor = UIColor.init(red: 37, green: 9, blue: 81, a: 1)
        
        rootController.view.addSubview(rocketImage)
        rootController.view.addSubview(background)
        
        rootController.view.bringSubview(toFront: background)
        rootController.view.bringSubview(toFront: rocketImage)
        
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
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
