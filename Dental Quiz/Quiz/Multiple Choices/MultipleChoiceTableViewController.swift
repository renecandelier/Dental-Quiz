//
//  MultipleChoiceTableViewController.swift
//  Dental Quiz
//

import UIKit

class MultipleChoiceTableViewController: UITableViewController {
    
    var options = (multipleChoices:[String](), answer: "") {
        didSet {
            getAnswers()
            self.tableView.reloadData()
            self.tableView.isUserInteractionEnabled = true
        }
    }
    
    var cellSelected: (() -> Void)?
    var answers = [Int]()
    var questionInfo = Question()

    // MARK: - Table view data source
    
    override func viewDidLoad() {
        self.tableView.separatorColor = .clear
        tableView.alwaysBounceVertical = false
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.multipleChoices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChoiceTableViewCell.className, for: indexPath) as! ChoiceTableViewCell
        let optionText = options.multipleChoices[indexPath.row]
        cell.choiceLabel.attributedText = Utils.boldText(from: optionText, boldRange: NSMakeRange(0, 2))
        tableView.scrollsToTop = true
        return cell
    }
    
    func getAnswers() {
        answers.removeAll()
        // Remove all periods (.) and spaces
        let cleanedAnswers = Array(options.answer.trimmingCharacters(in: .punctuationCharacters).trimmingCharacters(in: .whitespaces))
        
        cleanedAnswers.forEach { (cleanedAnswer) in
            options.multipleChoices.forEach { (choice) in
                if choice.hasPrefix(String(cleanedAnswer)), let index = options.multipleChoices.index(of: choice) {
                    answers.append(index)
                }
            }
        }
    }
    
    func highlightCell(indexPath: IndexPath, backgroundColor: UIColor) {
        let cell = tableView.cellForRow(at: indexPath)
        let backgroundView = UIView()
        backgroundView.backgroundColor = backgroundColor
        cell?.selectedBackgroundView = backgroundView
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
    
    func showSelectedAnswer(indexPath: IndexPath) {
        if !answers.contains(indexPath.row) {
            highlightCell(indexPath: indexPath, backgroundColor: Colors.red)
        }
    }
    
    func showRightAnswers() {
        answers.forEach { (option) in
            let indexPath = IndexPath(row: option, section: 0)
            highlightCell(indexPath: indexPath, backgroundColor: Colors.lightBlue)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRightAnswers()
        showSelectedAnswer(indexPath: indexPath)
        self.tableView.isUserInteractionEnabled = false
        cellSelected?()
    }
}
