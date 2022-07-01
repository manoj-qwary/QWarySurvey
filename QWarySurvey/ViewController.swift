//
//  ViewController.swift
//  QWarySurvey
//
//  Created by fahid on 27/06/2022.
//

import UIKit

class ViewController: UIViewController, QWSurveyDelegate {
    // MARK: Connection
    @IBOutlet weak var ssSurveyView: QWSurveyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let surveySparrow = QWSurvey(domain: "<account-domain>", token: "<sdk-token>")
//        surveySparrow.scheduleSurvey(parent: self)
    }
    
    // MARK: Actions
    
    var request: QWSurveyRequest {
        var params = [String:String]()
        params["email"] = "jondoe2@acmeinc.com"
        params["planId"] = "trial2"
        let request = QWSurveyRequest(scheme: nil, host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIqL_BUyxSxNs=", params: params)
//        let request = QWSurveyRequest(scheme: nil, host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIIuNbg4BYlK8=", params: params)
        return request
    }
    
    @IBAction func startFullscreenSurvey(_ sender: UIButton) {
        let qwSurveyViewController = QWSurveyViewController(request: self.request)
        qwSurveyViewController.surveyDelegate = self
        present(qwSurveyViewController, animated: true, completion: nil)
    }
    
    @IBAction func showEmbeddedSurvey(_ sender: UIButton) {
        ssSurveyView.loadSurvey(request: self.request)
    }
    
    func handleSurveyResponse(response: [String : AnyObject]) {
        print(response)
    }
    
    func handleSurveyLoaded(response: [String : AnyObject]){
        print(response)
    }
}

