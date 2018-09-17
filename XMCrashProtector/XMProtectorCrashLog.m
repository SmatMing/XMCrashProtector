//
//  XMProtectorCrashLog.m
//  XMSafeProtector
//
//  Created by xuzhangming on 2018/9/11.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "XMProtectorCrashLog.h"

static const NSString *XMCrashSeparatorWithFlag = @"********* XMCrashProtector **********";

@implementation XMProtectorCrashLog

//打印crash信息
+ (void)logCrashWithException:(NSException *)exception
                        block:(void(^)(NSString *logError))block {
    // 堆栈数据
    NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
    
    //一般来说第3个位置就是crash位置,有部分会先调用构造方法的就会在第4个位置
    int index = 3;
    NSString *libarayStr = [self getLibraryNameWithCallStackSymbolStr:callStackSymbolsArr[index]];
    BOOL isBool = [libarayStr isEqualToString:@"CoreFoundation"];
    while (isBool) {
        index += 1;
        libarayStr = [self getLibraryNameWithCallStackSymbolStr:callStackSymbolsArr[index]];
        isBool = [libarayStr isEqualToString:@"CoreFoundation"];
    }
    //获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = [self getMainMessageWithCallStackSymbolStr:callStackSymbolsArr[index]];
    
    if (mainCallStackSymbolMsg == nil) {
        mainCallStackSymbolMsg = @"Crash location failed, see the function call stack to troubleshoot the error.";
    }
    NSString *crashName = [NSString stringWithFormat:@"********* [Crash Type]: %@",exception.name];
    NSString *errorReason = [NSString stringWithFormat:@"********* [Crash Reason]: %@",exception.reason];;
    NSString *errorPlace = [NSString stringWithFormat:@"********* [Error Place]: %@",mainCallStackSymbolMsg];
    NSString *logErrorMessage = [NSString stringWithFormat:@"\n\n%@\n\n%@\n%@\n%@\n%@\n",XMCrashSeparatorWithFlag, crashName, errorReason, errorPlace, exception.callStackSymbols];
    if (block) {
        block(logErrorMessage);
    }
}

//截取堆栈文件名称
+ (NSString *)getLibraryNameWithCallStackSymbolStr:(NSString *)callStackSymbolStr {
    NSString *libraryStr = nil;
    NSArray *tempArray = [callStackSymbolStr componentsSeparatedByString:@"0x"];
    if (tempArray.count == 0) {
        return libraryStr;
    }
    NSString *str = [tempArray firstObject];
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    libraryStr = [temp substringFromIndex:1];
    
    return libraryStr;
}

/**
 *  获取堆栈主要崩溃精简化的信息<根据正则表达式匹配出来>
 *  @param callStackSymbolStr 堆栈主要崩溃信息
 *  @return 堆栈主要崩溃精简化的信息
 */
+ (NSString *)getMainMessageWithCallStackSymbolStr:(NSString *)callStackSymbolStr {
    
    //正则表达式
    //http://www.jianshu.com/p/b25b05ef170d
    
    //mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    //匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    [regularExp enumerateMatchesInString:callStackSymbolStr options:NSMatchingReportProgress range:NSMakeRange(0, callStackSymbolStr.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (result) {
            mainCallStackSymbolMsg = [callStackSymbolStr substringWithRange:result.range];
            *stop = YES;
        }
    }];
    
    return mainCallStackSymbolMsg;
}


@end
