//
//  ViewController.swift
//  calendar
//
//  Created by 椎野大地 on 2017/01/14.
//  Copyright © 2017年 Daichi Shiino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var headerPrevBtn: UIButton!
    @IBOutlet weak var headerNextBtn: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var calendarHeaderView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //①タップ
    @IBAction func tappedHeaderPrevBtn(sender: UIButton) {
    }
    
    //②タップ
    @IBAction func tappedHeaderNextBtn(sender: UIButton) {
    }
    

}

