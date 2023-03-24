#import "OLYRootListController.h"

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


/*
		<dict>
			<key>cell</key>
			<string>PSLinkListCell</string>
			<key>detail</key>
			<string>ATLApplicationListMultiSelectionController</string>
			<key>defaults</key>
			<string>com.christopher.olympusprefs</string>
			<key>key</key>
			<string>appBundleIds</string>
			<key>label</key>
			<string>Applications</string>
			<key>sections</key>
			<array>
				<dict>
					<key>sectionType</key>
					<string>Visible</string>
				</dict>
			</array>
			<key>showIdentifiersAsSubtitle</key>
			<true/>
			<key>defaultApplicationSwitchValue</key>
			<false/>
			<key>useSearchBar</key>
			<true/>
		</dict>
*/