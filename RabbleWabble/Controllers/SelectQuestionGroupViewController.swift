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
    private let questionGroupCaretaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup] {
        return questionGroupCaretaker.questionGroups
    }
    private var selectedQuestionGroup: QuestionGroup! {
        get { return questionGroupCaretaker.selectedQuestionGroup }
        set { questionGroupCaretaker.selectedQuestionGroup = newValue }
    }
    private let appSettings = AppSettings.shared
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        questionGroups.forEach {
            print("\($0.title): " +
                "correctCount \($0.score.correctCount), " +
                "incorrectCount \($0.score.incorrectCount)"
            )
        }
    }
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
            
            // 1
            questionGroup.score.runningPercentage.addObserver(
            cell, options: [.initial, .new]) {
                // 2
                [weak cell] (percentage, _) in
                // 3
                DispatchQueue.main.async {
                    // 4
                    cell?.percentageLabel.text = String(format: "%.0f %%",
                                                        round(100 * percentage))
                }
            }
            
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
        viewController.questionStrategy =
            appSettings.questionStrategy(for: questionGroupCaretaker)
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
