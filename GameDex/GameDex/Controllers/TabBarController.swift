import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = ViewController()
        let vc2 = ViewController()
        let vc3 = ViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.tabBarItem = UITabBarItem(title: NSLocalizedString("myCollection", comment: ""), image: UIImage(systemName: "square.grid.3x3.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: NSLocalizedString("discover", comment: ""), image: UIImage(systemName: "doc.text.magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: NSLocalizedString("myProfile", comment: ""), image: UIImage(systemName: "person.fill"), tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: false)
        tabBar.tintColor = .systemRed
    }
}
