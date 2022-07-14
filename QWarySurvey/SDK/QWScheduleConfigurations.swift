//
//  QWScheduleConfigurations.swift
//  QWarySurvey
//
//  Created by fahid on 13/07/2022.
//

import Foundation

public struct QWScheduleConfigurations {
    
    // MARK: Properties
    public static var `default`: QWScheduleConfigurations {
        let startDate = Date().addingTimeInterval(15)   //  mark survey start date as 15 mins from now
        let repeatInterval = TimeInterval(60)     // repeat survey after 60 seconds
        return QWScheduleConfigurations(startDate: startDate, repeatSurvey: true, repeatInterval: repeatInterval)
    }
    var startDate: Date!
    var repeatInterval: TimeInterval!
    var repeatSurvey: Bool!

    // MARK: Initialize
    public init(startDate: Date,                    //  date with format dd/MM/yyyy HH:mm:ss
                repeatSurvey: Bool,                 //  should repeat survey
                repeatInterval: TimeInterval) {     //  time interval in seconds
        self.startDate = startDate
        self.repeatInterval = repeatInterval
        self.repeatSurvey = repeatSurvey
    }
}
