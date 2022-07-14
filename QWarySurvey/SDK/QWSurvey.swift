//
//  QWSurvey.swift
//  QWarySurvey
//
//  Created by fahid on 01/07/2022.
//

import Foundation
import UIKit

public class QWSurvey: QWSurveyDelegate {

    // MARK: Properties
    private var request: QWSurveyRequest!
    private var surveyDelegate: QWSurveyDelegate!
    private var configurations: QWScheduleConfigurations!
    private var isAlreadyTakenKey = "isAlreadyTaken_"
    private var startDateKey = "startDate_"

    // MARK: Initialization
    public init(request: QWSurveyRequest, delegate: QWSurveyDelegate?, configurations: QWScheduleConfigurations) {
        self.request = request
        self.surveyDelegate = delegate
        self.configurations = configurations
        if let urlString = request.url?.absoluteString {
            isAlreadyTakenKey += urlString
            startDateKey += urlString
        }
    }

    // MARK: Public methods
    public func scheduleSurvey(parent: UIViewController) {
        var promptDate: Date!
        if let nextPromptDateTime = UserDefaults.standard.value(forKey: startDateKey) as? Date {
            promptDate = nextPromptDateTime
            print("defaults survey next date/time: \(String(describing: promptDate))")
        }
        else {
            promptDate = configurations.startDate
            print("configs survey start date/time: \(String(describing: promptDate))")
        }
        guard let startDateTime = promptDate else {
            print("Error: Survey schedule start date time can not be nil")
            return
        }
        
        if startDateTime < Date() {
            if !configurations.repeatSurvey {
                let isAlreadyTaken = UserDefaults.standard.bool(forKey: isAlreadyTakenKey)
                if isAlreadyTaken {
                    print("Survey is already taken and repeat is not allowed in configs.")
                    return
                }
            }
            let qwSurveyViewController = QWSurveyViewController(request: self.request, delegate: self)
            parent.present(qwSurveyViewController, animated: true, completion: nil)

            let nextPromptDateTime = startDateTime.addingTimeInterval(configurations.repeatInterval)
            UserDefaults.standard.set(nextPromptDateTime, forKey: startDateKey)
            UserDefaults.standard.synchronize()
            
            print("Next survey start date/time \(nextPromptDateTime)")
        }
    }

    public func clearSchedule() {
        UserDefaults.standard.removeObject(forKey: isAlreadyTakenKey)
        UserDefaults.standard.removeObject(forKey: startDateKey)
    }

    // MARK: Delegate
    public func didReceiveSurveyOutcome(_ state: QWSurveyState) {
        UserDefaults.standard.set(true, forKey: isAlreadyTakenKey)
        UserDefaults.standard.synchronize()
        surveyDelegate?.didReceiveSurveyOutcome(state)
    }
    
    public func didRedirectToURL(_ url: String) {
        surveyDelegate?.didRedirectToURL(url)
    }
}
