import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vm1 = MyCollectionViewModel(
            localDatabase: LocalDatabaseImpl(),
            authenticationService: AuthenticationServiceImpl(),
            connectivityChecker: ConnectivityCheckerImpl()
        )
        let vc1 = self.createViewController(
            viewModel: vm1
        )
        
        let vc2 = self.createViewController(
            viewModel: MyProfileViewModel(
                authenticationService: AuthenticationServiceImpl(),
                alertDisplayer: AlertDisplayerImpl(),
                myCollectionDelegate: vm1
            )
        )
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        nav1.tabBarItem = UITabBarItem(title: L10n.myCollection, image: UIImage(systemName: "square.grid.3x3.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: L10n.myProfile, image: UIImage(systemName: "person.fill"), tag: 2)
        
        setViewControllers([nav1, nav2], animated: false)
        tabBar.tintColor = .systemRed
    }
    
    private func createViewController(viewModel: CollectionViewModel) -> UIViewController {
        var viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        let containerController = ContainerViewController(
            viewModel: viewModel,
            layout: layout
        )
        viewModel.containerDelegate = containerController
        return containerController
    }
}
