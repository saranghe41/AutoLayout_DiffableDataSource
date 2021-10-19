//
//  MyTableViewCell.swift
//  AutoLayout_DynamicTableView
//
//  Created by 김지은 on 2021/09/14.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UserProfileImage: UIImageView!
    @IBOutlet weak var UserContentLabel: UILabel!
    
    // 셀이 랜더링(그리기) 될때
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell - awakeFromNib called")
        
        UserProfileImage.layer.cornerRadius = UserProfileImage.frame.width / 2
    }
}
