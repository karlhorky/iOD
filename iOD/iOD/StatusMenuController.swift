//
//  StatusMenuController.swift
//  iOD
//
//  Created by Rafael Almeida on 21/01/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    let dictionaryAPI = DictionaryAPI()
    
    @IBAction func updateClicked(_ sender: NSMenuItem) {
        let keyword = "sentido"
        
        dictionaryAPI.fetchLiteralExpression(keyword: keyword) { response, error in
            if(response.count > 0) {
                for word in response {
                    let genre = word["genre"] as String!
                    let def = word["definition"] as String!
                    
                    print("\(keyword) - (\(genre!)) \(def!)")
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
