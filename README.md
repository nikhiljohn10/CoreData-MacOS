#  SwiftUI App for MacOS using CoreData

### Architecture

CoreData -> AppDelegate -> Create Persistent Container (by Default) with ViewContext // Select coredata checked when creating new project

ManagedObjectConext(from AppDelegate) -> Model Class via init( ) method  -> EnvironmentObject -> ContentView

```
Model Class:
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


### How to start a core data project in SwiftUI using Xcode 11.4

1. Create A New Xcode Project -> Select MacOS Tab -> Select App

2. Give Product Name -> Select Language as Swift -> Select User Interface as SwiftUI -> Check Core Data option

3. Select Product_Name.xcdatamodeld file from Project Navigator on left side -> Create New Entity & Rename it

4. Add Needed Attributes and Relationship in CoreData Model Editor

5. The coredata app template already filled AppDelegate.swift with necessary CoreData codes. But we need to inject Model Object in to content view instead of context. Make the following changes in AppDelegate.swift:
```
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var model: Model!
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    
        model = Model(persistentContainer.viewContext)
        let contentView = ContentView().environmentObject(model)

        ...
    
    }
}
```
6. Add a new Swift File to Manage the Data (Here it is named Model.swift) -> Create a new sub class in it with `ObservableObject` as superclass.

7. Add following initialiser  and Published wapped property in the subclass (Here, the subclass is `final class Model` )
```
final class Model: ObservableObject {
    @Published var context: NSManagedObjectContext

    init(_ moc: NSManagedObjectContext) {
        self.context = moc
    }
}
```
8. Add `@Published` property wrapper will all the publically required properties in the subclass

9. Use `@EnvironmentObject var model: Model` to access the CoreData Object in Model class.

### TroubleShoot

1. Unable to access model inside sheet

Solution: Inject model in to  Modal View (`ModalView(showModal: self.$showModal)
.environmentObject(self.model)`

2. The autocompletion is not working

Solution: Go to preference -> Location tab -> Access Derived folder location and Delete the `DerivedData` folder and restart Xcode

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
