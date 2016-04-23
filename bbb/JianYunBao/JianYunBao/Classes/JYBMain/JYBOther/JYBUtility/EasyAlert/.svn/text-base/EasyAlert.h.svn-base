/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

#import <UIKit/UIKit.h>

@interface EasyAlert : NSObject

+ (void) ask: (void(^)(NSString * answer)) block question: (NSString *) question withTextPrompt: (NSString *) prompt;
+ (void) ask: (void(^)(NSUInteger answer)) block question: (NSString *) question withCancel: (NSString *) cancelButtonTitle withButtons: (NSArray *) buttons;
+ (void) say: (id)formatstring,...;
+ (void) say: (void(^)()) block message: (id)formatstring,...;
+ (void) ask: (void(^)(BOOL answer)) block question: (id)formatstring,...;
+ (void) confirm: (void(^)()) block question: (id)formatstring,...;

@end
