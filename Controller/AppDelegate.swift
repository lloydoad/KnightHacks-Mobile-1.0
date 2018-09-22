//
//  AppDelegate.swift
//  KH_prototype_one
//
//  Created by Lloyd Dapaah on 8/26/18.
//  Copyright © 2018 Lloyd Dapaah. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rocketImages: [UIImage] = []
    
    // Function to create image array for launcheScreen animation.
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        
        for imageCount in 1..<total {
            let imageName = "\(imagePrefix)-\(imageCount).png"
            let image = UIImage(named: imageName)!
            imageArray.append(image)
        }
        return imageArray
    }
    
    // Function to animate array of images.
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 0.4
        imageView.startAnimating()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        // Sets rootController to HomeViewController().
        let rootController = HomeViewController()
        window?.rootViewController = UINavigationController(rootViewController: rootController)
        
        // Hide navigationBar while animation.
        rootController.navigationController?.isNavigationBarHidden = true
        
        // Rocket subView.
        let rocketImage = UIImageView(frame: CGRect(x: (rootController.view.bounds.maxX)/3
            , y: ((rootController.view.bounds.maxY)/3) - 10, width: 120, height: 280))
        rocketImage.center.x = rootController.view.frame.size.width/2
        rocketImage.animationImages = rocketImages
        
        // Background subView.
        let background = UIImageView(frame: CGRect(x: 0, y: -45, width: UIScreen.main.bounds.width, height: 2000))
        background.backgroundColor = UIColor.init(red: 37, green: 9, blue: 81, a: 1)
        
        // Background stars
        let backgroundRedStar = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 300), y: -80, width: 20, height: 20))
        backgroundRedStar.image = UIImage(named: "red-star.png")
        
        let backgroundBlueStar = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 100), y: -20, width: 20, height: 20))
        backgroundBlueStar.image = UIImage(named: "blue-star.png")
        
        // Background Clouds.
        let clouds = UIImageView(frame: CGRect(x: 0, y: -400, width: UIScreen.main.bounds.width, height: 100))
        clouds.image = UIImage(named: "cloud-combo.png")
        
        let clouds2 = UIImageView(frame: CGRect(x: 0, y: -800, width: UIScreen.main.bounds.width, height: 100))
        clouds2.image = UIImage(named: "cloud-combo.png")
        
        let clouds3 = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 350), y: -200, width: 150, height: 100))
        clouds3.image = UIImage(named: "Group 4.png")
        
        let clouds4 = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 150), y: -300, width: 150, height: 100))
        clouds4.image = UIImage(named: "Group 5.png")
        
        
        // Adding subLayers to HomeViewController().
        rootController.view.addSubview(rocketImage)
        rootController.view.addSubview(background)
        rootController.view.addSubview(backgroundRedStar)
        rootController.view.addSubview(backgroundBlueStar)
        rootController.view.addSubview(clouds)
        rootController.view.addSubview(clouds2)
        rootController.view.addSubview(clouds3)
        rootController.view.addSubview(clouds4)
        
        
        rootController.view.bringSubview(toFront: background)
        rootController.view.bringSubview(toFront: clouds)
        rootController.view.bringSubview(toFront: clouds2)
        rootController.view.bringSubview(toFront: clouds3)
        rootController.view.bringSubview(toFront: clouds4)
        rootController.view.bringSubview(toFront: rocketImage)
        rootController.view.bringSubview(toFront: backgroundRedStar)
        rootController.view.bringSubview(toFront: backgroundBlueStar)
        
        
        // Creates array of rocket images.
        rocketImages = createImageArray(total: 4, imagePrefix: "rocket")
        
        // Rocket animation: change flame size.
        animate(imageView: rocketImage, images: rocketImages)
        
        // Rocket animation: leaves screen.
        UIView.animate(withDuration: 2,
                       delay: 4,
                       
                       animations: {
                        rocketImage.layer.frame.origin.y -= 3000
        },
                       completion: nil
        )
        
        // Background fade animation.
        UIView.animate(withDuration: 2,
                       delay: 4,
                       options: UIViewAnimationOptions.curveEaseOut,
                       
                       animations: {
                        rocketImage.alpha = 0.0
                        background.alpha = 0.0
                        backgroundRedStar.alpha = 0.0
                        backgroundBlueStar.alpha = 0.0
                        clouds.alpha = 0.0
                        clouds2.alpha = 0.0
                        clouds3.alpha = 0.0
                        clouds4.alpha = 0.0
                        
        }, completion: { finished in
            background.removeFromSuperview()
            rootController.view.layer.mask?.removeFromSuperlayer()
            rootController.navigationController?.isNavigationBarHidden = false
        })
        
        // Moving Background animation.
        UIView.animate(withDuration: 5,
                       
                       animations: {
                        backgroundRedStar.layer.frame.origin.y += 300
                        backgroundBlueStar.layer.frame.origin.y += 500
                        clouds.layer.frame.origin.y += 1200
                        clouds2.layer.frame.origin.y += 500
                        clouds3.layer.frame.origin.y += 500
                        clouds4.layer.frame.origin.y += 400
        },
                       completion: { finished in
                        backgroundRedStar.removeFromSuperview()
                        backgroundBlueStar.removeFromSuperview()
                        clouds.removeFromSuperview()
                        clouds2.removeFromSuperview()
                        clouds3.removeFromSuperview()
                        clouds4.removeFromSuperview()
                        
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

