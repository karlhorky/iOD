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
    }
    
    @IBAction func wordTextBoxAction(_ sender: NSTextField) {

        if(sender.stringValue != "") {
            self.definitionTextView.string = ""
            
            dictionaryAPI.fetchLiteralExpression(keyword: sender.stringValue) { response, error in
                if(response.count > 0) {
                    for word in response {
                        let genre = word["genre"] as String!
                        let def = word["definition"] as String!
                        
                        DispatchQueue.main.async() {
                            
                            
                            self.definitionTextView.textStorage?.append(NSAttributedString(string: "\(sender.stringValue) - \(genre!) \(def!)\n\n", attributes: [NSForegroundColorAttributeName: NSColor.white]))
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            }
        }
    }
}
