//
//  MultipleChoiceTableViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/25/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
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
    var chapterInfo = [String: String]()
    var answer = ""

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
        let range = NSMakeRange(0, 2)
        cell.choiceLabel.attributedText = attString(from: optionText, nonBoldRange: range)
        tableView.scrollsToTop = true

        return cell
    }
    
    func attString(from string: String, nonBoldRange: NSRange?) -> NSAttributedString {
        let fontSize = UIFont.systemFontSize
        let attrs = [
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)]
        let nonBoldAttribute = [
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: fontSize),
            ]
        let attrStr = NSMutableAttributedString(string: string, attributes: attrs)
        if let range = nonBoldRange {
            attrStr.setAttributes(nonBoldAttribute, range: range)
        }
        return attrStr
    }
    
    func getAnswers() {
        answers.removeAll()
        let cleanedAnswers = Array(options.answer.trimmingCharacters(in: .punctuationCharacters).trimmingCharacters(in: .whitespaces))
        cleanedAnswers.forEach { (cleanedAnswer) in
            options.multipleChoices.forEach { (choice) in
                if choice.hasPrefix(String(cleanedAnswer)) {
                    if let index = options.multipleChoices.index(of: choice) {
                        answers.append(index)
                    }
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
            let answerData = ["Chapter Title": questionInfo.chapterTitle,
                              "answer selected" : "\(indexPath.row)",
                "chapter number": questionInfo.chapterNumber,
                "question number" : questionInfo.questionNumber,
                "question Title": questionInfo.questionTitle]
            track(event: "Incorrect Answer Selected", properties: answerData)
            highlightCell(indexPath: indexPath, backgroundColor: UIColor(red:1, green:28/255, blue:0, alpha:0.1))
        }
    }
    
    func showRightAnswers() {
        answers.forEach { (a) in
            let indexPath = IndexPath(row: a, section: 0)
            highlightCell(indexPath: indexPath, backgroundColor: UIColor(red:0.14, green:0.80, blue:0.93, alpha:0.3))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showRightAnswers()
        showSelectedAnswer(indexPath: indexPath)
        self.tableView.isUserInteractionEnabled = false
        cellSelected?()
    }
}
