//
//  ViewController.swift
//  MemoryGame
//
//  Created by on 27/11/2018.
//  Copyright © 2018 Galina Gainetdinova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cardsFunctionality = CardsFunctionality()
    var cards = [Card]()
    var backCard = UIImage()
    
    var positionArray = [Int]()
    var countsOfSelectedCards = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adjusting the Screen
        adjustCollectionView()
        
        //get array of Cards
        cards = cardsFunctionality.getCards()
        cards.shuffle() // schuffle the cards
        
        //get backImage for Cards
        backCard = cardsFunctionality.setBackCard(imageName: cardsFunctionality.backImage)
    }
    
    func adjustCollectionView()
    {
        let itemSize = UIScreen.main.bounds.width/4 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        collectionView.collectionViewLayout = layout
    }
    
    func reloadCards(){
        //reload all values
        countsOfSelectedCards = 0
        positionArray.removeAll()
        closeAllCards()
        cardsFunctionality.reloadCardFunctionality()
        cards = cardsFunctionality.getCards()
        backCard = cardsFunctionality.setBackCard(imageName: cardsFunctionality.backImage)
        collectionView.reloadData()
    }
    
    //close all cards
    func closeAllCards() {
        for index in 0...15 {
            let indexPath = IndexPath(item: index, section: 0)
            let openedCell = collectionView.cellForItem(at: indexPath)
            openedCell?.isUserInteractionEnabled = true
            (openedCell as! CollectionViewCell).Closed()
            (openedCell as! CollectionViewCell).isCardSelected = false
        }
    }
    
    //all cards are selected
    func winAndReload() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            //all cards are selected
            let alert = self.cardsFunctionality.showMessage(messageString: "That was awesome! Try one more Game!")
            self.present(alert, animated: true, completion: nil)
            
            //reloading CollectionView and refresh all values
            //close all cards
            self.reloadCards()
        }
    }
    
    //cards aren't matched
    func notMatchedCard(firstIndex: IndexPath, secondIndex: IndexPath) {
        //close selected cards
        let firstCell = collectionView.cellForItem(at: firstIndex)
        (firstCell as! CollectionViewCell).Closed()
        
        let secondCell = collectionView.cellForItem(at: secondIndex)
        (secondCell as! CollectionViewCell).Closed()
        
        //reload counter of selected cards and array with positions of selected cards
        self.countsOfSelectedCards = 0
        self.positionArray.removeAll()
    }
    
    //two cards are matched
    func matchedCards(firstIndexPath: IndexPath, secondIndexPath: IndexPath ) {
        //disable first opened matched cards
        let firstCell = collectionView.cellForItem(at: firstIndexPath)
        firstCell?.isUserInteractionEnabled = false
        (firstCell as! CollectionViewCell).isCardSelected = true
        
        //disable another opened Card
        let secondCell = collectionView.cellForItem(at: secondIndexPath)
        secondCell?.isUserInteractionEnabled = false
        (secondCell as! CollectionViewCell).isCardSelected = true
        
        //reload counter of selected card and array with positions of selected cards
        self.countsOfSelectedCards = 0
        self.positionArray.removeAll()
        cardsFunctionality.isMatched = false
    }
    
    //get selected cards
    func matchingSelectedCards(index:IndexPath, cell: UICollectionViewCell) {
        
        //count of opened Carts
        countsOfSelectedCards += 1
        
        //position of opened Cards
        let position = index.item
        positionArray.append(position)
        
        //selected card
        if let selectedCard = cards.first(where: {$0.position == position}) {
            //image for selected card
            (cell as! CollectionViewCell).imageView.image = selectedCard.image
            (cell as! CollectionViewCell).Opened()
            
            //disable selected card
            cell.isUserInteractionEnabled = false
            
            // matching 2 opened Cards
            if self.countsOfSelectedCards == 2 {
                
                let firstSelectedCard = self.cards.first(where: {$0.position == self.positionArray[0]})
                
                //compare 2 Cards
                let cardsIndexPaths = cardsFunctionality.compareCards(firstCard: firstSelectedCard!, secondCard: selectedCard)
                
                if (!cardsFunctionality.isMatched)
                {
                    //if they don't match
                    notMatchedCard(firstIndex: cardsIndexPaths.firstIndexPath, secondIndex: cardsIndexPaths.secondIndexPath)
                }
                else {
                    //if selected cards are matched
            
                    //increase counter of selected matched cards
                    cardsFunctionality.counterPairs += 1
                    
                    if (self.cardsFunctionality.allPairs()){
                        winAndReload()
                    }
                    else {
                        //not all cards are selected
                        matchedCards(firstIndexPath: cardsIndexPaths.firstIndexPath, secondIndexPath: cardsIndexPaths.secondIndexPath)
                    }
                }
                //enable card for selecting
                let firstCell = collectionView.cellForItem(at: cardsIndexPaths.firstIndexPath)
                firstCell?.isUserInteractionEnabled = true
                cell.isUserInteractionEnabled = true
            }
        } else {
            print("error: selection of item!")
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! CollectionViewCell
        
        // set all carts closed (backImage is visible)
        cell.backView.image = self.backCard
        return cell
    }
}

extension ViewController: UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //get selected cell
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        matchingSelectedCards(index: indexPath, cell: cell)
    }

}
