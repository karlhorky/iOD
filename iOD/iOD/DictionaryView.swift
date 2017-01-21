//
//  DictionaryView.swift
//  iOD
//
//  Created by Rafael Almeida on 21/01/17.
//  Copyright © 2017 Rafael Almeida. All rights reserved.
//

import Cocoa

class DictionaryView: NSView {
    
    @IBOutlet weak var inputDefinition: NSTextField!
    @IBOutlet var definitionTextView: NSTextView!
    
    func update(definition: String) {
        // do UI updates on the main thread
        DispatchQueue.main.async() {
            self.definitionTextView.string = definition
        }
    }
}
