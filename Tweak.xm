#import "Tweak.h"

/*
Rundown: we generate new lockscreen pages from an array of app bundle ids.

*/

void openApp() {
  [[%c(SBLockScreenManager) sharedInstance] unlockUIFromSource:17
                                                              withOptions:nil];
}

// Cover Sheet page subclass
// (https://theapplewiki.com/wiki/Dev:CSPageViewController)
%subclass OlympusPageViewController : CSPageViewController
%property(nonatomic, retain) NSString *bundleID;
%property(nonatomic, retain) UIImageView *appIconView;
%property(nonatomic, retain) NSTimer *launchTimer;

// Used for scrolling date/time and other elements away when you swipe the page
- (void)aggregateAppearance:(CSAppearance *)arg0 {
  %orig;

  // CSComponent *pageControl =
  //     [[%c(CSComponent) pageControl] hidden:YES];
  CSComponent *pageContent = [[%c(CSComponent) pageContent] flag:0];
  CSComponent *dateView = [[%c(CSComponent) dateView] hidden:YES];
  CSComponent *wallpaper = [[%c(CSComponent) wallpaper] hidden:NO];
  CSComponent *footerCallToActionLabel =
      [[%c(CSComponent) footerCallToActionLabel] hidden:YES];
  CSComponent *homeAffordance = [[[[%c(CSComponent) homeAffordance]
      identifier:[self appearanceIdentifier]] value:@(YES)] hidden:YES];
  CSComponent *controlCenterGrabber =
      [[%c(CSComponent) controlCenterGrabber] hidden:YES];
  CSComponent *statusBar = [[%c(CSComponent) statusBar] hidden:YES];
  CSComponent *proudLock =
      [[[%c(CSComponent) proudLock] flag:1] hidden:YES];

  // Usually uses CSBoundsWidth for CGPoint
  // x value but the value seemed insanely high
  // CSComponent *slideableContent = [%c(CSComponent)
  // slideableContent]; [slideableContent setOffset:CGPointMake(10000000, 0.0)];

  CSComponent *tinting = [%c(CSComponent) tinting];
  [tinting setHidden:YES];
  CSComponent *statusBarBackground = [[[%c(CSComponent)
      statusBarBackground] identifier:[self appearanceIdentifier]] flag:0];
  [statusBarBackground setHidden:NO];
  CSComponent *quickActions =
      [[%c(CSComponent) quickActions] flag:0];
  // [arg0 addComponent:pageControl];
  [arg0 addComponent:pageContent];
  [arg0 addComponent:dateView];
  [arg0 addComponent:wallpaper];
  [arg0 addComponent:footerCallToActionLabel];
  [arg0 addComponent:homeAffordance];
  [arg0 addComponent:controlCenterGrabber];
  [arg0 addComponent:statusBar];
  [arg0 addComponent:proudLock];
  // [arg0 addComponent:slideableContent];
  [arg0 addComponent:tinting];
  [arg0 addComponent:statusBarBackground];
  [arg0 addComponent:quickActions];
}

- (void)aggregateBehavior:(CSBehavior *)arg0 {
  %orig(arg0);

  //* setScrollingStrategy
  // 3 = camera page behavior (horizontal scrolling disabled)
  // 1 = idk
  // 0 = idk
  [arg0 setScrollingStrategy:0];
  [arg0 setIdleTimerDuration:7];
  [arg0 setIdleWarnMode:2];
  [arg0 setIdleTimerMode:1];
}

