//
//  Document.swift
//  RaiseMan
//
//  Created by David Eyers on 24/09/17.
//

import Cocoa

class Document: NSDocument {

    private static var myContext = 0
    
    var employees = NSMutableArray()
    @IBOutlet weak var tableView: NSTableView!
    
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

    @IBAction func createEmployee(_ sender: AnyObject) {
        let newEmployee = Person()
        employees.add(anObject: newEmployee)
        tableView.reloadData()
    }
    @IBAction func deleteSelectedEmployees(_ sender: AnyObject) {
        let rows:NSIndexSet = tableView.selectedRowIndexes
        if rows.count == 0 {
            NSBeep()
            return
        }
        employees.removeObjects(at: rows)
        tableView.reloadData()
    }
    func numberOfRowsInTableView(aTableView:NSTableView)->NSInteger {
        NSLog("reported count \(employees.count)")
        return employees.count
    }
    func tableView(_ tableView: NSTableView, objectValueForTableColumn aTableColumn:NSTableColumn?, row rowIndex:NSInteger)->AnyObject? {
        let identifier = aTableColumn!.identifier
        
        NSLog("identifier=\(identifier)")
        
        let person:AnyObject = employees.object(at: rowIndex)
        
        return person.value(forKey: identifier)!
    }
    func tableView(_ tableView: NSTableView, setObjectValue anObject:AnyObject?, forTableColumn aTableColumn:NSTableColumn?, row rowIndex:NSInteger){
        let identifier = aTableColumn!.identifier
        let person:AnyObject = employees.object(at: rowIndex)
        person.setValue(anObject, forKey: identifier)
    }
    
}
