#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <MessageUI/MessageUI.h>
#import <CaptainHook.h>

#pragma mark - Interfaces

@interface UIWindow (Private)
- (UIResponder *)firstResponder;
@end

typedef enum PSCellType {
    PSGroupCell,
    PSLinkCell,
    PSLinkListCell,
    PSListItemCell,
    PSTitleValueCell,
    PSSliderCell,
    PSSwitchCell,
    PSStaticTextCell,
    PSEditTextCell,
    PSSegmentCell,
    PSGiantIconCell,
    PSGiantCell,
    PSSecureEditTextCell,
    PSButtonCell,
    PSEditTextViewCell,
} PSCellType;

@interface PSSpecifier : NSObject {
@public
    id target;
    SEL getter;
    SEL setter;
    SEL action;
    Class detailControllerClass;
    PSCellType cellType;
    Class editPaneClass;
    UIKeyboardType keyboardType;
    UITextAutocapitalizationType autoCapsType;
    UITextAutocorrectionType autoCorrectionType;
    int textFieldType;
@private
    NSString *_name;
    NSArray *_values;
    NSDictionary *_titleDict;
    NSDictionary *_shortTitleDict;
    id _userInfo;
    NSMutableDictionary *_properties;
}
@property (retain) NSMutableDictionary *properties;
@property (retain) NSString *identifier;
@property (retain) NSString *name;
@property (retain) id userInfo;
@property (retain) id titleDictionary;
@property (retain) id shortTitleDictionary;
@property (retain) NSArray *values;
+ (id)preferenceSpecifierNamed:(NSString *)title target:(id)target set:(SEL)set get:(SEL)get detail:(Class)detail cell:(PSCellType)cell edit:(Class)edit;
+ (PSSpecifier *)groupSpecifierWithName:(NSString *)title;
+ (PSSpecifier *)emptyGroupSpecifier;
+ (UITextAutocapitalizationType)autoCapsTypeForString:(PSSpecifier *)string;
+ (UITextAutocorrectionType)keyboardTypeForString:(PSSpecifier *)string;
- (id)propertyForKey:(NSString *)key;
- (void)setProperty:(id)property forKey:(NSString *)key;
- (void)removePropertyForKey:(NSString *)key;
- (void)loadValuesAndTitlesFromDataSource;
- (void)setValues:(NSArray *)values titles:(NSArray *)titles;
- (void)setValues:(NSArray *)values titles:(NSArray *)titles shortTitles:(NSArray *)shortTitles;
- (void)setupIconImageWithPath:(NSString *)path;
- (NSString *)identifier;
- (void)setTarget:(id)target;
- (void)setKeyboardType:(UIKeyboardType)type autoCaps:(UITextAutocapitalizationType)autoCaps autoCorrection:(UITextAutocorrectionType)autoCorrection;
@end

@interface PSViewController : UIViewController {
    PSSpecifier *_specifier;
}
@property (retain) PSSpecifier *specifier;
- (id)readPreferenceValue:(PSSpecifier *)specifier;
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier;
- (void)pushController:(UIViewController *)controller animate:(BOOL)animate;
@end

