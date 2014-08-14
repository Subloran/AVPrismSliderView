//
//  AVPrismSliderView.h
//  Cian
//
//  Created by Артем on 31.07.14.
//  Copyright (c) 2014 Cian group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AVPrismSliderViewDelegate;

@interface AVPrismSliderViewItem : NSObject

@property (nonatomic, retain) NSString* itemLabelString;
@property (nonatomic, retain) UIFont* itemFont;
@property (nonatomic, retain) UIColor* regularColor;
@property (nonatomic, retain) UIColor* highlightedColor;

@property (nonatomic, retain) UIImage* regularImage;
@property (nonatomic, retain) UIImage* highlightedImage;
@property (nonatomic, assign) UIEdgeInsets imageOffset;

@end

@interface AVPrismSliderView : UIView

@property (nonatomic, weak) id <AVPrismSliderViewDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger selectedItem;

@property (nonatomic, retain) UIColor* sliderBackgroundColor;
@property (nonatomic, retain) UIColor* sliderFieldColor;
@property (nonatomic, retain) UIColor* sliderColor;

@property (nonatomic, retain, readonly) NSMutableArray* items;

+ (AVPrismSliderView*)sliderViewWithItems:(NSArray*)items;

- (void)selectItem:(NSInteger)item animated:(BOOL)animated;

@end

@protocol AVPrismSliderViewDelegate

@required

- (void)selectionChanged:(NSInteger)selectedItem inSlider:(AVPrismSliderView*)sender;

@end
