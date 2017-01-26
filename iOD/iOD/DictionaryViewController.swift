//
//  DictionaryViewController.swift
//  iOD
//
//  Created by Rafael Almeida on 21/01/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Cocoa

class DictionaryViewController: NSViewController {

    @IBOutlet weak var wordTextBox: NSTextField!
    @IBOutlet var definitionTextView: NSTextView!
    
    let dictionaryAPI = DictionaryAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        if(!checkInternetConn()) {
            DispatchQueue.main.async() {
                self.printConnErr()
            }
        }
    }
    
    @IBAction func wordTextBoxAction(_ sender: NSTextField) {
        if(checkInternetConn()) {
        if(sender.stringValue != "") {
            self.definitionTextView.string = ""
            self.definitionTextView.textStorage?.append(NSAttributedString(string: "Searching...\n\n", attributes: [NSForegroundColorAttributeName: NSColor.white]))
            
            dictionaryAPI.fetchLiteralExpression(keyword: sender.stringValue) { response, error in
                if(response.count > 0) {
                    self.definitionTextView.string = ""
                    
                    for word in response {
                        let genre = word["genre"] as String!
                        let def = word["definition"] as String!
                        
                        DispatchQueue.main.async() {
                            self.definitionTextView.textStorage?.append(NSAttributedString(string: "\(sender.stringValue) - \(genre!) \(def!)\n\n", attributes: [NSForegroundColorAttributeName: NSColor.white]))
                        }
                    }
                } else {
                    DispatchQueue.main.async() {
                        self.definitionTextView.string = ""
                        self.definitionTextView.textStorage?.append(NSAttributedString(string: "We couldn't find that :(\n\n", attributes: [NSForegroundColorAttributeName: NSColor.white]))
                    }
                }
            }
        }
        } else {
            DispatchQueue.main.async() {
                self.printConnErr()
            }
        }
    }
    
    @IBAction func exitClicked(_ sender: NSButton) {
        NSApplication.shared().terminate(self)
    }
    
    func checkInternetConn() -> Bool {
        if Reachability.isConnectedToNetwork() {
            return true
        } else {
            return false
        }
    }
    
    func printConnErr() {
        self.definitionTextView.string = ""
        self.definitionTextView.textStorage?.append(NSAttributedString(string: "Have you checked your Internet connection?\n\n", attributes: [NSForegroundColorAttributeName: NSColor.white]))
    }
}
