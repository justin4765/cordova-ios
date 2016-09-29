//
//  CDVConfiguration.m
//  Pods
//
//  Created by Junzhe Huang on 28/09/2016.
//
//

#import "CDVConfiguration.h"

static const NSDictionary *kPluginsDict;
static const NSDictionary *kSettings;
static const NSArray *kStartupPluginNames;
static const NSDictionary *kPluginMethodsDict;

@implementation CDVConfiguration

+ (void)registerPlugins:(NSDictionary *)pluginsDict
{
    kPluginsDict = pluginsDict;
}

+ (void)registerSettings:(NSDictionary *)settings
{
    kSettings = settings;
}

+ (void)registerStartupPluginNames:(NSArray *)startupPluginNames
{
    kStartupPluginNames = startupPluginNames;
}

+ (void)registerPluginMethods:(NSDictionary *)pluginMethodsDict
{
    kPluginMethodsDict = pluginMethodsDict;
}

+ (NSDictionary *)pluginsDict
{
    return kPluginsDict;
}

+ (NSDictionary *)settings
{
    return kSettings;
}

+ (NSArray *)startupPluginNames
{
    return kStartupPluginNames;
}

+ (NSDictionary *)pluginMethodsDict
{
    return kPluginMethodsDict;
}

@end
