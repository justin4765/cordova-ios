//
//  CDVConfiguration.h
//  Pods
//
//  Created by Junzhe Huang on 28/09/2016.
//
//

#import <Foundation/Foundation.h>

@interface CDVConfiguration : NSObject

+ (void)registerPlugins:(NSDictionary *)pluginsDict;
+ (void)registerSettings:(NSDictionary *)settings;
+ (void)registerStartupPluginNames:(NSDictionary *)startupPluginNames;
+ (void)registerPluginMethods:(NSDictionary *)pluginMethodsDict;

+ (NSDictionary *)pluginsDict;
+ (NSDictionary *)settings;
+ (NSArray *)startupPluginNames;
+ (NSDictionary *)pluginMethodsDict;

@end
