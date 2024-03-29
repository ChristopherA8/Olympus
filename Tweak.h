#import "Headers/CSBehavior.h"
#import "Headers/CSComponent.h"
#import "Headers/UIImage+appIcon.h"
#import <Foundation/Foundation.h>
#import <Cephei/HBPreferences.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

HBPreferences *preferences = nil;
BOOL enabled;
BOOL appLabels;

NSTimer *launchTimer;
NSArray *appBundleIds;
double launchTime;
BOOL allowTodayView;

@interface SBLockScreenManager
+ (id)sharedInstance;
- (BOOL)unlockUIFromSource:(int)arg1 withOptions:(id)arg2;
@end

@interface UIApplication ()
- (BOOL)launchApplicationWithIdentifier:(NSString *)arg0 suspended:(BOOL)arg1;
@end

@interface CSAppearance
- (void)addComponent:(id)arg0;
@end

@interface CSPageViewController : UIViewController
- (NSInteger)requestedDismissalType;
- (id)requestedDismissalSettings;
- (BOOL)authenticated;
- (void)willTransitionToVisible:(BOOL)arg0;
- (void)didTransitionToVisible:(BOOL)arg0;
@end

@interface CSCoverSheetViewController : UIViewController
@end

@interface OlympusPageViewController : CSPageViewController
@property(readonly, copy, nonatomic) NSString *appearanceIdentifier;

// %property
@property(nonatomic, retain) NSString *bundleID;
@property(nonatomic, retain) UIImageView *appIconView;
@property(nonatomic, retain) UILabel *appLabel;

// %new
- (void)setColor:(UIColor *)arg0;
- (void)launchApp;
@end

@interface LSApplicationProxy : NSObject
+ (id)applicationProxyForIdentifier:(id)arg1;
- (NSString *)localizedNameForContext:(id)arg1;
@end
