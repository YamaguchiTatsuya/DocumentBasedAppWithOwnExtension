//
//  Content.swift
//  DocumentBasedAppWithOwnExtension
//
//  Created by TATSUYA YAMAGUCHI on 2020/01/17.
//  Copyright © 2020 TATSUYA YAMAGUCHI. All rights reserved.
//

import Cocoa

class Content: NSObject, NSSecureCoding {

    @objc dynamic var contentString = ""
    var savedDate: Date?
    
    static var supportsSecureCoding = true
    
    func encode(with coder: NSCoder) {
        
        coder.encode(contentString, forKey: "contentString")
        coder.encode(savedDate, forKey: "savedDate")
    }
    
    required init(coder: NSCoder) {
        
        super.init()
        
        contentString = coder.decodeObject(forKey: "contentString") as! String
        savedDate = coder.decodeObject(forKey: "savedDate") as? Date

    }
    
    public init(contentString: String) {
        
        self.contentString = contentString
    }
}
