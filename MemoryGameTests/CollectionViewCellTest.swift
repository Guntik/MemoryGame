//
//  CollectionViewCellTest.swift
//  MemoryGame
//
//  Created on 05/12/2018.
//  Copyright © 2018 Galina Gainetdinova. All rights reserved.
//

import Foundation
import XCTest
@testable import MemoryGame

class CollectionViewCellTest: XCTestCase {

    let card = CollectionViewCell()
    
    override func setUp() {
        super.setUp()
    }
    
    func testCardIsUnSelected() {
        XCTAssertFalse(card.isCardSelected)
    }
    
}
