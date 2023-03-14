//
//  PageViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit

class PageViewController: UIViewController {

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var pagecontroller = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//    let pageControl = UIPageControl()
//    var pages = [FirstOnboardingViewController(), SecondOnboardingViewController()]
//    let initialPage = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configurePageControl()
//        arrangeSubviews()
//        pagecontroller.dataSource = self
//        pagecontroller.delegate = self
//
//        pagecontroller.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
//
//    }
//
//    func configurePageControl() {
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = 0
//        pageControl.direction = .natural
//        pageControl.currentPageIndicatorTintColor = UIColor.black
//        pageControl.pageIndicatorTintColor = UIColor.lightGray
//        pageControl.currentPageIndicatorTintColor = UIColor.green
//        pageControl.currentPage = initialPage
//        pageControl.backgroundStyle = .minimal
//
//    }
//
//    func arrangeSubviews() {
//        view.addSubview(pageControl)
//        pageControl.snp.makeConstraints { make in
//            make.bottom.equalToSuperview { view in
//                view.safeAreaLayoutGuide
//            }.inset(50)
//            make.width.equalToSuperview().inset(20)
//            make.height.equalTo(20)
//            make.centerX.equalToSuperview()
//        }
//
//    }
//
//}
//
//
//extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate   {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.pages.firstIndex(of: viewController as! FirstOnboardingViewController) {
//                    if viewControllerIndex == 0 {
//                        return self.pages.last
//                    } else {
//                        return self.pages[viewControllerIndex - 1]
//                    }
//                }
//                return nil
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let viewControllerIndex = self.pages.firstIndex(of: viewController as! FirstOnboardingViewController) {
//                   if viewControllerIndex < self.pages.count - 1 {
//                       // go to next page in array
//                       return self.pages[viewControllerIndex + 1]
//                   } else {
//                       // wrap to first page in array
//                       return self.pages.first
//                   }
//               }
//               return nil
//    }
//
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//
//
//           if let viewControllers = pageViewController.viewControllers {
//               if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0] as! FirstOnboardingViewController) {
//                   self.pageControl.currentPage = viewControllerIndex
//               }
//           }
//       }
//
}
//
//extension UIPageViewController {
//
//}
