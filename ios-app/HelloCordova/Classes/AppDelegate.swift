import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var viewController:CDVViewController?;
    
    override init() {
        var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage();
        
        // todo: what should we do ?
        //cookieStorage.setCookieAcceptPolicy(NSHTTPCookieAcceptPolicy.Always);
        
        var cacheMemorySize = 8 * 1024 * 1024;
        var cacheDiskSize = 32 * 1024 * 1024;
        
        var sharedCache
        = NSURLCache(
            memoryCapacity: cacheMemorySize,
            diskCapacity: cacheDiskSize,
            diskPath: "nsurlcache");
        
        NSURLCache.setSharedURLCache(sharedCache);
        
        super.init();
    }
    
    // todo: what is going on with `didFinishLaunchingWithOptions launchOptions`
    // is it a param ?
    func application(
        application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
        ) -> Bool {
            // Override point for customization after application launch.
            var screenBounds = UIScreen.mainScreen().bounds;
            
            self.window = UIWindow(frame: screenBounds);
            self.viewController = CDVViewController();
            
            // Cordova doc:
            // Set your app's start page by setting the <content src='foo.html' /> tag in config.xml.
            // If necessary, uncomment the line below to override it.
            // self.viewController.startPage = @"index.html";
            // NOTE: To customize the view's frame size (which defaults to full screen), override
            // [self.viewController viewWillAppear:] in your view controller.
            
            self.window?.rootViewController = viewController;
            
            self.window?.makeKeyAndVisible();
            
            return true
    }
    
    // todo: confused about the `handleOpenURL url:` is it a param ?
    // Cordova doc:
    // this happens while we are running ( in the background, or from within our own app )
    // only valid if iosionictryout-Info.plist specifies a protocol to handle
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        
        
        // todo: org corodva  code checks for ! url what should we do ?
        //        if (not url) {
        //            return false;
        //        }
        
        // Cordova doc:
        // calls into javascript global function 'handleOpenURL'
        var jsString = "handleOpenURL(\"\(url)\");";
        self.viewController?.webView.stringByEvaluatingJavaScriptFromString(jsString);
        
        var notification = NSNotification(name: CDVPluginHandleOpenURLNotification, object: url);
        NSNotificationCenter.defaultCenter().postNotification(notification);
        
        return true;
    }
    
    // Cordova doc:
    // repost all remote and local notification using the default NSNotificationCenter
    // so multiple plugins may respond
    func application(
        application: UIApplication,
        didReceiveLocalNotification notification: UILocalNotification
        ) {
            NSNotificationCenter.defaultCenter()
                .postNotificationName(CDVLocalNotification, object: notification);
    }
    
    
    // todo: migrate
    // Cordova doc:
    // repost all remote and local notification using the default NSNotificationCenter so multiple plugins may respond
    //    - (void)            application:(UIApplication*)application
    //    didReceiveLocalNotification:(UILocalNotification*)notification
    //    {
    //    // re-post ( broadcast )
    //    [[NSNotificationCenter defaultCenter] postNotificationName:CDVLocalNotification object:notification];
    //    }
    //
    //    - (void)                                application:(UIApplication *)application
    //    didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
    //    {
    //    // re-post ( broadcast )
    //    NSString* token = [[[[deviceToken description]
    //    stringByReplacingOccurrencesOfString: @"<" withString: @""]
    //    stringByReplacingOccurrencesOfString: @">" withString: @""]
    //    stringByReplacingOccurrencesOfString: @" " withString: @""];
    //
    //    [[NSNotificationCenter defaultCenter] postNotificationName:CDVRemoteNotification object:token];
    //    }
    
    
    // todo: enable/needed ?
    //  func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow) -> Int {
    //    var supportInterfaceOrientations:Int = (1 << UIInterfaceOrientation.Portrait) | (1 << UIInterfaceOrientation.LandscapeLeft) | (1 << UIInterfaceOrientation.LandscapeRight) | (1 << UIInterfaceOrientation.PortraitUpsideDown);
    //    return supportInterfaceOrientations;
    //  }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        NSURLCache.sharedURLCache().removeAllCachedResponses();
    }
    
    
    /*
    * All next is `swift` app boiler plate ?
    */
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
