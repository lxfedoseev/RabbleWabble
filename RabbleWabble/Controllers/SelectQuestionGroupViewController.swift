//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Alex Fedoseev on 07.12.2018.
//  Copyright © 2018 Alex Fedoseev. All rights reserved.
//

import UIKit
public class SelectQuestionGroupViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    // MARK: - Properties
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int)
        -> Int {
            return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
            let questionGroup = questionGroups[indexPath.row]
            cell.titleLabel.text = questionGroup.title
            return cell
    }
    
}

// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    // 1
    public func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath)
        -> IndexPath? {
            selectedQuestionGroup = questionGroups[indexPath.row]
            return indexPath
    }
    // 2
    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // 3
    public override func prepare(for segue: UIStoryboardSegue,
                                 sender: Any?) {
        guard let viewController = segue.destination
            as? QuestionViewController else { return }
        viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
        viewController.delegate = self
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController:
QuestionViewControllerDelegate {
    func questionViewController(
        _ viewController: QuestionViewController,
        didCancel questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }
    func questionViewController(
        _ viewController: QuestionViewController,
        didComplete questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }
}