- (void)didTransitionToVisible:(BOOL)arg0 {
  %orig;
  NSLog(@"[CSRE] didTransition");
  if (arg0) {
    appToLaunch = self.bundleID; // Set the bundle id that should be launching
                                 // when timer is over
    launchTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                   target:self
                                                 selector:@selector(launchApp)
                                                 userInfo:nil
                                                  repeats:NO];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  %orig;
  self.appIconView = [[UIImageView alloc]
      initWithImage:[UIImage
                        _applicationIconImageForBundleIdentifier:self.bundleID
                                                          format:3
                                                           scale:[[UIScreen
                                                                     mainScreen]
                                                                     scale]]];
  self.appIconView.translatesAutoresizingMaskIntoConstraints = NO;
  [self.appIconView setAlpha:1.0];
  [self.view addSubview:self.appIconView];

  [NSLayoutConstraint activateConstraints:@[
    [self.appIconView.centerXAnchor
        constraintEqualToAnchor:self.view.centerXAnchor],
    [self.appIconView.centerYAnchor
        constraintEqualToAnchor:self.view.centerYAnchor],
    [self.appIconView.widthAnchor constraintEqualToConstant:100],
    [self.appIconView.heightAnchor constraintEqualToConstant:100],
  ]];
}

- (void)viewDidAppear:(BOOL)animated {
  %orig;
  // This animation is supposed to slowly fade the app icon as the timer counts
  // down but it works half the time
  [UIView animateWithDuration:3.0
                        delay:0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     [self.appIconView setAlpha:0.0];
                   }
                   completion:nil];
}

// When we swipe to a new page we want to cancel the last page's animation and
// app launching
- (void)viewWillDisappear:(BOOL)animated {
  %orig;
  [self.appIconView.layer removeAllAnimations];
  [launchTimer invalidate];
  launchTimer = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
  %orig;
  self.appIconView = nil;
}

%new
- (void)launchApp {
  // NSLog(@"[CSRE] launch %@", appToLaunch);
  openApp(); // Prompt device to unlock and launch app
}
%end

// Credit: MegaDev from JellyLock-Reborn
%hook SBDashBoardBiometricUnlockController
- (void)setAuthenticated:(BOOL)authenticated {
  %orig;
  if (authenticated && appToLaunch != nil) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC),
                   dispatch_get_main_queue(), ^{
                     [[UIApplication sharedApplication]
                         launchApplicationWithIdentifier:appToLaunch
                                               suspended:NO];
                     appToLaunch =
                         nil; // Reset, so we don't start launching apps
                              // randomly when we put in our password
                   });
  }
}
%end

//! Todo: instead of disabling today view
//! CHECK PAGE INDEX IF WE'RE ON MAIN PAGE AND ALLOW TODAY VIEW SWIPE

// This class in in charge of laying out the pages
// The two default pages are the camera and main page with your notifications on
// it (today view is a separate overlay now I think cause it's not in this
// array)
@interface CSCoverSheetViewController : UIViewController
@end

%hook CSCoverSheetViewController
- (id)initWithPageViewControllers:(id)arg0
    mainPageContentViewController:(id)arg1
                          context:(id)arg2 {
  // Lockscreen page array
  NSMutableArray *pages = [arg0 mutableCopy];

  // App bundle id array (will be provided by preference bundle)
  NSMutableArray *apps = [NSMutableArray arrayWithArray:@[
    @"com.apple.mobiletimer", @"com.apple.Preferences", @"com.apple.news"
  ]];

  if (apps.count == 0)
    return %orig;

  // Remove the camera page (ig we don't have to do this, I can add an option
  // for it)
  [pages removeLastObject];

  for (int i = 0; i < apps.count; i++) { // For each app create a new page
    NSString *bundleID = apps[i];
    OlympusPageViewController *pageViewController =
        [[%c(OlympusPageViewController) alloc] init];
    pageViewController.bundleID = bundleID;
    [pages addObject:pageViewController];
  }
  return %orig(pages, arg1, arg2);
}
%end

// Disable today view because it presents itself everytime you try to swipe back
// a page
%hook SBMainDisplayPolicyAggregator
- (BOOL)_allowsCapabilityLockScreenTodayViewWithExplanation:(id)arg0 {
  return NO;
}
%end

%ctor {
  NSLog(@"[CSRE] Log test");
}
