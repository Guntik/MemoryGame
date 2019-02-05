//
//  CardsFunctionality.swift
//  MemoryGame
//
//  Created by on 29/11/2018.
//  Copyright © 2018 G. All rights reserved.
//

import Foundation
import UIKit

class CardsFunctionality {

    var counterPairs = 0
    
    var backImage = UIImage()
    
    var arrayString = [String]()
    var isMatched = false
    
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
        let pictureList = getPictures()
        
        //array with 16 URL
        arrayString = makeArray(array: pictureList)
        
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
        for index in 0...15 {
            let url = URL(string: array[index])
            let data = try? Data(contentsOf: url!)
            images.append(UIImage(data: data!)!)
        }
        return images
    }
    
    //set back-image for the card
    func setBackCard(imageURL: String) -> UIImage
    {
        let backCard = getImageOfBackCard(back: imageURL)
        return backCard
    }
    
    //get back-image of the card
    func getImageOfBackCard(back: String) -> UIImage
    {
        let url = URL(string: back)
        let data = try? Data(contentsOf: url!)
        if let imageBackCard = UIImage(data: data!) {
            return imageBackCard
        }
        else {
            print ("error: can't get image")
            return UIImage()
        }
    }
    
    //selecting first 8 items and doppel it with shufffling
    func makeArray(array: [String]) ->[String] {
        var array16 = [String]()
        array16 = (array[0 ..< 8] + array[0 ..< 8]).shuffled()
        backImageUrl = array[8]
        return array16
    }
    
    //request from URL
    func setRequest() -> URLRequest {
        let url = ""
        let myUrl=URL(string:url)
        var request = URLRequest(url:myUrl!)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        return request
    }
    
    //get shuffled array with URL from JSON
    func getPictures() -> [String] {
        var pictureList = [String]()
        var list = [String]()
        let request = self.setRequest()
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
        semaphore.wait()
        
        //remove the same image with url "https://i1.sndcdn.com/artworks-000082611384-u1ifp4-large.jpg"
        if let index = list.index(of:"https://i1.sndcdn.com/artworks-000082611384-u1ifp4-large.jpg") {
            list.remove(at: index)
        }
        pictureList = list.shuffled()
        return pictureList
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
        backImageUrl = ""
        isMatched = false
    }
    
    //matching two Cards
    func compareCards(firstCard: Card, secondCard: Card) -> (firstIndexPath:IndexPath, secondIndexPath:IndexPath)
    {
        let indexFirstPath = IndexPath(item: firstCard.position, section: 0)
        let indexSecondPath = IndexPath(item: secondCard.position, section: 0)
        
        //if matched
        if (firstCard.imageString == secondCard.imageString)
        {
            isMatched = true
        }
        return (indexFirstPath, indexSecondPath)
    }
    
    
}