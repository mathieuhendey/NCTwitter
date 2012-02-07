#import "BBWeeAppController-Protocol.h"
#import <Twitter/Twitter.h>


static NSBundle *_NCTwitterWeeAppBundle = nil;

@interface NCTwitterController: NSObject <BBWeeAppController> {
	UIView *_view;
	UIImageView *_backgroundView;
	UILabel *label;
	UIViewController *vc;
	UIWindow *window;
}
@property (nonatomic, retain) UIView *view;
@end

@implementation NCTwitterController
@synthesize view = _view;

+ (void)initialize {
	_NCTwitterWeeAppBundle = [[NSBundle bundleForClass:[self class]] retain];
}

- (id)init {
	if((self = [super init]) != nil) {
		
	} return self;
}

- (void)dealloc {
	[_view release];
	[_backgroundView release];
	[super dealloc];
}

- (void)loadFullView {
	// Add subviews to _backgroundView (or _view) here.
	_view = [[UIView alloc] initWithFrame:CGRectMake(2, 0, 316, 40)];
        
        UIImage *bg = [[UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/WeeAppTest.bundle/WeeAppBackground.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:40];
        UIImageView *bgView = [[UIImageView alloc] initWithImage:bg];
        bgView.frame = CGRectMake(0, 0, 316, 50);
        [_view addSubview:bgView];
        [bgView release];
}

-(void)viewDidAppear {
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 316, 30)];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Tap to tweet";
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:(CGFloat)15];
        UITapGestureRecognizer* gesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tweetLabelTapped)];
        [label setUserInteractionEnabled:YES];
		[label addGestureRecognizer:gesture2];

        [_view addSubview:label];
        [label release];

}

- (void)loadPlaceholderView {
	// This should only be a placeholder - it should not connect to any servers or perform any intense
	// data loading operations.
	//
	// All widgets are 316 points wide. Image size calculations match those of the Stocks widget.
	_view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.f, [self viewHeight]}}];
	_view.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	UIImage *bgImg = [UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"];
	UIImage *stretchableBgImg = [bgImg stretchableImageWithLeftCapWidth:floorf(bgImg.size.width / 2.f) topCapHeight:floorf(bgImg.size.height / 2.f)];
	_backgroundView = [[UIImageView alloc] initWithImage:stretchableBgImg];
	_backgroundView.frame = CGRectInset(_view.bounds, 2.f, 0.f);
	_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[_view addSubview:_backgroundView];
}

- (void)tweetLabelTapped {
	vc = [[UIViewController alloc] init];
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

window.rootViewController = vc;  
window.windowLevel = UIWindowLevelAlert;

[window makeKeyAndVisible];  
TWTweetComposeViewController *tweetSheet = 
        [[TWTweetComposeViewController alloc] init];
    [tweetSheet setInitialText:@""];
    [vc presentModalViewController:tweetSheet animated:YES];

    tweetSheet.completionHandler = ^(TWTweetComposeViewControllerResult result){
    	if (result == TWTweetComposeViewControllerResultCancelled)
    	[vc dismissModalViewControllerAnimated:YES];
    [window release];
};
}

- (void)unloadView {
	[_view release];
	_view = nil;
	[_backgroundView release];
	_backgroundView = nil;
	// Destroy any additional subviews you added here. Don't waste memory :(.
}

- (float)viewHeight {
	return 40.f;
}

@end
