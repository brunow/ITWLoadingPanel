## ITWLoadingPanel
ITWLoadingPanel is a class for adding a download info panel, made at [Intotheweb](http://intotheweb.be/)

![Screenshot](https://github.com/brunow/ITWLoadingPanel/raw/master/Screenshot.png)

## Compatibility

ITWLoadingPanel work on iPad and iPhone in any orientation.

## How to use it

Show it:

	[ITWLoadingPanel showPanelInView:self.view title:@"Title" cancelTitle:@"Cancel"];

Hide it:

	[ITWLoadingPanel  hidePanel];

## How to customize it

Subclass ITWLoadingPanel and do customization inside awakeFromNib:

	- (void)awakeFromNib {
 	   [super awakeFromNib];
    
	    self.backgroundColor = [UIColor redColor];
	    [self.cancelBtn setBackgroundImage:image forState:state];
	    self.cancelLabel.textColor = [UIColor yellowColor];
	    self.titleLabel.textColor = [UIColor blackColor];
	}


## ARC
ITWLoadingPanel is fully compatible out of box with arc and non-arc project.