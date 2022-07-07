//
//  QWSurveyView.swift
//  QWarySurvey
//
//  Created by fahid on 30/06/2022.
//

import Foundation
import WebKit

public class QWSurveyView: UIView, WKScriptMessageHandler, WKNavigationDelegate {
    // MARK: Properties
    
    private var qwWebView: WKWebView = WKWebView()
    private let surveyResponseHandler = WKUserContentController()
    private let loader: UIActivityIndicatorView = UIActivityIndicatorView()
    private var surveyLoaded: String = "surveyLoadStarted"
    private var surveyCompleted: String = "surveyCompleted"
        
    public var surveyDelegate: QWSurveyDelegate!
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addFeedbackView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addFeedbackView()
    }
    
    // MARK: Private methods
    private func addFeedbackView() {
        let config = WKWebViewConfiguration()
        config.userContentController = surveyResponseHandler
        
        qwWebView = WKWebView(frame: bounds, configuration: config)
        surveyResponseHandler.add(self, name: "surveyResponse")
        
        qwWebView.backgroundColor = .gray
        qwWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(qwWebView)
        
        qwWebView.addSubview(loader)
        qwWebView.navigationDelegate = self
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: qwWebView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: qwWebView.centerYAnchor).isActive = true
        loader.hidesWhenStopped = true
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loader.stopAnimating()
    }
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if surveyDelegate != nil {
            
            print(message.body)
            
//            let response = message.body as! [String: AnyObject]
//            let responseType = response["type"] as! String
//            if(responseType == surveyLoaded){
//                surveyDelegate.handleSurveyLoaded(response: response)
//            }
//            if(responseType == surveyCompleted){
//                surveyDelegate.handleSurveyResponse(response: response)
//            }
        }
    }
    
    // MARK: Public method
    public func loadSurvey(request: QWSurveyRequest) {
        guard let url = request.url else {
            print("Error: Request URL can not be nil")
            return
        }
        loader.startAnimating()
        let urlRequest = URLRequest(url: url)
        qwWebView.load(urlRequest)
    }
}
