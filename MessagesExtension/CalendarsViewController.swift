//
//  CalendarsViewController.swift
//  CalendarDatePicker
//
//  Created by Pranav Kasetti on 07/09/2017.
//  Copyright © 2017 Pranav Kasetti. All rights reserved.
//

import UIKit

class CalendarsViewController: UICollectionViewController {
  
  static let storyboardIdentifier = "CalendarsViewController"
  var delegate :CalendarsViewControllerDelegate?
  
  enum CalendarsCollectionItem{
    case calendar(CalendarItem)
    case add
  }
  
  var calendarsList: [CalendarsCollectionItem]

  required init?(coder aDecoder: NSCoder) {
    self.calendarsList = [CalendarsCollectionItem]()
    self.calendarsList.insert(CalendarsCollectionItem.add, at: 0)
    super.init(coder: aDecoder)
  }
  
  // MARK: UICollectionViewDataSource
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.calendarsList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let calendar = self.calendarsList[indexPath.row]
    
    switch calendar {
    case .add:
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCalendarItemCell.reuseId, for: indexPath) as? AddCalendarItemCell else { fatalError("failed to find add cell")}
      
      cell.imageView = UIImageView(image: UIImage(named:"add_calendar"))
      return cell
      
    case .calendar(let calendarItem):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarItemCell.reuseId, for: indexPath) as? CalendarItemCell else { fatalError("failed to obtain rating cell") }
      
      cell.calendarItem = calendarItem
      return cell
    }
  }
  
  // MARK: UICollectionViewDelegate
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let calendar = self.calendarsList[indexPath.row]
    
    switch calendar {
    case .add:
      delegate?.didSelectCalendarItem()
    default:
      break;
    }
  }
}

protocol CalendarsViewControllerDelegate: class {
  func didSelectCalendarItem()
}
