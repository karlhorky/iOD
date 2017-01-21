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
    @IBOutlet weak var dictionaryView: DictionaryView!
    
    var dictionaryMenuItem: NSMenuItem!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    let dictionaryAPI = DictionaryAPI()
    
    @IBAction func textFieldAction(_ sender: NSTextField) {
        if(sender.stringValue != "") {
            dictionaryAPI.fetchLiteralExpression(keyword: sender.stringValue) { response, error in
                if(response.count > 0) {
                    for word in response {
                        let genre = word["genre"] as String!
                        let def = word["definition"] as String!
                        
                        self.dictionaryView.update(definition: "\(sender.stringValue) - \(genre!) \(def!)")
                    }
                } else {
                    print(error!.localizedDescription)
                }
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
        
        dictionaryMenuItem = statusMenu.item(withTitle: "Item")
        dictionaryMenuItem.view = dictionaryView
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}
