//
//  CalendarCell.swift
//  calendar
//
//  Created by 椎野大地 on 2017/01/14.
//  Copyright © 2017年 Daichi Shiino. All rights reserved.
//

import Foundation
import UIKit

class CalendarCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // UILabelを生成
        textLabel = UILabel(frame:
            CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = NSTextAlignment.center
        // Cellに追加
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
}
