//
//  ViewController.swift
//  clova-takizawa
//
//  Created by 下村一将 on 2018/07/21.
//  Copyright © 2018 kazu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TopViewController: UIViewController {
    static func make() -> TopViewController {
        return R.storyboard.topViewController.instantiateInitialViewController()!
    }

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let flowLayout = UICollectionViewFlowLayout()
//        let margin: CGFloat = 3.0
//        flowLayout.itemSize = CGSize(width: 100.0, height: 100.0)
//        flowLayout.minimumInteritemSpacing = margin
//        flowLayout.minimumLineSpacing = margin
//        flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
//
//        collectionView.collectionViewLayout = flowLayout

        navigationItem.titleView = UIImageView(image: R.image.icon()!)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()

        if ClovaManager.shared.registerdClovas.count == 0 {
            backImageView.image = R.image.back2()
        } else {
            backImageView.image = R.image.back1()
        }
    }

    @IBAction func addEventButtonTapped(_ sender: Any) {
        let vc = AddClovaViewController.make()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func messageButtonTapped(_ sender: Any) {
        let vc = DmListViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ClovaManager.shared.registerdClovas.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.topCollectionVIewCell, for: indexPath)!
        cell.backgroundColor = .white
        cell.titleLabel?.text = ClovaManager.shared.registerdClovas[indexPath.row].eventName
//        cell.imageView.image =
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ClovaSpeechListViewController.make(eventName: ClovaManager.shared.registerdClovas[indexPath.row].eventName, chats: [])
        navigationController?.pushViewController(vc, animated: true)
    }
}

class TopViewControllerCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = UIScreen.main.bounds.width / 2 - 5
        let height = width
        return CGSize(width: width, height: height)
    }
}
