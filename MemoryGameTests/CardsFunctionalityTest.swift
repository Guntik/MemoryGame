//
//  CardFunctionalityTest.swift
//  MemoryGameTests
//
//  Created on 03/12/2018.
//  Copyright © 2018 G. All rights reserved.
//

import Foundation
import XCTest
@testable import MemoryGame

class CardsFunktionalityTest: XCTestCase {
    
    let cardsFunctionality = CardsFunctionality()
    
    override func setUp() {
        super.setUp()
    }
    
    func testGetCards() {
        let array = ["Fake1", "Fake2", "Fake3", "Fake4", "Fake5", "Fake6", "Fake7", "Fake8", "Fake9", "Fake10", "Fak11", "Fake12", "Fake13", "Fake14", "Fake15", "Fake16"]
        
        let imageArray = cardsFunctionality.getImages()
        XCTAssertTrue(imageArray.count > 1)
        
        let cardsArray = cardsFunctionality.CardsArray(array: imageArray, stringArray: array)
        //existing cardsArray
        XCTAssertTrue(cardsArray.count > 0)
        
        //count of cardsArray = 16
        XCTAssertTrue(cardsArray.count == 16)
    }
    
    func testGetImage() {
        let pictureList = cardsFunctionality.getPictures()
        
        //existing pictureArray
        XCTAssertTrue(pictureList.count > 0)
        
        //count more than 9 (image cards and back image)
        XCTAssertTrue(pictureList.count > 9)
        
        //without duplicates
        let duplicates = Array(Set(pictureList.filter({ (i: String) in pictureList.filter({ $0 == i }).count > 1})))
        XCTAssertFalse(duplicates.count > 0)
        
        let array = cardsFunctionality.makeArray(array: pictureList)
        //array exist
        XCTAssertTrue(array.count > 0)
        
        //array has 8 items
        XCTAssertTrue(array.count == 16)
        
        //array has duplicated URL (pairs of images)
        let duplicateImages = Array(Set(array.filter({ (i: String) in array.filter({ $0 == i }).count > 1})))
        XCTAssertTrue(duplicateImages.count == 8)
        
        let imageOfArray = cardsFunctionality.imageArray(array: array)
        
        //array exist
        XCTAssertTrue(imageOfArray.count > 0)
        
        //array has 16 items
        XCTAssertTrue(imageOfArray.count == 16)
    }
    
    func testAllPairs() {
        cardsFunctionality.counterPairs = 8
        XCTAssertTrue(cardsFunctionality.allPairs())
    }
    
    func testCardsArray() {
        var cards = [Card]()
        XCTAssertFalse(cards.count > 0)
        
        let card = Card()
        card.position = 1;
        card.image = UIImage()
        card.imageString = ""
        
        cards.append(card)
        XCTAssertTrue(cards.count > 0)
    }
    
    func testImageArray() {
        var arrayImages = [UIImage]()
        XCTAssertFalse(arrayImages.count > 0)
        let image = UIImage()
        arrayImages.append(image)
        XCTAssertTrue(arrayImages.count > 0)
    }
    
    func testMakeArray() {
        let array = ["Fake1", "Fake2", "Fake3", "Fake4", "Fake5", "Fake6", "Fake7", "Fake8", "Fake9", "Fake10", "Fak11", "Fake12"]
        
        XCTAssertTrue(cardsFunctionality.makeArray(array: array).count == 16)
    }
    
    func testReloadFunctionality() {
        XCTAssertTrue(cardsFunctionality.getCards().count > 0)
        XCTAssertTrue(cardsFunctionality.getCards().count == 16)
    }
    
    func testRealoadCardFunctionality() {
        cardsFunctionality.reloadCardFunctionality()
        XCTAssertTrue(cardsFunctionality.counterPairs == 0)
        XCTAssertTrue(cardsFunctionality.backImageUrl == "")
        XCTAssertFalse(cardsFunctionality.isMatched)
    }
}
