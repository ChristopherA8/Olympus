#import "Tweak.h"

/*
Rundown: we generate new lockscreen pages from an array of app bundle ids.
*/

// Cover Sheet page subclass
// (https://theapplewiki.com/wiki/Dev:CSPageViewController)
%subclass OlympusPageViewController : CSPageViewController
%property(nonatomic, retain) NSString *bundleID;
%property(nonatomic, retain) UIImageView *appIconView;
%property(nonatomic, retain) NSTimer *launchTimer;
%property(nonatomic, retain) UILabel *appLabel;

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

- (void)viewDidLoad {
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

  // add a toggle for app labels or nah
  self.appLabel = [[UILabel alloc] init];
  self.appLabel.translatesAutoresizingMaskIntoConstraints = NO;
  self.appLabel.text = [[LSApplicationProxy
      applicationProxyForIdentifier:self.bundleID] localizedNameForContext:nil];
  self.appLabel.textColor = [UIColor whiteColor];
  self.appLabel.textAlignment = NSTextAlignmentCenter;
  self.appLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightRegular];
  [self.view addSubview:self.appLabel];

  [NSLayoutConstraint activateConstraints:@[
    [self.appLabel.centerXAnchor
        constraintEqualToAnchor:self.view.centerXAnchor],
    [self.appLabel.topAnchor
        constraintEqualToAnchor:self.appIconView.bottomAnchor
                       constant:10],
    [self.appLabel.widthAnchor constraintEqualToConstant:200],
    [self.appLabel.heightAnchor constraintEqualToConstant:30],
  ]];
}

- (void)didTransitionToVisible:(BOOL)arg0 {
  %orig;
  if (!arg0)
    return;
  launchTimer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(launchApp)
                                               userInfo:nil
                                                repeats:NO];
}

- (void)viewWillAppear:(BOOL)animated {
  %orig;

  allowTodayView = NO;
  [self.appIconView setAlpha:1.0];
  [self.appLabel setAlpha:1.0];

  [UIView animateWithDuration:3.0
                        delay:0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     [self.appIconView setAlpha:0.0];
                     [self.appLabel setAlpha:0.0];
                   }
                   completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
  %orig;
  if (self.appIconView.alpha < 1.0 && self.appLabel.alpha < 1.0) {
    [UIView animateWithDuration:3.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                       [self.appIconView setAlpha:0.0];
                     }
                     completion:nil];
  }
}

// When we swipe to a new page we want to cancel the last page's animation and
// app launching
- (void)viewWillDisappear:(BOOL)animated {
  %orig;
  [self.appIconView.layer removeAllAnimations];
  [self.appIconView setAlpha:1.0];
  [self.appLabel setAlpha:1.0];
  [launchTimer invalidate];
  launchTimer = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
  %orig;
  [self.appIconView setAlpha:0.0];
  [self.appLabel setAlpha:0.0];
}

%new
- (void)launchApp {
  bool success = [[%c(SBLockScreenManager) sharedInstance]
      unlockUIFromSource:17
             withOptions:nil];
  if (!success) {
    NSLog(@"[OLYMPUS] Failed to unlock device");
    return;
  }
  [[UIApplication sharedApplication]
      launchApplicationWithIdentifier:self.bundleID
                            suspended:NO];
}
%end

// This class in in charge of laying out the pages
// The two default pages are the camera and main page with your notifications on
// it
// (the today view is a separate overlay now I think cause it's not in this
// array)

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

  // For each app bundleID create a new page
  for (int i = 0; i < apps.count; i++) {
    NSString *bundleID = apps[i];
    OlympusPageViewController *pageViewController =
        [[%c(OlympusPageViewController) alloc] init];
    pageViewController.bundleID = bundleID;
    [pages addObject:pageViewController];
  }
  return %orig(pages, arg1, arg2);
}
%end

// If we're on the main lockscreen page, allow scrolling to today view to open
%hook CSMainPageContentViewController
- (void)viewDidAppear:(BOOL)animated {
  %orig;
  allowTodayView = YES;
}
%end

// Disable today view if we're not on main lockscreen page
%hook SBMainDisplayPolicyAggregator
- (BOOL)_allowsCapabilityLockScreenTodayViewWithExplanation:(id)arg0 {
  return allowTodayView;
}
%end

// Preference values and setup
%ctor {
}
