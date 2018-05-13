//
//  AppDelegate.swift
//  MyFirebaseApp
//
//  Created by Narumol Pugkhem on 5/7/18.
//  Copyright © 2018 Narumol Pugkhem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
//  var ref: DatabaseReference?
//  var signInproviders: [FUIAuthProvider?] = []
  //let authUI = FUIAuth.defaultAuthUI()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    let mainVC: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainVC") as UIViewController
    let navController = UINavigationController.init(rootViewController: mainVC)

    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = navController
    self.window?.makeKeyAndVisible()
    
    
    FirebaseApp.configure()
//    let authUI = FUIAuth.defaultAuthUI()
//    let signInproviders = [FUIGoogleAuth()]
//    authUI?.providers = signInproviders
   
    return true
  }

  func application(_ app: UIApplication, open url: URL,
                   options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
    
    let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String?
    if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
      return true
    }
    return false
  }

  
  func applicationDidEnterBackground(_ application: UIApplication) {

  }

  func applicationWillEnterForeground(_ application: UIApplication) {

  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

