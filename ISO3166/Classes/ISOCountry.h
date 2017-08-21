//
//  ISOCountry.h
//  Pods
//
//  Created by 李翔宇 on 2017/8/21.
//
//

#import <Foundation/Foundation.h>

@interface ISOCountry : NSObject

@property (nonatomic, strong, readonly) NSString *code;/**<二位字母代码*/
@property (nonatomic, strong, readonly) NSString *code3;/**<三位字母代码*/
@property (nonatomic, strong, readonly) NSString *number;/**<二位数字代码*/
@property (nonatomic, strong, readonly) NSString *cName;/**<中文国家名称*/
@property (nonatomic, strong, readonly) NSString *eName;/**<英文国家名称*/

@property (class, nonatomic, strong, readonly) NSArray<ISOCountry *> *countries;

/**
 通过字母代码查询国家，支持二位和三位

 @param code 字母代码
 @return ISOCountry对象或nil
 */
+ (ISOCountry *)countryOfCode:(NSString *)code;

/**
 通过数字代码查询国家
 
 @param number 数字代码
 @return ISOCountry对象或nil
 */
+ (ISOCountry *)countryOfNumber:(NSString *)number;

@end
