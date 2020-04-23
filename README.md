#  SwiftUI App for MacOS using CoreData

### Architecture

CoreData -> AppDelegate -> Create Persistent Container (by Default) with ViewContext // Select coredata checked when creating new project

ManagedObjectConext(from AppDelegate) -> DataModel Class via init( ) method 
```
DataModel Class:
                properties:
                            context         // ManagedObject Context
                            students        // Data fetched from CoreData
                            name            // textfield property
                methods:
                            getStudents     // Fetch all students if 'name' string is empty, else fetch names containing string in 'name' property
                            addStudent      //  Add a new Student Object in CoreData using string in 'name' property
                            deleteStudent   // Delete specific student from list
                            deleteStudents  // Delete all students if 'name' string is empty, else delete names containing string in 'name' property
                            resetTextField  // Reset value of the property 'name'
                            save            // Save the context to CoreData
```

DataModel(ManagedObjectConext) is passed to views as Environment Object inside Content View.

### How to start a core data project in SwiftUI using Xcode 11.4

1. Create A New Xcode Project -> Select MacOS Tab -> Select App

2. Give Product Name -> Select Language as Swift -> Select User Interface as SwiftUI -> Check Core Data option

3. Select Product_Name.xcdatamodeld file from Project Navigator on left side -> Create New Entity & Rename it

4. Click on Entity you created to reveal Data Model Inspector on right side -> Change codegen to Manual/None

5. Add Needed Attributes and Relationship in CoreData Model Editor

6. While inside Model Editor, Click Editor Menu on top menu bar -> Click on Create NSManagedObject Subclass (This create all the sub classes needed to use CoreData. I have combined the 2 files generated for better understanding in the file CoreData.swift) 

7. The coredata app template already filled AppDelegate.swift with necessary CoreData codes and send the view context in to ContentView.swift as Environment Value. Use `@Environment(\.managedObjectContext) var context` to access the context in Content View.

8. Add a new Swift File to Manage the Data (Here it is named DataModel.swift) -> Create a new sub class in it with `ObservableObject` as superclass.

9. Add following initialiser  and Published wapped property in the subclass
```
@Published var context: NSManagedObjectContext

init(_ moc: NSManagedObjectContext) {
    self.context = moc
}
```
10. Add all the publically required properties in the subclass with `@Published` property wrapper

11. Initialise the subclass inside Content View as EnvironmentObject. For Example: `MasterView().environmentObject(SubClass(self.context))`


### Bonus Code

This code help the user to reopen properly when closed with red close button on window

```
// AppDelegate.swift

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    ...
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            window.makeKeyAndOrderFront(nil)
        }
        return true
    }
}
```
