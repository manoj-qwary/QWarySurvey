//
//  QWSurveyDelegate.swift
//  QWarySurvey
//
//  Created by fahid on 30/06/2022.
//

import Foundation

public protocol QWSurveyDelegate {
    func handleSurveyResponse(response: [String: AnyObject])
    func handleSurveyLoaded(response: [String: AnyObject])
}
