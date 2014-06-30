//
//  NewsFeedViewController.m
//  facebook-chat
//
//  Created by Nicolas Halper on 6/25/14.
//  Copyright (c) 2014 DesignerIOS. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()

- (IBAction)onDarren:(UIButton *)sender;
- (IBAction)onChatHeadPan:(UIPanGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *trashImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chatHead;

@property (weak, nonatomic) IBOutlet UIView *newsFeedView;
@property (weak, nonatomic) IBOutlet UIScrollView *newsFeedScrollView;


@end

@implementation NewsFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // hide the chat head on startup
    self.chatHead.hidden = YES;
    
    // newsFeed setup with position and size of scroll view
    self.newsFeedView.center = CGPointMake(160, self.newsFeedView.center.y);
    self.newsFeedScrollView.contentSize = CGSizeMake(320, 1300);
    
    // place the trash image view offscreen, ready to move in when needed
    self.trashImageView.center = CGPointMake(160, 750);

    // configure the navigation bar with a title and a right navigation bar button "Friends"
    self.title = @"News Feed";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Friends" style:UIBarButtonItemStylePlain target:self action:@selector(onFriendsNavigationButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

- (void) onFriendsNavigationButton {
    NSLog(@"onFriendsNavigationButton");
    
    // when we press the friends navigation button,
    //    if the newsfeed is all the way to the right (closed), slide it open to the left to reveal the friends list view underneath it
    //    otherwise, slide the newsfeed back "closed" over the friends list.
    
    if(self.newsFeedView.center.x == 160){
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.newsFeedView.center = CGPointMake(-40, self.newsFeedView.center.y);
        } completion:nil];
    } else{
        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.newsFeedView.center = CGPointMake(160, self.newsFeedView.center.y);
        } completion:nil];
    }
}

- (IBAction)onDarren:(UIButton *)sender {
    NSLog(@"onDarren");
    
    // when a friend is selected from our friends list,
    //   - position the chat head off screen at the point we want to slide it in
    //   - "close" the friends list menu by sliding the newsfeed back across
    //   - then animate the chat head into the screen
    
    // hide the chat head and position off screen ready to move in
    self.chatHead.hidden = YES;
    self.chatHead.center = CGPointMake(400, 120);
    
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        // slide the newsfeed "closed" to hide the friends menu
        self.newsFeedView.center = CGPointMake(160, self.newsFeedView.center.y);
    } completion:^(BOOL finished) {
        // once the newsfeed has finished sliding across, unhide the chat head
        self.chatHead.hidden = NO;
        [UIView animateWithDuration:.3 animations:^{
            // and then slide the chathead to the top right of the screen
            self.chatHead.center = CGPointMake(250, 120);
        }];
    }];
}
- (IBAction)onChatHeadPan:(UIPanGestureRecognizer *)sender {
    NSLog(@"onChatHeadPan");
    
    // when we pan on a chat head
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // - at the start of the gesture:
        //    - slide in the trashImageView from the bottom into the screen
        
        [UIView animateWithDuration:.3 animations:^{
            self.trashImageView.center = CGPointMake(160, 480);
        }];
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        // - during the gesture:
        //    - update the chat head position to the current touch point of the gesture
        
        self.chatHead.center = [sender locationInView:self.view];
        
    } else if (sender.state == UIGestureRecognizerStateEnded){
        
        // - after the gesture:
        //    - if the chat head is below the trashImageView, slide it off the button of the screen to remove it
        //    - otherwise snap the chat head to the left or right bounds of the screen
        
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:40 options:0 animations:^{
            if (self.chatHead.center.y > self.trashImageView.frame.origin.y) {
                self.chatHead.center = CGPointMake(160, 600);
            } else if (self.chatHead.center.x < 160) {
                self.chatHead.center = CGPointMake(40, self.chatHead.center.y);
            } else {
                self.chatHead.center = CGPointMake(280, self.chatHead.center.y);
            }
        } completion:nil];
        
        //    - slide the trashImageView away
        [UIView animateWithDuration:.3 animations:^{
            self.trashImageView.center = CGPointMake(160, 750);
        }];
    }
}
@end
