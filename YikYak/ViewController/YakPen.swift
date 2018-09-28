//
//  YakPenViewController.swift
//  YikYak
//
//  Created by Ivan Ramirez on 9/27/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class YakPen: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var downVotesButton: UIButton!
    @IBOutlet weak var upVoteButton: UIButton!
    
    
    var yak: Yak? {
        didSet {
            //sometimes you get the data before the view loads
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: UpdateVies
    
    func updateViews() {
        guard let yak = yak else {return}
        textLabel.text = yak.text
        authorLabel.text = yak.author
        upVoteButton.setTitle("UP Votes: \(yak.upVotes)", for: .normal)
        downVotesButton.setTitle("Down Votes: \(yak.downVotes)", for: .normal)
    }
    
    
    
    @IBAction func upVoteButtonTappedByUser(_ sender: Any) {
        guard let yak = yak else {return}
        yak.upVotes += 1
        updateViews()
    }
    
    @IBAction func downVoteButtonTapped(_ sender: Any) {
        guard let yak = yak else {return}
        yak.downVotes -= 1
        updateViews()
    }
    
}

