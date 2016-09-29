//
//  CDVConfiguration.h
//  Pods
//
//  Created by Junzhe Huang on 28/09/2016.
//
//

#import <Foundation/Foundation.h>

@interface CDVConfiguration : NSObject

+ (void)registerPlugins:(NSDictionary<NSString *, NSString *> *)pluginsDict;
+ (void)registerSettings:(NSMutableDictionary<NSString *, NSString *> *)settings;
+ (void)registerStartupPluginNames:(NSMutableArray<NSString *> *)startupPluginNames;
+ (void)registerPluginMethods:(NSDictionary<NSString *, NSArray<NSString *> *> *)pluginMethodsDict;

+ (NSDictionary<NSString *, NSString *> *)pluginsDict;
+ (NSMutableDictionary<NSString *, NSString *> *)settings;
+ (NSMutableArray<NSString *> *)startupPluginNames;
+ (NSDictionary<NSString *, NSArray<NSString *> *> *)pluginMethodsDict;

@end
