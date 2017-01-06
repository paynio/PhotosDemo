# PhotosDemo

Demonstrates consumption of Instagram API, displays these in a collection view and then allows for CIImage affects to be added.

## Installation

### Cocoapods

The application uses Cocoapods to install AlamoFire dependencies. Pods are not stored in the repo. As such:

- After downloading/cloning repo, navigate to main directory
- Run ```pod install``` prior to compilation

### Creds

To avoid sharing creds within a public repository, they will be emailed to you separately. Creds must be filled in the Creds.plist file. If creds are not added, the application will force crash on launch (this is expected behaviour to enforce using correct creds).

## Notes

### API Authentication

Instagram requires users to authenticate to receive an access token as explained [here](https://www.instagram.com/developer/authentication/). To help improve the first use experience of the app, if the correct creds are entered, the application will automatically login you in. Notes:

- LoginViewController uses evaluateJavaScript function to pre-populate username & password fields, and then to simulate login click
- This would never be used in production code, but is demonstrated here to highlight how to interact with JS in a WKWebView
- The access token is retrieved and stored in UserDefaults. For production code, it would be much more preferable to store in Keychain

### API Retrieval

- Fetches recent images for the logged in user.
- If using provided creds, there are 10 images saved already in Instagram on that particular user.
- Application not tested with different login creds, but if there is recent activity for a different user, it is anticipated that the API should work in the same way

### JSON Parsing

- Handled in object creation in InstaImage.swift

### Master Collection View

- Spacing is resized in customiseCollectionViewLayout (to demonstrate knowledge of custom layouts)
- Selection of cell will performSegue to SingleImageViewController

### SingleImageViewController

- Demonstrates the use of different filters applied to images (and animated in via transition)
- Uses iOS's recommended image improvement CIFilters (received thru autoAdjustmentFilters())
- **Note: iOS's recommended filters show very minor changes. As such, some additional filters are added to show more greater differences**
