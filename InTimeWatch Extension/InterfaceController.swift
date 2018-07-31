//
//  InterfaceController.swift
//  InTimeWatch Extension
//
//  Created by Loren on 2018/7/30.
//  Copyright © 2018年 Linger. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    
    private var endYearDate: Date = Date()
    
    private var startYearDate: Date = Date()
    
    private let calendar = Calendar.current
    
    private var yearTimeLong: TimeInterval = 0
    
    private let calendarComponent: DateComponents = {
        var c = DateComponents()
        c.year = 1
        c.second = 1
        return c
    }()
    
    private lazy var timer: Timer = {
        let t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(InterfaceController.eventHandler), userInfo: nil, repeats: true)
        return t
    }()
    
    func getEndYearDate(_ nowDate: Date) -> Date {
        let startDate = calendar.date(from: calendar.dateComponents(Set<Calendar.Component>([.year]), from: nowDate))!
        
        if startDate != startYearDate {
            startYearDate = startDate
            endYearDate = calendar.date(byAdding: calendarComponent, to: startDate)!
            yearTimeLong = endYearDate.timeIntervalSince(startYearDate)
        }
        return endYearDate
    }
    
    @objc func eventHandler() {
        let nowDate = Date()
        
        let endDate = getEndYearDate(nowDate)
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate, to: endDate)
        let format = String(format: "%04d年·%02d月·%02d天\n%02d时· %02d分· %02d秒", components.year!, components.month!, components.day!, components.hour!, components.minute!, components.second!)
        
        let percent = "\(nowDate.timeIntervalSince(startYearDate) / yearTimeLong)"
        
        DispatchQueue.main.async {
//            self.timeLabel.setText(format)
            self.timeLabel.setText(percent)
        }
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let date = Date()
        var timeInterval = date.timeIntervalSinceReferenceDate
        timeInterval = ceil(timeInterval)
        let fireDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        timer.fireDate = fireDate
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        timer.invalidate()
    }

}
