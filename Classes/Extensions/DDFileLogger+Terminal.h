//
//  DDFileLogger+Terminal.h
//  CocoaLumberjack
//
//  Created by Linzh on 9/3/17.
//
//

#import "DDFileLogger.h"

NS_ASSUME_NONNULL_BEGIN

@interface DDLogFileManagerTerminal : DDLogFileManagerDefault

@end

#ifdef SRCROOT
#if TARGET_OS_SIMULATOR
@interface DDFileLogger (Terminal)

- (instancetype)initForTerminal;

@end
#endif
#endif

NS_ASSUME_NONNULL_END
