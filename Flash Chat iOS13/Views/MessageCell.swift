//
//  MessegeCell.swift
//  Flash Chat iOS13
//
//  Created by Сергей Кривошапко on 15.06.2021.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messegaBubble: UIView!
    @IBOutlet weak var lable: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    var sender: String? = nil

    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        messegaBubble.layer.cornerRadius = messegaBubble.frame.size.height / 5
        

    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        //Для случая, когда отправляет сообщение пользователь
        if sender == Auth.auth().currentUser?.email {
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messegaBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            lable.textColor = UIColor(named: K.BrandColors.purple)
        }
        //Пользователь принимает сообщение
        else {
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messegaBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            lable.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
    } 
}
