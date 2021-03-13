import XCTest
import SwiftUI
@testable import MNAdditions

final class BindingOnChangeAdditionTests: XCTestCase {
    struct Item {
        var title = "Default Item Title"
    }

    var item = Item()
    @State var title: String = "Default TextField.text Title"

    func testOnChangeBinding() {
        _title = State(wrappedValue: item.title)

        var body: some View {
            TextField("Item name", value: $title.onChange(update), formatter: NumberFormatter())
        }

        title = "sfsd"
        XCTAssert(item.title == "Default Item Title", "Initializing an Item failed.")
        _title.wrappedValue = "New Test Item Title"
//        _title = State(wrappedValue: "sdfs")
        XCTAssert(title == "New Test Item Title Updated Title", "Initializing the  bindingTestView.item failed.")
    }

    func update() {
        item.title = "\(title) Updated Title"
    }

    static var allTests = [("testOnChangeBinding", testOnChangeBinding),]
}
