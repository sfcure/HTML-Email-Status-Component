# HTML Email Status Component
## Overview
A Lightning Component to display HTML Email Status related list on a record. I came across many questions regarding this feature on Success Community and Salesforce product team still need some time to delivering this well needed feature. So, It made me think to create one and distribute this in the community.

![Idea on IdeaExchange](https://image.prntscr.com/image/fwSvW2R_QaOzKUGOxt9m9w.png)

## Packaged Release History
## Release 1.1
- Sandbox [Package Link](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t7F000001yevB)
- Production [Package Link](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t7F000001yevB)

## Pre-Requsites for installing this package
- You must have enabled Email Tracking 
- This will work for Contact and Lead object as of now.
- There must be a record created of EmailStatus object to pass the Test classes of the managed package. It's required due to platform limitation as mentioned in the following article - 
[EmailStatus entity within test classes](https://help.salesforce.com/articleView?id=000247964&language=en_US&type=1)
To make sure it you can check a record under HTML Email Status related list (Salesforce classic) for any record. I am sorry for this extra overhead.

## GitHub Repository for Source Code (Developers)
You can can check the [GitHub Repository](https://github.com/sfcure/HTML-Email-Status-Component) for the source code and can make any adjustments as per your need.

## Getting Started
1. Go to your record page and Edit the lightning page which will open in the Lightning App Builder.
2. Drag and drop the HTML Email Status Component on the page and save the changes. You can also specify the title of the component.

## Component will look like as shown in the following screenshot.
![Snapshot](https://image.prntscr.com/image/xTN6Ecg_S9aViSUcl1NaQg.png)
