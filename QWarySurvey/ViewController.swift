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
    private var observer: NSObjectProtocol?
    
    // MARK: Properties
    var request: QWSurveyRequest {
        var params = [String:String]()
        params["email"] = "jondoe2@acmeinc.com"
        params["planId"] = "trial2"
        let request = QWSurveyRequest(scheme: "https", host: "survey.qwary.com", path: "/form/S_wSzSPnasH9Wc_FT15X0J1BuEcPl5gIZ99rQiotQa8=", params: params)
        return request
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        observer = NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] notification in
            guard let self = self else { return }
            // do whatever you want when the app is brought back to the foreground
            self.configureScheduleSurvey()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureScheduleSurvey()
    }
    
    private func configureScheduleSurvey() {
        let qwSurvey = QWSurvey(request: request, delegate: self, configurations: QWScheduleConfigurations.testConfigs)
        qwSurvey.scheduleSurvey(parent: self)
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

