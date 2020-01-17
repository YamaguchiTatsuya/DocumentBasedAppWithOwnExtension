//
//  ViewController.swift
//  DocumentBasedAppWithOwnExtension
//
//  Created by TATSUYA YAMAGUCHI on 2020/01/17.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextViewDelegate {

    @IBOutlet weak var textField:NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        
        if let sd = document?.content.savedDate {
            textField.stringValue = sd.description
        }
    }
    
    override var representedObject: Any? {
        didSet {
            for child in children {
                child.representedObject = representedObject
            }
        }
    }

    //↓different from Apple's sample code
    weak var document: Document? {
        if let doc = self.view.window?.windowController?.document as? Document {
            return doc
        }
        return nil
    }

    // MARK: - NSTextViewDelegate
    
    func textDidBeginEditing(_ notification: Notification) {
        document?.objectDidBeginEditing(self)
    }
    
    func textDidEndEditing(_ notification: Notification) {
        document?.objectDidEndEditing(self)
    }
}

