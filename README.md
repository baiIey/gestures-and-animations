# Gestures and Animations (Mailbox)
Handle different gestures such as tap, long press, and pan, along with animating various view properties such as position, size, rotation, and alpha.

#### Time spent
12 hours spent in total

#### Project requirements
* **On dragging the message left...**
	* ✓ Initially, the revealed background color should be gray.
	* ✓ As the reschedule icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
	* ✓ After 60 pts, the later icon should start moving with the translation and the background should change to yellow.
Upon release, the message should continue to reveal the yellow background. When the animation it complete, it should show the reschedule options.
	* ✓ After 260 pts, the icon should change to the list icon and the background color should change to brown.
	* ✓ Upon release, the message should continue to reveal the brown background. When the animation it complete, it should show the list options.
* ✓ User can tap to dismissing the reschedule or list options. After the reschedule or list options are dismissed, you should see the message finish the hide animation.
* **On dragging the message right...**
	* ✓ Initially, the revealed background color should be gray.
	* ✓ As the archive icon is revealed, it should start semi-transparent and become fully opaque. If released at this point, the message should return to its initial position.
	* ✓ After 60 pts, the archive icon should start moving with the translation and the background should change to green.
	* ✓ Upon release, the message should continue to reveal the green background. When the animation it complete, it should hide the message.
	* ✓ After 260 pts, the icon should change to the delete icon and the background color should change to red.
* ✓ Upon release, the message should continue to reveal the red background. When the animation it complete, it should hide the message.
* **Optional: Panning from the edge should reveal the menu**
	* Optional: If the menu is being revealed when the user lifts their finger, it should continue revealing.
	* Optional: If the menu is being hidden when the user lifts their finger, it should continue hiding.
* Optional: Tapping on compose should animate to reveal the compose view.
* Optional: Tapping the segmented control in the title should swipe views in from the left or right.
* Optional: Shake to undo.

#### Notes
[Swift only accepts values between 0.0 and 1.0](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIColor_Class/index.html#//apple_ref/occ/clm/UIColor/colorWithRed%3agreen%3ablue%3aalpha%3a) when declaring RGBA, while RGB stores values between 0 and 255. (The alpha in RGBA being between 0.0 and 1.0.) After searching [Stack Overlow](http://stackoverflow.com/questions/24310696/uicolor-not-working-with-rgba-value-ios-7-swift), I found I needed to divide the colors I selected by 255 to get the new ratio.

Fortunately, we can before that conversion right in the declaration.

Thus, my emerald green, `rgba(46, 204, 113, 1.0)`, moved to `UIColor(red: 46, green: 204, blue: 133, alpha: 1.0)` before becoming `UIColor(red: 46/255, green: 204/255, blue: 133/255, alpha: 1.0)`.


#### Walkthrough of all user stories

![Video Walkthrough](image.gif)

GIF created with [LiceCap](http://www.cockos.com/licecap/).

Background colors from [Flat UI Colors](http://flatuicolors.com/).

RGB to Swift UIColor math from [Stack Overflow](http://stackoverflow.com/questions/24310696/uicolor-not-working-with-rgba-value-ios-7-swift).

iOS Developer Library [UIColor Class Reference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIColor_Class/index.html#//apple_ref/occ/clm/UIColor/colorWithRed%3agreen%3ablue%3aalpha%3a)