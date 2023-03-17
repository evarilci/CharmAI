//
//  FirstOnboardingViewController.swift
//  CharmAI
//
//  Created by Eymen Varilci on 14.03.2023.
//

import UIKit
import Hero

class FirstOnboardingViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let pageControll = UIPageControl()
    let slides: [OnboardingSlide] = [OnboardingSlide(beginningTitle: "Lorem", EndingTitle: "Ipsum dolor sit", Subtitle: "Ask the bot anything, It's always ready to help!", image: UIImage(named: K.Images.onboardingImage1)!), OnboardingSlide(beginningTitle: "Lorem", EndingTitle: "Ipsum dolor sit", Subtitle: "Get the best answers from our application Enjoy!", image: UIImage(named: K.Images.onboardingImage2)!)]
    let nextButton = CharmButton(title: "Next")
    
    
    var currentPage = 0 {
        didSet {
            pageControll.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get started", for: .normal)
               
            } else {
                nextButton.setTitle("Next", for: .normal)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControll.numberOfPages = slides.count
        view.backgroundColor = .blackBackgroundColor
       
   
       
        
    }
    
    @objc func buttonClicked() {
      
        if self.currentPage == slides.count - 1 {
           let vc = InAppViewController()
            self.navigationController?.pushViewController(vc, animated: true)
          print("end of onboarding")
        } else {
            self.pageControll.currentPage = self.currentPage
            self.currentPage += 1
            print("current page =  \(currentPage)")
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func setupUI() {
        
        

        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
     
        layout.scrollDirection = .horizontal
      
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: K.HomeScreenCellIdentifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        nextButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        pageControll.currentPageIndicatorTintColor = .accentColor
        pageControll.tintColor = .systemGray6
        pageControll.currentPage = 0
        view.addSubview(collectionView)
        view.addSubview(pageControll)
        view.bringSubviewToFront(pageControll)
        view.addSubview(nextButton)
     
        
        pageControll.snp.makeConstraints { make in
                   make.bottom.equalToSuperview { view in
                       view.safeAreaLayoutGuide
                   }.offset(-50)
                   make.centerX.equalToSuperview()
                   make.width.equalToSuperview().multipliedBy(0.7)
                   make.height.equalTo(50)
               }

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(pageControll.snp.top)
        }
        
        
        nextButton.snp.makeConstraints { make in
                make.top.equalTo(pageControll.snp.bottom).offset(8)
                   make.centerX.equalToSuperview()
                   make.width.equalToSuperview().multipliedBy(0.7)
                   make.height.equalTo(50)
               }
        
    }
    
}
extension FirstOnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return slides.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.HomeScreenCellIdentifier, for: indexPath) as! OnboardingCell
         
         cell.setup(slides[indexPath.row])
         return cell
     }
    
 }
 // MARK: UICollectionViewFlowLayout
 extension FirstOnboardingViewController: UICollectionViewDelegateFlowLayout {
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
         
     }
     
     
     // scrolling through pages
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         let width = scrollView.frame.width
         currentPage = Int(scrollView.contentOffset.x / width)
         print("current page =  \(currentPage)")
         
     }
     
     
 }

