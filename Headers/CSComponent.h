// Headers generated with ktool v1.4.0
// https://github.com/cxnder/ktool | pip3 install k2l
// Platform: IOS | Minimum OS: 15.2.0 | SDK: 15.2.0

#ifndef CSCOMPONENT_H
#define CSCOMPONENT_H

@class UIColor, NSString, _UILegibilitySettings, NSNumber, UIView;

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// #import "NSCopying-Protocol.h"

@interface CSComponent : NSObject <NSCopying>

@property(nonatomic) CGFloat alpha;                // ivar: _alpha
@property(retain, nonatomic) UIColor *color;       // ivar: _color
@property(nonatomic) NSInteger flag;               // ivar: _flag
@property(nonatomic, getter=isHidden) BOOL hidden; // ivar: _hidden
@property(copy, nonatomic) NSString *identifier;   // ivar: _identifier
@property(retain, nonatomic)
    _UILegibilitySettings *legibilitySettings; // ivar: _legibilitySettings
@property(nonatomic) CGPoint offset;           // ivar: _offset
@property(nonatomic) NSInteger priority;       // ivar: _priority
@property(nonatomic) NSUInteger properties;    // ivar: _properties
@property(copy, nonatomic) NSString *string;   // ivar: _string
@property(nonatomic) NSInteger type;           // ivar: _type
@property(retain, nonatomic) NSNumber *value;  // ivar: _value
@property(retain, nonatomic) UIView *view;     // ivar: _view

+ (id)background;
+ (id)componentWithType:(NSInteger)arg0;
+ (id)controlCenterGrabber;
+ (id)dateView;
+ (id)footerCallToActionLabel;
+ (id)footerStatusLabel;
+ (id)homeAffordance;
+ (id)pageContent;
+ (id)pageControl;
+ (id)poseidon;
+ (id)proudLock;
+ (id)quickActions;
+ (id)scalableContent;
+ (id)slideableContent;
+ (id)statusBar;
+ (id)statusBarBackground;
+ (id)statusBarGradient;
+ (id)tinting;
+ (id)wallpaper;
+ (id)whitePoint;
- (BOOL)hasValueForProperty:(NSUInteger)arg0;
- (BOOL)isEqual:(id)arg0;
- (NSUInteger)hash;
- (id)color:(id)arg0;
- (id)copyWithZone:(struct _NSZone *)arg0;
- (id)description;
- (id)descriptionBuilderWithMultilinePrefix:(id)arg0;
- (id)descriptionWithMultilinePrefix:(id)arg0;
- (id)flag:(NSInteger)arg0;
- (id)hidden:(BOOL)arg0;
- (id)identifier:(id)arg0;
- (id)init;
- (id)legibilitySettings:(id)arg0;
- (id)offset:(struct CGPoint)arg0;
- (id)priority:(NSInteger)arg0;
- (id)string:(id)arg0;
- (id)succinctDescription;
- (id)succinctDescriptionBuilder;
- (id)value:(id)arg0;
- (id)view:(id)arg0;
- (void)resetAllProperties;

@end

#endif