@interface PSListController : PSViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_specifiers;
}
@property (retain, nonatomic) NSArray *specifiers;
- (NSArray *)loadSpecifiersFromPlistName:(NSString *)plistName target:(id)target;
- (PSSpecifier *)specifierForID:(NSString *)identifier;
- (PSSpecifier *)specifierAtIndex:(NSInteger)index;
- (NSArray *)specifiersForIDs:(NSArray *)identifiers;
- (NSArray *)specifiersInGroup:(NSInteger)group;
- (BOOL)containsSpecifier:(PSSpecifier *)specifier;
- (NSInteger)numberOfGroups;
- (NSInteger)rowsForGroup:(NSInteger)group;
- (NSInteger)indexForRow:(NSInteger)row inGroup:(NSInteger)group;
- (BOOL)getGroup:(NSInteger *)group row:(NSInteger *)row ofSpecifier:(PSSpecifier *)specifier;
- (BOOL)getGroup:(NSInteger *)group row:(NSInteger *)row ofSpecifierID:(NSString *)identifier;
- (BOOL)getGroup:(NSInteger *)group row:(NSInteger *)row ofSpecifierAtIndex:(NSInteger )index;
- (void)addSpecifier:(PSSpecifier *)specifier;
- (void)addSpecifiersFromArray:(NSArray *)array;
- (void)addSpecifier:(PSSpecifier *)specifier animated:(BOOL)animated;
- (void)addSpecifiersFromArray:(NSArray *)array animated:(BOOL)animated;
- (void)insertSpecifier:(PSSpecifier *)specifier afterSpecifier:(PSSpecifier *)afterSpecifier;
- (void)insertSpecifier:(PSSpecifier *)specifier afterSpecifierID:(NSString *)afterSpecifierID;
- (void)insertSpecifier:(PSSpecifier *)specifier atIndex:(NSInteger)index;
- (void)insertSpecifier:(PSSpecifier *)specifier atEndOfGroup:(NSInteger)index;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers afterSpecifier:(PSSpecifier *)afterSpecifier;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers afterSpecifierID:(NSString *)afterSpecifierID;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers atIndex:(NSInteger)index;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers atEndOfGroup:(NSInteger)index;
- (void)insertSpecifier:(PSSpecifier *)specifier afterSpecifier:(PSSpecifier *)afterSpecifier animated:(BOOL)animated;
- (void)insertSpecifier:(PSSpecifier *)specifier afterSpecifierID:(NSString *)afterSpecifierID animated:(BOOL)animated;
- (void)insertSpecifier:(PSSpecifier *)specifier atIndex:(NSInteger)index animated:(BOOL)animated;
- (void)insertSpecifier:(PSSpecifier *)specifier atEndOfGroup:(NSInteger)index animated:(BOOL)animated;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers afterSpecifier:(PSSpecifier *)afterSpecifier animated:(BOOL)animated;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers afterSpecifierID:(NSString *)afterSpecifierID animated:(BOOL)animated;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers atIndex:(NSInteger)index animated:(BOOL)animated;
- (void)insertContiguousSpecifiers:(NSArray *)spcifiers atEndOfGroup:(NSInteger)index animated:(BOOL)animated;
- (void)replaceContiguousSpecifiers:(NSArray *)oldSpecifiers withSpecifiers:(NSArray *)newSpecifiers;
- (void)replaceContiguousSpecifiers:(NSArray *)oldSpecifiers withSpecifiers:(NSArray *)newSpecifiers animated:(BOOL)animated;
- (void)removeSpecifier:(PSSpecifier *)specifier;
- (void)removeSpecifierID:(NSString *)identifier;
- (void)removeSpecifierAtIndex:(NSInteger)index;
- (void)removeLastSpecifier;
- (void)removeContiguousSpecifiers:(NSArray *)specifiers;
- (void)removeSpecifier:(PSSpecifier *)specifier animated:(BOOL)animated;
- (void)removeSpecifierID:(NSString *)identifier animated:(BOOL)animated;
- (void)removeSpecifierAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)removeLastSpecifierAnimated:(BOOL)animated;
- (void)removeContiguousSpecifiers:(NSArray *)specifiers animated:(BOOL)animated;
- (void)reloadSpecifier:(PSSpecifier *)specifier;
- (void)reloadSpecifierID:(NSString *)identifier;
- (void)reloadSpecifierAtIndex:(NSInteger)index;
- (void)reloadSpecifier:(PSSpecifier *)specifier animated:(BOOL)animated;
- (void)reloadSpecifierID:(NSString *)identifier animated:(BOOL)animated;
- (void)reloadSpecifierAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)reloadSpecifiers;
- (void)updateSpecifiers:(NSArray *)oldSpecifiers withSpecifiers:(NSArray *)newSpecifiers;
- (void)updateSpecifiersInRange:(NSRange)range withSpecifiers:(NSArray *)newSpecifiers;
- (void)lazyLoadBundle:(PSSpecifier *)specifier;
@end

@interface PSEditableListController : PSListController
@end

@interface APNetworksController : PSListController
@end

@interface APKnownNetworksController : PSEditableListController
- (void)removeNetwork:(PSSpecifier *)specifier;
@end

@interface NetworkListViewController : UITableViewController
@end

@interface NetworkListViewCell : UITableViewCell
@end

