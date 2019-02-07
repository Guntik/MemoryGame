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
    var backImage = "BackImage_jpg"
    var arrayString = [String]()
    var isMatched = false
    var ImageArray = ["Haus", "Haus1", "Fisch", "Fisch1", "Apfel", "Apfel1", "Kleid", "Kleid1",  "Stern", "Stern1", "Sonne", "Sonne1", "Fahne", "Fahne1", "Uhr", "Uhr1"]
    
    //get array of cards
    func getCards() -> [Card]{
        let imageArray = getImages()
        let cardsArray = CardsArray(array: imageArray, stringArray: arrayString)
        return cardsArray
    }
    
    //get arrray of images
    func getImages() -> [UIImage]
    {
        //array with all pictures from JSON
        //let pictureList = getPictures()
        
        //array with 16 URL
        //arrayString = makeArray(array: pictureList)
        
        //array with Images
        let imageOfArray = imageArray(array: arrayString)

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
            card.imageString = stringArray[index]
            cards.append(card)
        }
        return cards
    }
    
    //array of images
    func imageArray(array:[String]) -> [UIImage]{
        var images = [UIImage]()
        array.shuffle() // shaffle the names for cards
        for index in 0...15 {
            //let url = URL(string: array[index])
            //let data = try? Data(contentsOf: url!)
            images.append(UIImage(array[index])!)
        }
        return images
    }
    
    //set back-image for the card
    func setBackCard(imageName: String) -> UIImage
    {
        let backCard = getImageOfBackCard(back: imageName)
        return backCard
    }
    
    //get back-image of the card
    func getImageOfBackCard(back: String) -> UIImage
    {
        //let url = URL(string: back)
        //let data = try? Data(contentsOf: url!)
        if let imageBackCard = UIImage(back) {
            return imageBackCard
        }
        else {
            print ("error: can't get image")
            return UIImage()
        }
    }
    
    //selecting first 8 items and doppel it with shufffling
    /*func makeArray(array: [String]) ->[String] {
        var array16 = [String]()
        array16 = (array[0 ..< 8] + array[0 ..< 8]).shuffled()
        backImageUrl = array[8]
        return array16
    }*/
    
    //request from URL
    /*func setRequest() -> URLRequest {
        let url = "" // url of the image
        let myUrl=URL(string:url)
        var request = URLRequest(url:myUrl!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        return request
    }*/
    
    //get shuffled array with URL from JSON
    /*func getPictures() -> [String] {
        var pictureList = [String]()
        var list = [String]()
        
        /*let request = self.setRequest()
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request){
            data, response, error in
            guard(error == nil) else {
                print( "Error: " + error.debugDescription)
                return
            }
            do{
                let parseResult = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                guard let
                    jsonDictionary = parseResult as NSDictionary?,
                    let tracks = jsonDictionary["tracks"]
                    else { return }
                let trackArray = tracks as! NSArray
                for index in 0...trackArray .count-1 {
                    let track = trackArray [index] as! [String : AnyObject]
                    let image = track["artwork_url"] as! String
                    list.append(image)
                }
            } catch {
                print("Could not parse data as Json")
                return
            }
            semaphore.signal()
            }.resume()
        semaphore.wait()*/
        
        pictureList = list.shuffled()
        return pictureList
    }*/
    
    
    //showing messagies and alerts
    func showMessage(messageString: String) -> UIAlertController {
        let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    //reloading Game
    func reloadCardFunctionality() {
        counterPairs = 0
        backImageUrl = ""
        isMatched = false
    }
    
    //matching two Cards
    func compareCards(firstCard: Card, secondCard: Card) -> (firstIndexPath:IndexPath, secondIndexPath:IndexPath)
    {
        let mathingStringName = firstCard.imageString + "1" //creating string for mathing Image (imageName+1)
        let indexFirstPath = IndexPath(item: firstCard.position, section: 0)
        let indexSecondPath = IndexPath(item: secondCard.position, section: 0)
        
        //if matched
        if (second.imageString == mathingStringName)
        {
            isMatched = true
        }
        return (indexFirstPath, indexSecondPath)
    }
    
    
}
