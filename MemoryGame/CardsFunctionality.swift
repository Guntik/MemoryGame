//
//  CardsFunctionality.swift
//  MemoryGame
//
//  Created by on 29/11/2018.
//  Copyright © 2018 Galina Gainetdinova. All rights reserved.
//

import Foundation
import UIKit

class CardsFunctionality {

    var counterPairs = 0
    var backImage = "BackImage"
    var isMatched = false
    var stringArray = ["Haus", "Haus1", "Fisch", "Fisch1", "Apfel", "Apfel1", "Kleid", "Kleid1",  "Stern", "Stern1", "Sonne", "Sonne1", "Fahne", "Fahne1", "Uhr", "Uhr1"]
    var cardsStringArray = [String]()
    
    //get array of cards
    func getCards() -> [Card]{
        let imageArray = getImages()
        let cardsArray = CardsArray(array: imageArray, stringArray: cardsStringArray)
        return cardsArray
    }
    
    //get arrray of images
    func getImages() -> [UIImage]
    {
        let imageOfArray = imageArray(array: stringArray)
        cardsStringArray = stringArray
        return imageOfArray
    }
    
    //counter of the Card pairs
    func allPairs() -> Bool{
        if (counterPairs == 8){
            return true
        }
        else {
            return false
        }
    }
    
    //array of card
    func CardsArray(array:[UIImage], stringArray: [String]) -> [Card] {
        var cards = [Card]()
        for index in 0...15 {
            let card = Card()
            card.position = index
            card.image = array[index]
            card.imageString = cardsStringArray[index]
            cards.append(card)
        }
        return cards
    }
    
    //array of images
    func imageArray(array:[String]) -> [UIImage]{
        var images = [UIImage]()
        for index in 0...15 {
            if array[index] != "" {
                images.append(UIImage(named: array[index])!) // add test for .png
            }
        }
        return images
    }
    
    //set back-image for the card
    func setBackCard(imageName: String) -> UIImage
    {
        let backCard = getImageOfBackCard()
        return backCard
    }
    
    //get back-image of the card
    func getImageOfBackCard() -> UIImage
    {
        if let imageBackCard = UIImage(named: backImage) {
            return imageBackCard
        }
        else {
            print ("error: can't get image")
            return UIImage()
        }
    }
    
    //showing messagies and alerts
    func showMessage(messageString: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    //reloading Game
    func reloadCardFunctionality() {
        counterPairs = 0
        isMatched = false
    }
    
    //matching two Cards
    func compareCards(firstCard: Card, secondCard: Card) -> (firstIndexPath:IndexPath, secondIndexPath:IndexPath)
    {
        let mathingStringName = firstCard.imageString + "1" //creating string for mathing Image (imageName+1)
        let indexFirstPath = IndexPath(item: firstCard.position, section: 0)
        let indexSecondPath = IndexPath(item: secondCard.position, section: 0)
        
        //if matched
        if (secondCard.imageString == mathingStringName)
        {
            isMatched = true
        }
        return (indexFirstPath, indexSecondPath)
    }
    
    
}
