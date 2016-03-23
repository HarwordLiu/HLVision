//
//  SingleNewsTableViewCell.m
//  Vision
//
//  Created by Rilma.Liu on 16/3/8.
//  Copyright © 2016年 Rilma.Liu. All rights reserved.
//

#import "SingleNewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation SingleNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}


- (void)creatSubView {
    self.backgroundColor = [UIColor blackColor];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, SCREENFRAMEWEIGHT - 20, SCREENFRAMEHEIGHT / 5 - 20)];
    backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.33];
    self.backView = backView;
    [self.contentView addSubview:backView];
    
    self.imageViewNews = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, backView.frame.size.width / 3 - 10, backView.frame.size.height - 10)];
    [backView addSubview:self.imageViewNews];
    
    self.textLabelProvider = [[UILabel alloc] initWithFrame:CGRectMake(5 + backView.frame.size.width / 3, 10, backView.frame.size.width / 3, backView.frame.size.height / 5)];
    self.textLabelProvider.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15];
    [backView addSubview:self.textLabelProvider];
    
    self.textLabelPubDate = [[UILabel alloc] initWithFrame:CGRectMake(5 + backView.frame.size.width * 2 / 3 - 10, 10, backView.frame.size.width / 3, backView.frame.size.height / 5)];
    self.textLabelPubDate.textAlignment = NSTextAlignmentRight;
    self.textLabelPubDate.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:15];
    [backView addSubview:self.textLabelPubDate];
    
    self.textLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(5 + backView.frame.size.width / 3, backView.frame.size.height / 5 + 20, backView.frame.size.width * 2 / 3 - 10, backView.frame.size.height * 3 / 5)];
    self.textLabelTitle.lineBreakMode = NSLineBreakByClipping;
    self.textLabelTitle.numberOfLines = 0;
    self.textLabelTitle.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    [backView addSubview:self.textLabelTitle];

    self.textLabelPubDate.textColor = [UIColor whiteColor];
    self.textLabelTitle.textColor = [UIColor whiteColor];
    self.textLabelProvider.textColor = [UIColor whiteColor];
    
    
    
    
    
}

- (void)setModel:(ArticleModel *)model {
    if (_model != model) {
        _model = model;
    }
    if (model.medias.count != 0) {
        MediaModel *media = model.medias[0];
        [self.imageViewNews sd_setImageWithURL:[NSURL URLWithString:media.Url] placeholderImage:[UIImage imageNamed:@"EyesPlaceHolder"]];
    } else {
        self.imageViewNews.image = [UIImage imageNamed:@"EyesPlaceHolder"];
    }
    self.textLabelTitle.frame = CGRectMake(5 + _backView.frame.size.width / 3, _backView.frame.size.height / 5 + 20, _backView.frame.size.width * 2 / 3 - 10, _backView.frame.size.height * 3 / 5);
    self.textLabelTitle.text = model.Title;
    [self.textLabelTitle sizeToFit];
    self.textLabelProvider.text = model.ProviderName;
    self.textLabelPubDate.text = [model.PubDate substringToIndex:10];
    
}


















@end
