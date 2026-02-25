//
//  OnBoardingSplashScreen1ViewController.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 19/02/2026.
//

import UIKit

class OnBoardingScreen1ViewController: UIViewController, CoordinatorBoard, UICollectionViewDelegate, UICollectionViewDataSource {
    
  
    @IBOutlet weak var nextButton: CustomButton!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    weak var mainCoordinator: MainCoordinator?
    var imgArr = [
        "img1",
        "img2",
        "img3",
        "img4"
    ]
    var imgArr2 = [
        "img5",
        "img6",
        "img7",
        "img8"
    ]
    
    @IBOutlet weak var imageCollectionView2: UICollectionView!
    let multiplier = 1000
    var timer: Timer?
    func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { [weak self] _ in
            self?.scrollCollectionViews()
        }
    }
    func scrollCollectionViews() {

        let offset1 = imageCollectionView.contentOffset
        let nextOffset1 = CGPoint(x: offset1.x + 1.0, y: offset1.y)

        let offset2 = imageCollectionView2.contentOffset
        let nextOffset2 = CGPoint(x: offset2.x - 1.0, y: offset2.y)

        imageCollectionView.setContentOffset(nextOffset1, animated: false)
        imageCollectionView2.setContentOffset(nextOffset2, animated: false)

        resetOffsetIfNeeded()
    }
    func resetOffsetIfNeeded() {

        let maxOffset1 = imageCollectionView.contentSize.width - imageCollectionView.bounds.width
        if imageCollectionView.contentOffset.x >= maxOffset1 {
            imageCollectionView.contentOffset = .zero
        }

        if imageCollectionView2.contentOffset.x <= 0 {
            let resetX = imageCollectionView2.contentSize.width - imageCollectionView2.bounds.width
            imageCollectionView2.contentOffset = CGPoint(x: resetX, y: 0)
        }
    }

    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == imageCollectionView {
                return imgArr.count * multiplier
            } else {
                return imgArr2.count * multiplier
            }
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MovieCell",
            for: indexPath
        ) as! MovieCellCollectionViewCell

        if collectionView == imageCollectionView {
            let imageName = imgArr[indexPath.item % imgArr.count]
            cell.imageView.image = UIImage(named: imageName)
        } else {
            let imageName = imgArr2[indexPath.item % imgArr2.count]
            cell.imageView.image = UIImage(named: imageName)
        }

        return cell
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        mainCoordinator?.skipButtonTapped()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView2.delegate = self
        imageCollectionView2.dataSource = self
        nextButton.onTap = {
            self.mainCoordinator?.onBoardingScreen1NextButtonTapped()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAutoScroll()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}

extension OnBoardingScreen1ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = height * 0.7
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
