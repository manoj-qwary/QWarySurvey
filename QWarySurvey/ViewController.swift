//
//  ViewController.swift
//  QWarySurvey
//
//  Created by fahid on 27/06/2022.
//

import UIKit

class ViewController: UIViewController, QWSurveyDelegate {

    // MARK: Connection
    @IBOutlet weak var qwSurveyView: QWSurveyView!

    // MARK: Properties
    var request: QWSurveyRequest {
        var params = [String:String]()
        params["email"] = "jondoe2@acmeinc.com"
        params["planId"] = "trial2"
        let request = QWSurveyRequest(scheme: nil, host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIZ99rQiotQa8=", params: params)
        return request
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let surveySparrow = QWSurvey(request: request, delegate: self)
        surveySparrow.scheduleSurvey(parent: self)
    }
    
    // MARK: Actions
    @IBAction func startFullscreenSurvey(_ sender: UIButton) {
        let qwSurveyViewController = QWSurveyViewController(request: request, delegate: self)
        present(qwSurveyViewController, animated: true, completion: nil)
    }
    
    @IBAction func showEmbeddedSurvey(_ sender: UIButton) {
        qwSurveyView.loadSurvey(request: request, delegate: self)
    }
    
    // MARK: Delegate
    func didReceiveSurveyOutcome(_ state: QWSurveyState) {
        print("Received outcome from survey: \(state)")
    }
    func didRedirectToURL(_ url: String) {
        print("Redirected to url: \(url)")
    }
}