#pragma mark - Globals

static NSString * const NetworkListIdentifier = @"me.qusic.NetworkList";
static NSString * const SSIDKey = @"SSID";
static NSString * const PasswordKey = @"Password";

static PSSpecifier *Specifier;
static NetworkListViewController *Controller;

CHDeclareClass(PSUIPrefsListController)
CHDeclareClass(PrefsListController)
CHDeclareClass(APNetworksController)
CHDeclareClass(APKnownNetworksController)

#pragma mark - Functions

static NSMutableArray *getNetworks() {
    static NSString * (^ const getPassword)(NSString *) = ^(NSString *ssid) {
        NSMutableDictionary *query = @{(__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword,
                                       (__bridge id)kSecAttrService: @"AirPort",
                                       (__bridge id)kSecAttrAccount: ssid,
                                       (__bridge id)kSecMatchLimit: (__bridge id)kSecMatchLimitOne,
                                       (__bridge id)kSecReturnData: (__bridge id)kCFBooleanTrue}.mutableCopy;
        if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_7_0) query[(__bridge id)kSecAttrSynchronizable] = (__bridge id)kSecAttrSynchronizableAny;
        CFTypeRef result = NULL;
        SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        NSString *password = [[NSString alloc]initWithData:(__bridge_transfer NSData *)result encoding:NSUTF8StringEncoding];
        return password;
    };
    NSMutableArray *networks = [NSMutableArray array];
    for (PSSpecifier *specifier in [CHAlloc(APKnownNetworksController)init].specifiers) {
        if (specifier->cellType == PSTitleValueCell) {
            NSString *ssid = specifier.identifier;
            NSString *password = getPassword(ssid);
            [networks addObject:@{SSIDKey: ssid, PasswordKey: password ? : @""}];
        }
    }
    return networks;
}

static void deleteNetwork(NSString *ssid) {
    PSSpecifier *specifier = [PSSpecifier preferenceSpecifierNamed:ssid target:nil set:NULL get:NULL detail:Nil cell:PSTitleValueCell edit:Nil];
    specifier.identifier = ssid;
    [[CHAlloc(APKnownNetworksController)init] removeNetwork:specifier];
}

#pragma mark - Implementations

@interface NetworkListViewController () <MFMailComposeViewControllerDelegate>

@property(retain) NSMutableArray *networks;
@property(retain) UIMenuController *menuController;
@property(retain) id menuControllerObserver;

@end

@implementation NetworkListViewController

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)loadNetworks {
    _networks = getNetworks();
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _menuController = [UIMenuController sharedMenuController];
    _menuController.menuItems = @[[[UIMenuItem alloc]initWithTitle:@"Copy SSID" action:@selector(copySSID:)], [[UIMenuItem alloc]initWithTitle:@"Copy Password" action:@selector(copyPassword:)]];
    [_menuController update];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(loadNetworks) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _menuControllerObserver = [[NSNotificationCenter defaultCenter]addObserverForName:UIMenuControllerDidHideMenuNotification object:_menuController queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (!_menuController.isMenuVisible) {
            [[UIApplication sharedApplication].keyWindow.firstResponder resignFirstResponder];
        }
    }];
    [self.refreshControl beginRefreshing];
    [self.refreshControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setEditing:NO animated:YES];
    [[UIApplication sharedApplication].keyWindow.firstResponder resignFirstResponder];
    [[NSNotificationCenter defaultCenter]removeObserver:_menuControllerObserver];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return _networks.count;
        case 1:
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (indexPath.section) {
        case 0: {
            static NSString *const CellIdentifier = @"NetworkListItemCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[NetworkListViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSDictionary *network = _networks[indexPath.row];
            cell.textLabel.text = network[SSIDKey];
            cell.detailTextLabel.text = network[PasswordKey];
            break;
        }
        case 1: {
            static NSString *const CellIdentifier = @"NetworkListButtonCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                cell.textLabel.textAlignment = NSTextAlignmentCenter;
            }
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Export This List";
                    break;
                default:
                    break;
            }
            break;
        }
        default: {
            break;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
        case 1:
            return @"\nNetworkList © Qusic";
        default:
            return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [cell becomeFirstResponder];
            [_menuController setTargetRect:cell.frame inView:tableView];
            [_menuController setMenuVisible:YES animated:YES];
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0:
                    [self exportAction];
                    break;
                default:
                    break;
            }
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            break;
        }
        default: {
            break;
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return YES;
        case 1:
            return NO;
        default:
            return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
                NSDictionary *network = _networks[indexPath.row];
                deleteNetwork(network[SSIDKey]);
                [_networks removeObject:network];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
            }
            break;
        }
        case 1: {
            break;
        }
        default: {
            break;
        }
    }
}

