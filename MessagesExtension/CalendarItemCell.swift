//
//  CalendarItemCell.swift
//  CalendarDatePicker
//
//  Created by Pranav Kasetti on 07/09/2017.
//  Copyright © 2017 Pranav Kasetti. All rights reserved.
//

import UIKit
import Messages

class CalendarItemCell: UICollectionViewCell {
  static let reuseId = "stickerCell"
  var calendarItem: CalendarItem?
  
  @IBOutlet weak var stickerView: MSStickerView!
  
}

class AddCalendarItemCell: UICollectionViewCell {
  static let reuseId = "addCalendarCell"
  
  @IBOutlet weak var imageView: UIImageView!
}
