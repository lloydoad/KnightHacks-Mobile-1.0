//
//  AppDelegate.swift
//  KnightHacks
//
//  Created by Lloyd Dapaah on 6/23/19.
//  Copyright © 2019 KnightHacks. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?
    
    public var token: String = ""
    public var applicationFilters: [String:[FilterMenuModel]] = [:]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        applicationWillOverrideUI()
        updateApplicationFilters()
        setupNotifications(application)
        return true
    }
    
    func updateApplicationFilters() {
        FirebaseRequestSingleton<FilterDictionaryModel>().makeRequest(endpoint: .filters) { (filters) in
            
            guard !filters.isEmpty else {
                return
            }
            
            filters.forEach {
                if self.applicationFilters[$0.associatedView] == nil {
                    self.applicationFilters[$0.associatedView] = []
                }
                self.applicationFilters[$0.associatedView]?.append(FilterMenuModel(name: $0.name, externalImageURL: $0.imageURL))
            }
        }
    }
    
    func applicationWillOverrideUI() {
        guard let UIConfigurationList = getPlist(withName: "UIConfigurationList") else {
            return
        }
        
        if let backgroundColorHex = UIConfigurationList[ColorSchemeName.backgroundColor.rawValue] as? String, let intValue = Int(backgroundColorHex, radix: 16) {
            BACKGROUND_COLOR = UIColor(hex: intValue, alpha: 1)
        }
    }
    
    func getPlist(withName name: String) -> [String:Any]? {
        if
            let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let xml = FileManager.default.contents(atPath: path) {
            return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String:Any]
        }
        
        return nil
    }
    
    func setupNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        setupFCMNotifications()
    }
    
    
    func setupFCMNotifications() {
        Messaging.messaging().delegate = self
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                self.token = result.token
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        token = fcmToken
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

