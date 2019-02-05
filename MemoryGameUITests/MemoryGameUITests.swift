//
//  MemoryGameUITests.swift
//  MemoryGameUITests
//
//  Created on 27/11/2018.
//  Copyright © 2018 G. All rights reserved.
//

import XCTest

class MemoryGameUITests: XCTestCase {

    func testExample() {
        let app = XCUIApplication()
        app.launch()
        
        // tap on the first collection view cell on the current screen
        app.collectionViews.cells.element(boundBy:0).tap()
    }

}
