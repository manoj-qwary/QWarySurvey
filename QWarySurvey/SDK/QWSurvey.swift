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
    public var params: [String: String] = [:]
    public var thankyouTimout: Double = 3.0
    public var surveyDelegate: QWSurveyDelegate!
    public var alertTitle: String = "Rate us"
    public var alertMessage: String = "Share your feedback and let us know how we are doing"
    public var alertPositiveButton: String = "Rate Now"
    public var alertNegativeButton: String = "Later"
    public var isConnectedToNetwork: Bool = true
    public var startAfter: Int64 = 259200000 // 3 days
    public var repeatInterval: Int64 = 432000000 // 5 days
    public var incrementalRepeat: Bool = false
    public var repeatSurvey: Bool = false
    public var getSurveyLoadedResponse: Bool = false

    private var dataStore = NSUbiquitousKeyValueStore()
    private var request: QWSurveyRequest!
    private var isAlreadyTakenKey = "isAlreadyTaken_"
    private var promptTimeKey = "promptTime_"
    private var incrementMultiplierKey = "incrementMultiplier_"

    // MARK: Initialization
    public init(request: QWSurveyRequest, delegate: QWSurveyDelegate?) {
        self.request = request
        self.surveyDelegate = delegate
        if let urlString = request.url?.absoluteString {
            isAlreadyTakenKey += urlString
            promptTimeKey += urlString
            incrementMultiplierKey += urlString
        }
    }

    // MARK: Public methods
    public func scheduleSurvey(parent: UIViewController) {
        let currentTime = Int64(Date().timeIntervalSince1970 * 1000)
        let isAlreadyTaken = UserDefaults.standard.bool(forKey: isAlreadyTakenKey)
        let promptTime = UserDefaults.standard.integer(forKey: promptTimeKey)
        var incrementMultiplier = UserDefaults.standard.integer(forKey: incrementMultiplierKey)
        incrementMultiplier = incrementMultiplier == 0 ? 1 : incrementMultiplier

        if promptTime == 0 {
            let nextPrompt = currentTime + startAfter
            UserDefaults.standard.set(nextPrompt, forKey: promptTimeKey)
            dataStore.set(1, forKey: incrementMultiplierKey)
            return
        }

        if isConnectedToNetwork && (!isAlreadyTaken || repeatSurvey) && (promptTime < currentTime) {
            let alertDialog = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            alertDialog.addAction(UIAlertAction(title: alertPositiveButton, style: UIAlertAction.Style.default, handler: { [weak self] action in
                guard let self = self else { return }
                let qwSurveyViewController = QWSurveyViewController(request: self.request, delegate: self)
                parent.present(qwSurveyViewController, animated: true, completion: nil)
            }))
            alertDialog.addAction(UIAlertAction(title: alertNegativeButton, style: UIAlertAction.Style.cancel, handler: nil))
            parent.present(alertDialog, animated: true)

            UserDefaults.standard.set(incrementalRepeat ? incrementMultiplier * 2 : 1, forKey: self.incrementMultiplierKey)
            let timeTillNext = repeatInterval * Int64(incrementMultiplier)
            let nextPrompt = currentTime + timeTillNext
            UserDefaults.standard.set(nextPrompt, forKey: promptTimeKey)
        }
    }

    public func clearSchedule() {
        UserDefaults.standard.removeObject(forKey: incrementMultiplierKey)
        UserDefaults.standard.removeObject(forKey: isAlreadyTakenKey)
        UserDefaults.standard.removeObject(forKey: promptTimeKey)
    }

    // MARK: Delegate
    public func didReceiveSurveyOutcome(_ state: QWSurveyState) {
        UserDefaults.standard.set(true, forKey: isAlreadyTakenKey)
        surveyDelegate?.didReceiveSurveyOutcome(state)
    }
    
    public func didRedirectToURL(_ url: String) {
        surveyDelegate?.didRedirectToURL(url)
    }
}
