//
//  AppDelegate.swift
//  iOD
//
//  Created by Rafael Almeida on 20/01/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var wordTextField: NSTextField!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        wordTextField.becomeFirstResponder()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}

