//
//  DDFileLogger+Terminal.m
//  CocoaLumberjack
//
//  Created by Linzh on 9/3/17.
//
//

#import "DDFileLogger+Terminal.h"

static NSString *const kTerminalLogFilePrefix = @"tail-f";

@interface DDLogFileManagerDefault ()
- (NSDateFormatter *)logFileDateFormatter;
@end

@implementation DDLogFileManagerTerminal

#ifdef SRCROOT
#if TARGET_OS_SIMULATOR
- (instancetype)init {
    #define MACRO_NAME(key) #key
    #define MACRO_VALUE(key) MACRO_NAME(key)
    NSString *filePath = [NSString stringWithFormat:@"%s", MACRO_VALUE(SRCROOT)];
    NSURL *url = [[[NSURL URLWithString:filePath] URLByDeletingLastPathComponent] URLByAppendingPathComponent:@"Log" isDirectory:YES];
    
    return [self initWithLogsDirectory:url.absoluteString];
}
#else
    #undef SRCROOT
#endif
#endif

- (NSString *)newLogFileName {
    NSDateFormatter *dateFormatter = [self logFileDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@_%@.log", kTerminalLogFilePrefix, formattedDate];
}

- (BOOL)isLogFile:(NSString *)fileName {
    BOOL hasProperPrefix = [fileName hasPrefix:kTerminalLogFilePrefix];
    BOOL hasProperSuffix = [fileName hasSuffix:@".log"];
    
    return (hasProperPrefix && hasProperSuffix);
}

@end

#ifdef SRCROOT
#if TARGET_OS_SIMULATOR
@implementation DDFileLogger (Terminal)

- (instancetype)initForTerminal {
    DDLogFileManagerTerminal *manager = [[DDLogFileManagerTerminal alloc] init];
    if (self = [self initWithLogFileManager:manager]) {
        self.maximumFileSize = 0;
        self.rollingFrequency = 0;
        self.logFileManager.maximumNumberOfLogFiles = 0;
        self.logFileManager.logFilesDiskQuota = 0;
    }
    
    return self;
}

@end
#endif
#endif
