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

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)]; // 180
    self.headerView.clipsToBounds = YES;
    self.headerView.layer.cornerRadius = 12;
    UIImageView *headerImageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.clipsToBounds = YES;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.layer.cornerRadius = 12;
    // headerImageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
    //                                     UIViewAutoresizingFlexibleLeftMargin
    //                                     |
    //                                     UIViewAutoresizingFlexibleRightMargin);
    headerImageView.image = [UIImage
        imageWithContentsOfFile:
            @"/var/jb/Library/PreferenceBundles/olympusprefs.bundle/banner_pic-min.png"];
    headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.headerView addSubview:headerImageView];

    [NSLayoutConstraint activateConstraints:@[
      // header banner
      [headerImageView.topAnchor
          constraintEqualToAnchor:self.headerView.topAnchor
                         constant:15],
      [headerImageView.leadingAnchor
          constraintEqualToAnchor:self.headerView.leadingAnchor
                         constant:20],
      [headerImageView.trailingAnchor
          constraintEqualToAnchor:self.headerView.trailingAnchor
                         constant:-20],
      [headerImageView.bottomAnchor
          constraintEqualToAnchor:self.headerView.bottomAnchor
                         constant:-15],
    ]];
  }

  return self;
}

- (NSArray *)specifiers {
  if (!_specifiers) {
    _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
  }

  return _specifiers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  tableView.tableHeaderView = self.headerView;
  return [super tableView:tableView cellForRowAtIndexPath:indexPath];
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
