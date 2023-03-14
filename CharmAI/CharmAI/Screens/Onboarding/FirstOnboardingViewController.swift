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
        view.backgroundColor = .black
        
       
        
    }
    
    @objc func buttonClicked() {
        if currentPage == slides.count - 1 {
          print("end of onboarding")
        } else {
            currentPage += 1
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
        
        view.addSubview(collectionView)
        view.addSubview(pageControll)
        view.bringSubviewToFront(pageControll)
        view.addSubview(nextButton)
        
        
        nextButton.snp.makeConstraints { make in
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
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        
        pageControll.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top)
            make.width.equalTo(30)
            make.height.equalTo(7)
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
         currentPage = Int(self.collectionView.contentOffset.x / width)
         
     }
     
     
 }

     
//
//    let onboardingImage: UIImageView = {
//       let iv = UIImageView()
//        iv.image = UIImage(named: K.Images.onboardingImage1)
//        iv.clipsToBounds = true
//        return iv
//    }()
//    private let titleLabelBeginning : UILabel = {
//       let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 25)
//        label.text = "Lorem"
//        label.textAlignment = .right
//        label.textColor = .white
//        return label
//    }()
//
//    private let titleLabelEnding : UILabel = {
//       let label = UILabel()
//        label.font = .boldSystemFont(ofSize: 25)
//        label.text = "Ipsum dolor sit"
//        label.textAlignment = .left
//        label.textColor = .accentColor
//        return label
//    }()
//
//     let subtitleLabel : UILabel = {
//       let label = UILabel()
//        label.font = UIFont(name: "Helvetica-Neue", size: 17)
//        label.text = "Ask the bot anything, It's always ready to help!"
//        label.textAlignment = .center
//        label.numberOfLines = 2
//        label.textColor = .white
//        return label
//    }()
//
//     let pageView: UIImageView = {
//       let iv = UIImageView()
//        iv.image = UIImage(named: K.Images.slider1)
//        iv.clipsToBounds = true
//        iv.hero.id = "page"
//        return iv
//    }()
//
//
//     let nextButton = CharmButton(title: "Next")
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.isHeroEnabled = true
//        self.navigationController!.hero.navigationAnimationType = .cover(direction: .left)
//        self.navigationController!.hero.modalAnimationType = .pageOut(direction: .left)
//        setupUI()
//
//    }
//
//    func setupUI() {
//        let stack = UIStackView(arrangedSubviews: [titleLabelBeginning,titleLabelEnding])
//        stack.axis = .horizontal
//        stack.distribution = .fillProportionally
//        stack.spacing = 5
//        view.backgroundColor = .black
//
//
//        let action = UIAction { _ in
//            let nc = UINavigationController(rootViewController: SecondOnboardingViewController())
//            nc.hero.isEnabled = true
//            self.navigationController?.pushViewController(SecondOnboardingViewController(), animated: true)
//        }
//        nextButton.addAction(action, for: .touchUpInside)
//
//        view.addSubview(onboardingImage)
//        view.addSubview(stack)
//        view.addSubview(subtitleLabel)
//        view.addSubview(nextButton)
//        view.addSubview(pageView)
//
//
//
//
//        onboardingImage.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.height.equalTo(onboardingImage.snp.width)
//        }
//        stack.snp.makeConstraints { make in
//            make.top.equalTo(onboardingImage.snp.bottom).offset(16)
//            make.centerX.equalTo(onboardingImage.snp.centerX)
//            make.height.equalTo(50)
//
//
//        }
//
//        subtitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(stack.snp.bottom).offset(24)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(75)
//            make.width.equalTo(stack.snp.width)
//        }
//
//        nextButton.snp.makeConstraints { make in
//            make.bottom.equalToSuperview { view in
//                view.safeAreaLayoutGuide
//            }.inset(24)
//            make.centerX.equalToSuperview()
//            make.width.equalToSuperview().multipliedBy(0.7)
//            make.height.equalTo(50)
//        }
//
//        pageView.snp.makeConstraints { make in
//            make.bottom.equalTo(nextButton.snp.top).offset(-16)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(40)
//            make.height.equalTo(4)
//        }
//
//
//    }

//}

