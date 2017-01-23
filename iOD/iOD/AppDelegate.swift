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
    
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.action = #selector(self.togglePopover(_:))
        
        popover.contentViewController = DictionaryViewController(nibName: "DictionaryViewController", bundle: nil)
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }


}

