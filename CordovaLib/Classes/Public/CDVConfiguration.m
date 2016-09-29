//
//  CDVConfiguration.m
//  Pods
//
//  Created by Junzhe Huang on 28/09/2016.
//
//

#import "CDVConfiguration.h"

static const NSDictionary<NSString *, NSString *> *kPluginsDict;
static const NSMutableDictionary<NSString *, NSString *> *kSettings;
static const NSMutableArray<NSString *> *kStartupPluginNames;
static const NSDictionary<NSString *, NSArray<NSString *> *> *kPluginMethodsDict;

@implementation CDVConfiguration

+ (void)initialize
{
    if (self == [CDVConfiguration class]) {
        kPluginsDict = [NSDictionary dictionary];
        kSettings = [NSMutableDictionary dictionary];
        kStartupPluginNames = [NSMutableArray array];
        kPluginMethodsDict = [NSDictionary dictionary];
    }
}

+ (void)registerPlugins:(NSDictionary<NSString *, NSString *> *)pluginsDict
{
    kPluginsDict = pluginsDict;
}

+ (void)registerSettings:(NSMutableDictionary<NSString *, NSString *> *)settings
{
    kSettings = settings;
}

+ (void)registerStartupPluginNames:(NSMutableArray<NSString *> *)startupPluginNames
{
    kStartupPluginNames = startupPluginNames;
}

+ (void)registerPluginMethods:(NSDictionary<NSString *, NSArray<NSString *> *> *)pluginMethodsDict
{
    kPluginMethodsDict = pluginMethodsDict;
}

+ (NSDictionary<NSString *, NSString *> *)pluginsDict
{
    return kPluginsDict;
}

+ (NSMutableDictionary<NSString *, NSString *> *)settings
{
    return kSettings;
}

+ (NSMutableArray<NSString *> *)startupPluginNames
{
    return kStartupPluginNames;
}

+ (NSDictionary<NSString *, NSArray<NSString *> *> *)pluginMethodsDict
{
    return kPluginMethodsDict;
}

@end
