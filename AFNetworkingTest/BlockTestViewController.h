//
//  BlockTestViewController.h
//  AFNetworkingTest
//
//  Created by Civet on 2020/9/1.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlockDemo)(NSString *str, NSInteger num);

@interface BlockTestViewController : UIViewController

@property(nonatomic, copy) BlockDemo block;

- (void)deliveryBlock:(BlockDemo)block;

@end

NS_ASSUME_NONNULL_END
