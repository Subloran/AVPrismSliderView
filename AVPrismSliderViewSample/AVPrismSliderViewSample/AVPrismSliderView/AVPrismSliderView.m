//
//  AVPrismSliderView.m
//  Cian
//
//  Created by Артем on 31.07.14.
//  Copyright (c) 2014 Cian group. All rights reserved.
//

#import "AVPrismSliderView.h"

@implementation AVPrismSliderViewItem

@end

@interface AVPrismSliderView ()

@property (nonatomic, retain) IBOutlet UIView* fieldView;

@property (nonatomic, retain) NSMutableArray* backgroundButtons;
@property (nonatomic, retain) NSMutableArray* foregroundButtons;
@property (nonatomic, retain) UIView* sliderView;
@property (nonatomic, retain) UIView* sliderViewButtonsContrainer;
@property (nonatomic, retain) NSLayoutConstraint* sliderViewXConstraint;
@property (nonatomic, retain) NSLayoutConstraint* sliderViewBottonsContainerXConstraint;

@end

@implementation AVPrismSliderView

+ (AVPrismSliderView*)sliderViewWithItems:(NSArray*)items
{
    AVPrismSliderView* slider = [[AVPrismSliderView alloc] initWithItems:items];
    return slider;
}

- (id)initWithItems:(NSArray*)items
{
    self = [super init];
    if (self)
    {
        _items = [NSMutableArray arrayWithArray:items];
        [self loadView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _sliderView.layer.cornerRadius = (_fieldView.frame.size.height - 4) / 2;
    _fieldView.layer.cornerRadius = _fieldView.frame.size.height / 2;
    
    {
        _sliderViewXConstraint.constant = (_fieldView.frame.size.width / _backgroundButtons.count) * _selectedItem + 1;
        _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 1;
        [_sliderView setNeedsUpdateConstraints];
        [_sliderView layoutIfNeeded];
    }
}

- (void)loadView
{
    _backgroundButtons = [NSMutableArray array];
    _foregroundButtons = [NSMutableArray array];
    
    // field view
    _fieldView = [[UIView alloc] init];
    _fieldView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_fieldView];
    [_fieldView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_fieldView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_fieldView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_fieldView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_fieldView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    // background buttons
    for (int i = 0; i < _items.count; i++)
    {
        AVPrismSliderViewItem* item = _items[i];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        if (item.itemLabelString.length)
        {
            [button setTitle:item.itemLabelString forState:UIControlStateNormal];
            [button setTitleColor:item.regularColor forState:UIControlStateNormal];
            [button.titleLabel setFont:item.itemFont];
        }
        if (item.regularImage)
        {
            [button setImage:item.regularImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:item.imageOffset];
        }
        
        button.tag = i;
        [_backgroundButtons addObject:button];
        [_fieldView addSubview:button];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        
        if (i == 0)
        {
            [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        }
        else
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_backgroundButtons[i-1] attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_backgroundButtons[i-1] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        }
        
        if (i == _items.count - 1)
        {
            [self addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        }
    }
    
    // slider view
    _sliderView = [[UIView alloc] init];
    _sliderViewButtonsContrainer = [[UIView alloc] initWithFrame:_fieldView.bounds];
    [_sliderViewButtonsContrainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    _sliderView.backgroundColor = [UIColor blueColor];
    _sliderView.clipsToBounds = YES;
    [_sliderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_fieldView addSubview:_sliderView];
    [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-4]];
    
    _sliderViewXConstraint = [NSLayoutConstraint constraintWithItem:_sliderView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:2];
    _sliderViewXConstraint.priority = 450;
    [_fieldView addConstraint:_sliderViewXConstraint];
    [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationLessThanOrEqual toItem:_fieldView attribute:NSLayoutAttributeRight multiplier:1.0 constant:-2]];
    [_fieldView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_backgroundButtons[0] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:-4]];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.cancelsTouchesInView = NO;
    [_sliderView addGestureRecognizer:pan];
    
    [_sliderView addSubview:_sliderViewButtonsContrainer];
    
    _sliderViewBottonsContainerXConstraint = [NSLayoutConstraint constraintWithItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_sliderView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [_sliderView addConstraint:_sliderViewBottonsContainerXConstraint];
    [_sliderView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_sliderView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [_sliderView addConstraint:[NSLayoutConstraint constraintWithItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_sliderView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_fieldView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    for (int i = 0; i < _items.count; i++)
    {
        AVPrismSliderViewItem* item = _items[i];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (item.itemLabelString.length)
        {
            [button setTitle:item.itemLabelString forState:UIControlStateNormal];
            [button setTitleColor:item.highlightedColor forState:UIControlStateNormal];
            [button.titleLabel setFont:item.itemFont];
        }
        if (item.highlightedImage)
        {
            [button setImage:item.highlightedImage forState:UIControlStateNormal];
            [button setImageEdgeInsets:item.imageOffset];
        }
        
        button.tag = i;
        [_foregroundButtons addObject:button];
        [_sliderViewButtonsContrainer addSubview:button];
        
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        
        if (i == 0)
        {
            [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        }
        else
        {
            [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_foregroundButtons[i-1] attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
            [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_foregroundButtons[i-1] attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
        }
        
        if (i == _items.count - 1)
        {
            [_sliderViewButtonsContrainer addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_sliderViewButtonsContrainer attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        }
    }
    [self setNeedsLayout];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint center = [sender locationInView:sender.view.superview];
    if (center.x - _sliderView.frame.size.width / 2 <= 0)
    {
        _sliderViewXConstraint.constant = 2;
        _sliderViewBottonsContainerXConstraint.constant = 0;
    }
    else if (center.x + _sliderView.frame.size.width / 2 >= _fieldView.frame.size.width)
    {
        _sliderViewXConstraint.constant = _fieldView.frame.size.width - _sliderView.frame.size.width + 2;
        _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 6;
    }
    else
    {
        _sliderViewXConstraint.constant = center.x - _sliderView.frame.size.width / 2 + 2;
        _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 2;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self completeAnimation];
    }
}

- (void)completeAnimation
{
    for (UIButton* button in _backgroundButtons)
    {
        if (_sliderView.center.x >= button.frame.origin.x && _sliderView.center.x < button.frame.origin.x + button.frame.size.width)
        {
            CGFloat distance = (_sliderViewXConstraint.constant - button.frame.origin.x + 1 > 0) ? _sliderViewXConstraint.constant - button.frame.origin.x : -(_sliderViewXConstraint.constant - button.frame.origin.x);
            _sliderViewXConstraint.constant = button.frame.origin.x + 2;
            _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 2;
            [_sliderView setNeedsUpdateConstraints];
            [UIView animateWithDuration:0.3 * (distance / (button.frame.size.width / 2)) animations:^{
                [_sliderView layoutIfNeeded];
                if (self.delegate != nil)
                {
                    _selectedItem = button.tag;
                    [self.delegate selectionChanged:button.tag inSlider:self];
                }
            } completion:^(BOOL finished) {
            }];
            return;
        }
    }
}

- (IBAction)buttonPressed:(UIButton*)sender
{
    _sliderViewXConstraint.constant = sender.frame.origin.x + 1;
    _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 1;
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
        if (self.delegate != nil)
        {
            _selectedItem = sender.tag;
            [self.delegate selectionChanged:sender.tag inSlider:self];
        }
    } completion:^(BOOL finished) {
    }];
}

- (void)selectItem:(NSInteger)item animated:(BOOL)animated
{
    UIButton* itemToSelect = _backgroundButtons[item];
    _sliderViewXConstraint.constant = itemToSelect.frame.origin.x + 1;
    _sliderViewBottonsContainerXConstraint.constant = -_sliderViewXConstraint.constant + 1;
    _selectedItem = item;
    [_sliderView setNeedsUpdateConstraints];
    if (animated)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [_sliderView layoutIfNeeded];
        }];
    }
    else
    {
        [_sliderView layoutIfNeeded];
    }
}

- (void)setSliderBackgroundColor:(UIColor *)sliderBackgroundColor
{
    _sliderBackgroundColor = sliderBackgroundColor;
    [self setBackgroundColor:sliderBackgroundColor];
}

- (void)setSliderFieldColor:(UIColor *)sliderFieldColor
{
    _sliderFieldColor = sliderFieldColor;
    [_fieldView setBackgroundColor:sliderFieldColor];
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    _sliderColor = sliderColor;
    [_sliderView setBackgroundColor:sliderColor];
}

@end
