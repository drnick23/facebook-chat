//
//  NewsFeedViewController.m
//  facebook-chat
//
//  Created by Nicolas Halper on 6/25/14.
//  Copyright (c) 2014 DesignerIOS. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *newsFeedScrollView;
@property (weak, nonatomic) IBOutlet UIView *newsFeedView;
- (IBAction)onDarren:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *chatHead;
- (IBAction)onChatHeadPan:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *trashImageView;

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
    // Do any additional setup after loading the view from its nib.
    
    self.newsFeedView.center = CGPointMake(160, self.newsFeedView.center.y);
    self.title = @"News Feed";
    self.chatHead.hidden = YES;
    self.chatHead.center = CGPointMake(400, self.chatHead.center.y);
    self.newsFeedScrollView.contentSize = CGSizeMake(320, 1300);
    
    self.trashImageView.center = CGPointMake(160, 750);

//    UIImage *rightButtonImage = [[UIImage imageNamed:@"friends"]]
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Friends" style:UIBarButtonItemStylePlain target:self action:@selector(onRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) onRightButton {
    NSLog(@"Right button pressed");
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
    NSLog(@"I work!");
    [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.newsFeedView.center = CGPointMake(160, self.newsFeedView.center.y);
    } completion:^(BOOL finished) {
        self.chatHead.hidden = NO;
        [UIView animateWithDuration:.3 animations:^{
            self.chatHead.center = CGPointMake(250, 120);
        }];
    }];
}
- (IBAction)onChatHeadPan:(UIPanGestureRecognizer *)sender {
    NSLog(@"CHat head panning");
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        [UIView animateWithDuration:.3 animations:^{
            self.trashImageView.center = CGPointMake(160, 400);
        }];
        
    } else if (sender.state == UIGestureRecognizerStateChanged  ){
        self.chatHead.center = [sender locationInView:self.view];
        
        
    } else if (sender.state == UIGestureRecognizerStateEnded){
        
        [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:.5 initialSpringVelocity:40 options:0 animations:^{
            
            if (self.chatHead.center.y > self.trashImageView.frame.origin.y) {
                self.chatHead.center = CGPointMake(160, 600);
            } else if (self.chatHead.center.x < 160) {
                self.chatHead.center = CGPointMake(40, self.chatHead.center.y);
            } else {
                self.chatHead.center = CGPointMake(280, self.chatHead.center.y);
            }
        } completion:nil];
        
        [UIView animateWithDuration:.3 animations:^{
            self.trashImageView.center = CGPointMake(160, 750);
        }];
        
        
        
    }
}
@end
