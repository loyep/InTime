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
    
    private lazy var timer: DispatchSourceTimer = {
        let t = DispatchSource.makeTimerSource()
        t.schedule(deadline: .now(), repeating: 1)
        t.setEventHandler(handler: {
            self.eventHandler()
        })
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.resume()
    }
    
    func eventHandler() {
        let nowDate = Date()
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: calendar.dateComponents(Set<Calendar.Component>([.year]), from: nowDate))
        var components = DateComponents()
        components.year = 1
        components.second = -1
        let endDate = calendar.date(byAdding: components, to: startDate!)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy·MM·dd·HH·mm·ss"
        components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate, to: endDate)
        let format = String(format: "%04d·%02d·%02d·%02d·%02d·%02d", components.year!, components.month!, components.day!, components.hour!, components.minute!, components.second!)
        print("\(format)")
//        print("\(components.year!)·\(components.month!)·\(components.day!)·\(components.hour!)·\(components.minute!)·\(components.second!)")
        DispatchQueue.main.async {
            self.timeLabel.text = format
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

