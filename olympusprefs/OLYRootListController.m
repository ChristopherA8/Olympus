#import "OLYRootListController.h"
#import <Foundation/Foundation.h>

@implementation OLYRootListController

- (instancetype)init {
  self = [super init];

  if (self) {
    self.respringButton =
        [[UIBarButtonItem alloc] initWithTitle:@"Respring"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(respring)];
    self.navigationItem.rightBarButtonItem = self.respringButton;
  }

  return self;
}

- (NSArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
  }

  return _specifiers;
}

- (void)respring {
  [HBRespringController respring];
}

- (void)discord {
  NSURL *discord = [NSURL URLWithString:@"https://discord.gg/zHN7yuGqYr"];
  [[UIApplication sharedApplication] openURL:discord
                                     options:@{}
                           completionHandler:nil];
}

- (void)paypal {
  NSURL *paypal = [NSURL URLWithString:@"https://paypal.me/Chr1sDev"];
  [[UIApplication sharedApplication] openURL:paypal
                                     options:@{}
                           completionHandler:nil];
}

- (void)sourceCode {
  NSURL *source =
      [NSURL URLWithString:@"https://github.com/ChristopherA8/Olympus"];
  [[UIApplication sharedApplication] openURL:source
                                     options:@{}
                           completionHandler:nil];
}

- (void)website {
  NSURL *source = [NSURL URLWithString:@"https://christopher.jp.net"];
  [[UIApplication sharedApplication] openURL:source
                                     options:@{}
                           completionHandler:nil];
}

@end
