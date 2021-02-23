//
//  ViewController.swift
//  Tinder
//
//  Created by MASAMUNE on 2021/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basiccard: UIView!
    
    @IBOutlet weak var likeImageview: UIImageView!
    
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    @IBOutlet weak var person5: UIView!
    @IBOutlet weak var person6: UIView!
    @IBOutlet weak var person7: UIView!
    @IBOutlet weak var person8: UIView!
    @IBOutlet weak var person9: UIView!
    @IBOutlet weak var person10: UIView!
    @IBOutlet weak var person11: UIView!
    @IBOutlet weak var person12: UIView!
    
    var centerOfCard:CGPoint!
    var people = [UIView]()
    var selectedCardCount: Int = 0
    
    let name = ["理事長な田尻","死にかけの田尻","枝豆に命をかける田尻","寝癖の田尻","乱酒な田尻","ラジオな田尻","ナルシスト田尻","アップな田尻","すき家な田尻","イキる田尻","3Dモデルな田尻","1な田尻"]
    var likename = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basiccard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
        people.append(person5)
        people.append(person6)
        people.append(person7)
        people.append(person8)
        people.append(person9)
        people.append(person10)
        people.append(person11)
        people.append(person12)
        
        // Do any additional setup after loading the view.
    }
    
    func resetCard(){
        basiccard.center = self.centerOfCard
        basiccard.transform = .identity
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushList"{
            let vc = segue.destination as! ListViewController
            vc.likename = likename
        }
    }
    
    
    @IBAction func likebutton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageview.alpha = 0
        likename.append(name[selectedCardCount])
        
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
    }
    
    @IBAction func dislikebutton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageview.alpha = 0
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
            
        }
    }
    
    
    @IBAction func swipecard(_ sender: UIPanGestureRecognizer) {
        
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        //角度を変える
        let xFromCenter = card.center.x - view.center.x
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.725)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.725)
        
        if xFromCenter > 0 {
            likeImageview.image = #imageLiteral(resourceName: "good")
            likeImageview.alpha = 1
            likeImageview.tintColor = UIColor.blue
        } else if xFromCenter < 0 {
            likeImageview.image = #imageLiteral(resourceName: "bad")
            likeImageview.alpha = 1
            likeImageview.tintColor = UIColor.red
        }
        
        
        if sender.state == UIGestureRecognizer.State.ended {
            //左に大きくスワイプ
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 250, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageview.alpha = 0
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                    
                }
                return
            }
            
            //右に大きくスワイプ
            else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 250, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageview.alpha = 0
                likename.append(name[selectedCardCount])
                
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            }
            //元に戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                self.people[self.selectedCardCount].center = self.centerOfCard
                self.people[self.selectedCardCount].transform = .identity
            })
            likeImageview.alpha = 0
        }
    }
    

}

