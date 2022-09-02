//
//  BridgingTest.m
//  QWarySurvey
//
//  Created by fahid on 09/08/2022.
//

#import "BridgingTest.h"
#import "QWarySurvey-Swift.h"

@implementation BridgingTest

-(void)testBridgingFromSwiftToObjectiveC {
    
    //  Test 0
    QWSurveyRequest * requestFromString = [[QWSurveyRequest alloc] initWithJsonString:@""];
    
    //  Test 1
    QWSurveyRequest * request = [[QWSurveyRequest alloc] initWithScheme:@"https" host:@"host" path:@"asd" params:@{@"key" : @"value"}];
    
    //  Test 2
    QWSurveyViewController * controller = [[QWSurveyViewController alloc] initWithRequest:request delegate:self];

    //  Test 3
    QWSurveyView * surveyView = [[QWSurveyView alloc] init];
    [surveyView loadSurveyWithRequest:request delegate:self];
        
    //  Test 4
    QWSurvey * survey = [[QWSurvey alloc] initWithRequest:request delegate:self configurations:QWScheduleConfigurations.testConfigs];
    [survey scheduleSurveyWithParent:controller];

    //  Test 5
    QWScheduleConfigurations * configs = [[QWScheduleConfigurations alloc] initWithStartDate:[NSDate date] repeatSurvey:YES repeatInterval:30.0];
    
    //  Test 6
    [[NotificationsManager shared] scheduleNotificationWithRequest:request configs:QWScheduleConfigurations.testConfigs nextPromptDate:[NSDate date]];

    //  Test 7
    UIViewController * root = [UIApplication sharedApplication].keyWindow.rootViewController;
    [root presentViewController:controller animated:TRUE completion:nil];

}

@end
