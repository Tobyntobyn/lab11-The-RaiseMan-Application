//
//  Document.swift
//  RaiseMan
//
//  Created by David Eyers on 24/09/17.
//

import Cocoa

class Document: NSDocument {
    
    var employees = NSMutableArray()
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "Document Window Controller") as! NSWindowController
        self.addWindowController(windowController)
        let ourViewController = windowController.contentViewController
        ourViewController?.representedObject = self
    }
    
    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    func insertObject(_ p:Person, inEmployeesAtIndex index:Int){
        NSLog("adding %@ to %@",p,employees)
        // add the inverse of the insertion action to the undo stack
        if let undo = self.undoManager {
            (undo.prepare(withInvocationTarget: self) as AnyObject).removeObjectFromEmployeesAtIndex(index)
            if !undo.isUndoing {
                undo.setActionName("Add Person")
            }
            // Add the person to the NSMutableArray
            employees.insert(p, at: index)
        }
    }
    func removeObjectFromEmployeesAtIndex(_ index:Int){
        let p = employees.object(at: index) as! Person
        NSLog("removing %@ from %@",p,employees)
        // add the inverse of the insertion action to the undo stack
        if let undo = self.undoManager {
            (undo.prepare(withInvocationTarget: self) as AnyObject).insertObject(p, inEmployeesAtIndex: index)
            if !undo.isUndoing {
                undo.setActionName("Remove Person")
            }
            // Remove the person from the NSMutableArray
            employees.removeObject(at: index)
        }
    }
    
}
