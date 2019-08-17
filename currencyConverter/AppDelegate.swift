//
//  AppDelegate.swift
//  urrencyConverter
//
//  Created by kkhjmldn on 06/08/19.
//  Copyright © 2019 kkhjmldn. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let apiKey = "b6c2f87e3fmsh3fd1085ff2f13f1p1ec16bjsnbc909e30af3a"
    let viewController = ViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        let headers = ["Authorization": "Basic \(apiKey)",
            "Content-Type": "application/json",
            "X-RapidAPI-Key": apiKey]
        
        Alamofire.request("https://currency-converter5.p.rapidapi.com/currency/list?format=json",method: .get, parameters: nil,headers:headers).responseJSON { response in
            
            print(response)
            
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

