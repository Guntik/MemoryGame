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
        var cardsArray = CardsArray(array: imageArray, stringArray: cardsStringArray)
        return cardsArray
    }
    
    //get arrray of images
    func getImages() -> [UIImage]
    {
        let shuffledArray = stringArray.shuffled() // shuffle the array with strings
        let imageOfArray = imageArray(array: shuffledArray)
        cardsStringArray = shuffledArray
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
        //images.shuffle() //shuffle the images for cards
        return images
    }
    
    //set back-image for the card
    func setBackCard(imageName: String) -> UIImage
    {
        if let imageBackCard = UIImage(named: imageName) {
            return imageBackCard
        }
        else {
            print ("error: can't get image")
            return UIImage()
        }
    }
    
    
    //reloading Game
    func reloadCardFunctionality() {
        counterPairs = 0
        isMatched = false
    }
    
    //matching two Cards
    func compareCards(firstCard: Card, secondCard: Card) -> (firstIndexPath:IndexPath, secondIndexPath:IndexPath)
    {
        let indexFirstPath = IndexPath(item: firstCard.position, section: 0)
        let indexSecondPath = IndexPath(item: secondCard.position, section: 0)

        //finding the last character (Number 1) in firsthe string name
        if (firstCard.imageString.suffix(1) == "1") {
            //if matched
            if (secondCard.imageString == firstCard.imageString.dropLast())
            {
                isMatched = true
            }
        }
        else if (secondCard.imageString.suffix(1) == "1"){
            if (secondCard.imageString.dropLast() == firstCard.imageString)
            {
                isMatched = true
            }
        }
        return (indexFirstPath, indexSecondPath)
    }
    
    //showing messagies and alerts
    func showMessage(messageString: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
}
