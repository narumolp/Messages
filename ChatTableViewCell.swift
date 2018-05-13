//
//  ChatTableViewCell.swift
//  MyFirebaseApp
//
//  Created by Narumol Pugkhem on 5/8/18.
//  Copyright © 2018 Narumol Pugkhem. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var message: UIMarginLabel!
  @IBOutlet weak var userImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    message.layer.cornerRadius = 3.0
    message.insets(top: 10, right: 10, bottom: 10, left: 10)
  }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class UIMarginLabel: UILabel {
  
  var topInset:       CGFloat = 0
  var rightInset:     CGFloat = 0
  var bottomInset:    CGFloat = 0
  var leftInset:      CGFloat = 0
  
  func insets(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
    self.topInset = top
    self.rightInset = right
    self.bottomInset = bottom
    self.leftInset = left
  }
  
  override func drawText(in rect: CGRect) {
    let insets: UIEdgeInsets = UIEdgeInsets(top: self.topInset, left: self.leftInset, bottom: self.bottomInset, right: self.rightInset)
    self.setNeedsLayout()
    return super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
}

