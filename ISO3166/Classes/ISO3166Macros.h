//
//  ISO3166Macros.h
//  Pods
//
//  Created by 李翔宇 on 2017/8/21.
//
//

#ifndef ISO3166Macros_h
#define ISO3166Macros_h

#if DEBUG
    #define ISO3166Log(_Format, ...)\
    do {\
        NSString *file = [NSString stringWithUTF8String:__FILE__].lastPathComponent;\
        NSLog((@"\n[%@][%d][%s]\n" _Format), file, __LINE__, __PRETTY_FUNCTION__, ## __VA_ARGS__);\
        printf("\n");\
    } while(0)
#else
    #define ISO3166Log(_Format, ...)
#endif

#endif /* ISO3166Macros_h */
