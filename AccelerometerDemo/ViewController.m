//
//  ViewController.m
//  AccelerometerDemo
//
//  Created by Varindra Hart on 8/20/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController () <UIAccelerometerDelegate>
@property (nonatomic, weak) IBOutlet UIView *centerView;
@property (nonatomic,strong) CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view, typically from a nib.
    self.motionManager = [[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval = 1.0f/60.0f;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self outputAccelerationData:accelerometerData.acceleration];
                                                 if(error){
                                                     NSLog(@"No Data for accel");
                                                 }
                                             }];

}

- (void) outputAccelerationData:(CMAcceleration)acceleration{

    NSLog(@"x:%lf,y: %lf,z: %lf",acceleration.x,acceleration.y, acceleration.z);
    CGPoint delta;
    delta.x = acceleration.x *20;
    delta.y = -acceleration.y *20 -12;
    
    self.centerView.center = CGPointMake(self.centerView.center.x + delta.x, self.centerView.center.y + delta.y);
    
    //RIGHT
    if (self.centerView.center.x < 0){
        self.centerView.center = CGPointMake(0, self.centerView.center.y);
    }
    //LEFT
    if (self.centerView.center.x > self.view.bounds.size.width){
        self.centerView.center = CGPointMake(self.view.bounds.size.width, self.centerView.center.y);
    }
    //TOP
    if (self.centerView.center.y < 0){
        self.centerView.center = CGPointMake(self.centerView.center.x, 0);
    }
    //BOTTOM
    if (self.centerView.center.y > self.view.bounds.size.height){
        self.centerView.center = CGPointMake(self.centerView.center.x, self.view.bounds.size.height);
    }
}

- (IBAction)iconPanGesture:(UIPanGestureRecognizer *)gesture{
    
    
    CGPoint translation = [gesture translationInView:self.view];
    
    gesture.view.center = CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y +translation.y);
    
    [gesture setTranslation:CGPointMake(0,0) inView:self.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