- (void)exportAction {
    NSMutableString *body = [NSMutableString string];
    for (NSDictionary *network in _networks) {
        [body appendFormat:@"%@: %@\n", network[SSIDKey], [network[PasswordKey]length] > 0 ? network[PasswordKey] : @"(no password)"];
    }
    MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc]init];
    composeViewController.mailComposeDelegate = self;
    [composeViewController setSubject:[NSString stringWithFormat:@"Known Networks - %@", [UIDevice currentDevice].name]];
    [composeViewController setMessageBody:body isHTML:NO];
    [self presentViewController:composeViewController animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:NULL];
}

@end

@implementation NetworkListViewCell

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copySSID:) || (action == @selector(copyPassword:) && self.detailTextLabel.text.length > 0));
}

- (void)copySSID:(id)sender {
    [UIPasteboard generalPasteboard].string = self.textLabel.text;
}

- (void)copyPassword:(id)sender {
    [UIPasteboard generalPasteboard].string = self.detailTextLabel.text;
}

@end

#pragma mark - Hooks

CHMethod(0, NSMutableArray *, APNetworksController, specifiers) {
    NSMutableArray *specifiers = CHSuper(0, APNetworksController, specifiers);
    NSMutableArray *askToJoinGroup = CHIvar(self, _askToJoinGroup, NSMutableArray * const);
    if (![askToJoinGroup containsObject:Specifier]) {
        Specifier.target = self;
        Specifier->action = @selector(openNetworkList);
        [askToJoinGroup addObject:Specifier];
        NSUInteger count = specifiers.count;
        for (NSUInteger i = 0; i < count; i++) {
            if ([[specifiers[i]identifier]isEqualToString:@"ASK_TO_JOIN"]) {
                [specifiers insertObject:Specifier atIndex:i + 1];
                break;
            }
        }
    }
    return specifiers;
}

CHMethod(0, void, APNetworksController, openNetworkList) {
    [self pushController:Controller animate:YES];
}

static void lazyConstructor() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *title = [[NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/AirPortSettings.bundle"]localizedStringForKey:@"KNOWN_NETWORKS" value:@"Known Networks" table:@"Networks"];
        Specifier = [PSSpecifier preferenceSpecifierNamed:title target:nil set:NULL get:NULL detail:Nil cell:PSLinkCell edit:Nil];
        Specifier.identifier = NetworkListIdentifier;
        Controller = [NetworkListViewController new];
        Controller.title = title;
        CHLoadLateClass(APNetworksController);
        CHLoadLateClass(APKnownNetworksController);
        CHHook(0, APNetworksController, specifiers);
        CHHook(0, APNetworksController, openNetworkList);
    });
}

CHOptimizedMethod(1, self, void, PSUIPrefsListController, lazyLoadBundle, PSSpecifier *, specifier) {
    CHSuper(1, PSUIPrefsListController, lazyLoadBundle, specifier);
    if ([specifier.identifier isEqualToString:@"WIFI"]) {
        lazyConstructor();
    }
}

CHOptimizedMethod(1, self, void, PrefsListController, lazyLoadBundle, PSSpecifier *, specifier) {
    CHSuper(1, PrefsListController, lazyLoadBundle, specifier);
    if ([specifier.identifier isEqualToString:@"WIFI"]) {
        lazyConstructor();
    }
}

#pragma mark - Constructor

CHConstructor {
    @autoreleasepool {
        if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.Preferences"]) {
            CHLoadLateClass(PSUIPrefsListController);
            CHLoadLateClass(PrefsListController);
            CHHook(1, PSUIPrefsListController, lazyLoadBundle);
            CHHook(1, PrefsListController, lazyLoadBundle);
        }
    }
}
