/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVUserAgentUtil.h"

#import <UIKit/UIKit.h>

static NSString * const kCdvUserAgentKey = @"Cordova-User-Agent";
static NSString * const kCdvUserAgentVersionKey = @"Cordova-User-Agent-Version";

static inline NSString *SystemAndLocale(void) {
    NSString* systemVersion = [UIDevice currentDevice].systemVersion;
    NSString* localeStr = [NSLocale currentLocale].localeIdentifier;
    // Record the model since simulator can change it without re-install (CB-5420).
    NSString* model = [UIDevice currentDevice].model;
    return [NSString stringWithFormat:@"%@ %@ %@", model, systemVersion, localeStr];
}

@interface CDVUserAgentUtil ()

@property (atomic, copy) NSString *originalUserAgent;

@end

@implementation CDVUserAgentUtil

+ (instancetype)_sharedUtil
{
    static CDVUserAgentUtil *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [self new];
    });
    return util;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *systemAndLocale = SystemAndLocale();
        if (![systemAndLocale isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:kCdvUserAgentVersionKey]]) {
            [self _setUpUserAgentWithSystemAndLocale:systemAndLocale];
        } else {
            _originalUserAgent = [[NSUserDefaults standardUserDefaults] stringForKey:kCdvUserAgentKey];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppLocaleDidChange:) name:NSCurrentLocaleDidChangeNotification object:nil];
    }
    return self;
}

- (void)_setUpUserAgentWithSystemAndLocale:(NSString *)systemAndLocale
{
    UIWebView *sampleWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _originalUserAgent = [sampleWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_originalUserAgent forKey:kCdvUserAgentKey];
    [[NSUserDefaults standardUserDefaults] setObject:systemAndLocale forKey:kCdvUserAgentVersionKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)onAppLocaleDidChange:(NSNotification*)notification
{
    // TODO: We should figure out how to update the user-agent of existing UIWebViews when this happens.
    // Maybe use the PDF bug (noted in setUserAgent:).
    [[CDVUserAgentUtil _sharedUtil] _setUpUserAgentWithSystemAndLocale:SystemAndLocale()];
}

+ (NSString *)originalUserAgent
{
    return [CDVUserAgentUtil _sharedUtil].originalUserAgent;
}

+ (NSString *)customUserAgent
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"UserAgent"];
}

+ (void)setCustomUserAgent:(NSString *)customUserAgent
{
    if (customUserAgent.length) {
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"UserAgent": customUserAgent }];
    } else {
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"UserAgent": [CDVUserAgentUtil _sharedUtil].originalUserAgent }];
    }
}

@end
