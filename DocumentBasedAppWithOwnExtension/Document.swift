//
//  Document.swift
//  DocumentBasedAppWithOwnExtension
//
//  Created by TATSUYA YAMAGUCHI on 2020/01/17.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class Document: NSDocument {

    @objc var content = Content(contentString: "")
    
    var contentViewController: ViewController!
    
    override init() {
        super.init()
    }

    override class var autosavesInPlace: Bool {
        return true
    }

    // This enables asynchronous-writing.
    override func canAsynchronouslyWrite(to url: URL, ofType typeName: String, for saveOperation: NSDocument.SaveOperationType) -> Bool {
        return true
    }
    
    override class func canConcurrentlyReadDocuments(ofType: String) -> Bool {
        return true
    }
    
    //MARK: -
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("Document Window Controller")) as! NSWindowController
        self.addWindowController(windowController)
        
        if let contentVC = windowController.contentViewController as? ViewController {
            contentVC.representedObject = content
            contentViewController = contentVC
        }
    }

    override func read(from data: Data, ofType typeName: String) throws {
        
        let classes = [Content.self, NSDate.self]
        
        let tempContent = try NSKeyedUnarchiver.unarchivedObject(ofClasses: classes, from: data) as! Content
        self.content = tempContent
    }

    override func data(ofType typeName: String) throws -> Data {

        // make saved date here
        content.savedDate = Date()
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: content, requiringSecureCoding: true)
            return data
        } catch {
            Swift.print(error)
        }
        
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }


}

