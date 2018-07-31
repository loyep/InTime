//
//  ViewController.swift
//  InTime
//
//  Created by Loren on 2018/7/30.
//  Copyright © 2018年 Linger. All rights reserved.
//

import UIKit

class InTimeViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    private var endYearDate: Date = Date()
    
    private var startYearDate: Date = Date()
    
    private let calendar = Calendar.current
    
    private let calendarComponent: DateComponents = {
        var c = DateComponents()
        c.year = 1
        c.second = 1
        return c
    }()
    
    private lazy var timer: Timer = {
        let t = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(InTimeViewController.eventHandler), userInfo: nil, repeats: true)
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        var timeInterval = date.timeIntervalSinceReferenceDate
        timeInterval = ceil(timeInterval)
        let fireDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        timer.fireDate = fireDate
    }
    
    func getEndYearDate(_ nowDate: Date) -> Date {
        let startDate = calendar.date(from: calendar.dateComponents(Set<Calendar.Component>([.year]), from: nowDate))!
        
        if startDate != startYearDate {
            startYearDate = startDate
            endYearDate = calendar.date(byAdding: calendarComponent, to: startDate)!
        }
        return endYearDate
    }
    
    @objc func eventHandler() {
        let nowDate = Date()

        let endDate = getEndYearDate(nowDate)
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate, to: endDate)
        let format = String(format: "%04d·%02d·%02d·%02d·%02d·%02d", components.year!, components.month!, components.day!, components.hour!, components.minute!, components.second!)
        
        DispatchQueue.main.async {
            self.timeLabel.text = format
        }
    }

}

