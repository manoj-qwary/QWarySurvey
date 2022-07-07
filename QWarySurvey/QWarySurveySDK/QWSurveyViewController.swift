//
//  QWSurveyViewController.swift
//  QWarySurvey
//
//  Created by fahid on 30/06/2022.
//

import Foundation
import UIKit

public class QWSurveyViewController: UIViewController, QWSurveyDelegate {
    
    private var request: QWSurveyRequest!
    
    convenience init(request: QWSurveyRequest) {
        self.init()
        self.request = request
    }
    
    // MARK: Properties
    public var surveyDelegate: QWSurveyDelegate!
    public var thankyouTimeout: Double = 3.0
    
    // MARK: Initialize
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = view.backgroundColor == nil ? .white : view.backgroundColor
        guard let request = self.request else {
            print("Error: Request can not be nil")
            return
        }
        let qwSurveyView = QWSurveyView()
        qwSurveyView.surveyDelegate = self
        qwSurveyView.frame = view.bounds
        qwSurveyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        qwSurveyView.loadSurvey(request: request)
        view.addSubview(qwSurveyView)
    }
    
    // MARK: Delegate
    public func handleSurveyResponse(response: [String : AnyObject]) {
        if surveyDelegate != nil {
            surveyDelegate.handleSurveyResponse(response: response)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + thankyouTimeout) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    public func handleSurveyLoaded(response: [String : AnyObject]){
        if surveyDelegate != nil {
            surveyDelegate.handleSurveyLoaded(response: response)
        }
    }
}
