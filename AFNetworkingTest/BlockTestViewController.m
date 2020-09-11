//
//  BlockTestViewController.m
//  AFNetworkingTest
//
//  Created by Civet on 2020/9/1.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "BlockTestViewController.h"

@interface BlockTestViewController ()

@end

@implementation BlockTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)deliveryBlock:(BlockDemo)block{
    self.block = block;
    self.block(@"BlockTestViewController",66);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
