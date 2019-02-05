//
//  MemoryGameTests.swift
//  MemoryGameTests
//
//  Created on 27/11/2018.
//  Copyright © 2018 G. All rights reserved.
//

import XCTest
@testable import MemoryGame

class MemoryGameTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as? ViewController

        XCTAssertNotNil(viewController.view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //creating testing Image
    func createTestImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let color = UIColor.yellow
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func testCollection() {
        let fakeImagesName = ["FakeA", "FakeB", "FakeC", "FakeD", "FakeE", "FakeF", "FakeG", "FakeH", "FakeBack", "FakeAA", "FakeBB"]
        
        let array = viewController.cardsFunctionality.makeArray(array: fakeImagesName)
        var images = [UIImage]()
        var index = 0
        while index < array.count {
            let image = createTestImage()
            images.append(image)
            index += 1
        }
        viewController.cardsFunctionality.arrayString = array
        
        XCTAssertTrue(array.count == 16)
        
        let cardsArray = viewController.cardsFunctionality.CardsArray(array: images, stringArray: array)
        
        viewController.cards = cardsArray
        
        viewController.collectionView.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))

        XCTAssertTrue(viewController.cards.count == array.count)
    }
    
    
    func testCollectionView() {
        XCTAssertNotNil(viewController.collectionView)
    }
    
    func testItemsCollectionView() {
        XCTAssertNotNil(viewController.cards)
    }
    
    func testCollectionViewDataSource() {
        XCTAssertNotNil(viewController.collectionView.dataSource)
    }
    
    func testCollectionViewDelegate() {
        XCTAssertNotNil(viewController.collectionView.delegate)
    }
}
