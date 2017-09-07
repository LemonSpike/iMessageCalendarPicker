//
//  CreateCalendarViewController.swift
//  CalendarDatePicker
//
//  Created by Pranav Kasetti on 07/09/2017.
//  Copyright © 2017 Pranav Kasetti. All rights reserved.
//

import UIKit
import Messages
import EPCalendarPicker

class CreateCalendarViewController: UIViewController {
  static let storyboardIdentifier = "CreateCalendarViewController"
  
  @IBOutlet weak var captionTF: UITextField!
  @IBOutlet weak var submitBtn: UIButton!
  @IBOutlet weak var calendarImageBtn: UIButton!
  @IBOutlet weak var sender1: UILabel!
  @IBOutlet weak var sender2: UILabel!

  var calendarItem: CalendarItem?
  var delegate: CreateCalendarViewControllerDelegate?
  var conversation: MSConversation?
  
  func isOrigSender() -> Bool{
    if let message = self.conversation?.selectedMessage{
      return message.senderParticipantIdentifier == self.conversation?.localParticipantIdentifier
    }
    return false
  }
  
  @IBAction func changeCalendarItem(_ sender: Any) {
    let calendarPicker = EPCalendarPicker(startYear: 2017, endYear: 2017, multiSelection: true, selectedDates: nil)
    calendarPicker.calendarDelegate = self
    let navigationController = UINavigationController(rootViewController: calendarPicker)
    self.present(navigationController, animated: true, completion: nil)
  }
  
  @IBAction func shareCalendar(_ sender: AnyObject) {
    self.calendarItem?.caption = self.captionTF.text
    self.calendarItem?.image = self.calendarImageBtn.backgroundImage(for: .normal)
    delegate?.addCalendarForItem(self.calendarItem!, layoutImg: self.createLayoutImage())
  }
  
}

extension CreateCalendarViewController {
  func createLayoutImage()->UIImage?{
    let size = CGSize(width:self.view.bounds.width, height: self.view.bounds.height)
    UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
    self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}

extension CreateCalendarViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    return textField.resignFirstResponder()
  }
}

protocol CreateCalendarViewControllerDelegate: class {
  func addCalendarForItem(_ item: CalendarItem, layoutImg: UIImage?)
}

extension CreateCalendarViewController: EPCalendarPickerDelegate {
  func epCalendarPicker(_: EPCalendarPicker, didCancel error : NSError) {
   print("User cancelled selection")
  }
  func epCalendarPicker(_: EPCalendarPicker, didSelectDate date : Date) {
    print("User selected date: \n\(date)")
  }

  func epCalendarPicker(_: EPCalendarPicker, didSelectMultipleDate dates : [Date]) {
    print("User selected dates: \n\(dates)")
  }
}
