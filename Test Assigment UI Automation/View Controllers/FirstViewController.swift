//
//  ViewController.swift
//  Test Assigment UI Automation
//
//  Created by Alexios on 12/4/21.
//

import UIKit
import Reachability

final class FirstViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet private var zeroCaseView: UIView!
    private var items: [Item] = []
    private var mockServer = MockServer.sharedInstance

    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        title = Titles.firstViewControllerTitle
        
        // register all UICollectionViewCell classes in our UICollectionView
        collectionView.register(BLCollectionViewCell.self, forCellWithReuseIdentifier: BLCollectionViewCell.reuseIdentifierDefault)

        // simulate data loading from the server
        loadDataFromServer()
    }

    private func loadDataFromServer() {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            // make sure we display the zero case view
            zeroCaseView.isHidden = false
        } else {
            // make sure we hide the zero case view
            zeroCaseView.isHidden = true

            // display a loading spinner
            loadingSpinner.startAnimating()
            mockServer.loadDataFromServer { (status, data, error) in
                guard status == true else { return }
                self.loadingSpinner.stopAnimating()
                self.items = data
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func tryLoadDataFromServer(_ sender: Any) {
        loadDataFromServer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // scroll UICollectionView to the top
        collectionView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.firstToSecondViewController {
            let nextViewController = segue.destination as! SecondViewController
            let selectedCellIndexPath = sender as! IndexPath
            let item = items[selectedCellIndexPath.item]
            nextViewController.configure(title: item.title, backgroundColor: item.backgroundColor)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    // Create cell and configure it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BLCollectionViewCell.reuseIdentifierDefault,
            for: indexPath) as! BLCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(index: indexPath.row,
                       title: item.title,
                       backgroundColor: item.backgroundColor)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: nil,
                                                message: AlertMessages.nextScreen + "\(indexPath.row)",
                                                preferredStyle: .alert)
        let noAction = UIAlertAction(title: Titles.no, style: .cancel, handler: nil)
        alertController.addAction(noAction)
        let yesAction = UIAlertAction(title: Titles.yes, style: .default, handler: { _ in
            self.performSegue(withIdentifier: SegueIdentifiers.firstToSecondViewController,
                              sender: indexPath)
        })
        alertController.addAction(yesAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstViewController: UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: 100)
    }
}


