//
//  ISOCountry.m
//  Pods
//
//  Created by 李翔宇 on 2017/8/21.
//
//

#import "ISOCountry.h"
#import "ISO3166Macros.h"

typedef NS_ENUM(NSUInteger, ISOCountryItem) {
    ISOCountryItemCode,
    ISOCountryItemCode3,
    ISOCountryItemNumber,
    ISOCountryItemCName,
    ISOCountryItemEName,
};

@interface ISOCountry ()

@property (nonatomic, strong) NSString *code;/**<二位字母代码*/
@property (nonatomic, strong) NSString *code3;/**<三位字母代码*/
@property (nonatomic, strong) NSString *number;/**<二位数字代码*/
@property (nonatomic, strong) NSString *cName;/**<中文国家名称*/
@property (nonatomic, strong) NSString *eName;/**<英文国家名称*/

@end

@implementation ISOCountry

+ (NSArray<ISOCountry *> *)countries {
    static NSMutableArray<ISOCountry *> *sharedInstances = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstances = [NSMutableArray array];
        
        NSBundle *currentBundle = [NSBundle bundleForClass:[self class]];
        NSString *path = [currentBundle pathForResource:@"ISO国家信息" ofType:@"txt"];
        
        NSError *error = nil;
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if(!content.length) {
            if(error) {
                ISO3166Log(@"%@", error);
            }
        }
        
        NSArray<NSString *> *components = [content componentsSeparatedByString:@"\n"];
        for(NSString *component in components) {
            NSArray<NSString *> *items = [component componentsSeparatedByString:@":"];
            
            if(items.count < 5) {
                continue;
            }
            
            ISOCountry *country = [[ISOCountry alloc] init];
            country.code = items[ISOCountryItemCode];
            country.code3 = items[ISOCountryItemCode3];
            country.number = items[ISOCountryItemNumber];
            country.cName = items[ISOCountryItemCName];
            country.eName = items[ISOCountryItemEName];
            
            [sharedInstances addObject:country];
        }
    });
    return [sharedInstances copy];
}

/**
 通过字母代码查询国家，支持二位和三位
 
 @param code 字母代码
 @return ISOCountry对象或nil
 */
+ (ISOCountry *)countryOfCode:(NSString *)code {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code == %@ OR code3 == %@", code, code];
    NSArray<ISOCountry *> *countries = [self.countries filteredArrayUsingPredicate:predicate];
    return countries.lastObject;
}

/**
 通过数字代码查询国家
 
 @param number 数字代码
 @return ISOCountry对象或nil
 */
+ (ISOCountry *)countryOfNumber:(NSString *)number {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number == %@", number];
    NSArray<ISOCountry *> *countries = [self.countries filteredArrayUsingPredicate:predicate];
    return countries.lastObject;
}

@end
