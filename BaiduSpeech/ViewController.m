//
//  ViewController.m
//  BaiduSpeech
//
//  Created by Marcus on 16/8/31.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import "ViewController.h"
#import "MCBaiduSpeechManage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MCBaiduSpeechManage SpakeString:@"你好"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
