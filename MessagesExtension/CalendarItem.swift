//
//  CalendarItem.swift
//  CalendarDatePicker
//
//  Created by Pranav Kasetti on 07/09/2017.
//  Copyright © 2017 Pranav Kasetti. All rights reserved.
//

import Foundation
import Messages

struct CalendarItem {
  var caption: String?
  var image: UIImage?
  var startDate: Date?
  var endDate: Date?
  
  var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd:MM:yyyy"
    formatter.timeZone = TimeZone.current
    return formatter
  }
  
  init(){

  }
  
  init?(queryItems: [URLQueryItem]) {
    var decodedCaption: String?
    var decodedDate1: Date?
    var decodedDate2: Date?
    for queryItem in queryItems {
      guard let value = queryItem.value else { return nil }
      if let date = dateFormatter.date(from: value), queryItem.name == "date1"{
        decodedDate1 = date
      }
      if let date =  dateFormatter.date(from: value), queryItem.name == "date2"{
        decodedDate2 = date
      }
      if queryItem.name == "caption"{
        decodedCaption = value
      }
    }
    
    guard let image = UIImage(named: "add_calendar") else { return nil }
    self.image = image
    self.caption = decodedCaption
    self.startDate = decodedDate1
    self.endDate = decodedDate2
  }
  
  init?(message: MSMessage?){
    guard let url = message?.url else { return nil }
    guard let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = urlComponents.queryItems else { return nil }
    
    self.init(queryItems: queryItems)
  }
}

