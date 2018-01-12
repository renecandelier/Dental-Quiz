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
            self.tableView.reloadData()
        }
    }
    
    var cellSelected: (() -> Void)?
    
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
    
    func showAnswer() {
        let cleanedAnswer = options.answer.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "")
        options.multipleChoices.forEach { (choice) in
            if choice.hasPrefix(cleanedAnswer) {
                if let index = options.multipleChoices.index(of: choice) {
                    highlightRightAnswer(index: index)
                    // disable cells getting selected
                    // make sure that cells get unselected get on new question
                }
            }
        }
    }
    
    func highlightRightAnswer(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)

        let cell = tableView.cellForRow(at: indexPath)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red:0.14, green:0.80, blue:0.93, alpha:0.3)
        cell?.selectedBackgroundView = backgroundView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showAnswer()
        // fix issue where rational is showing up after selected cell twice
        cellSelected?()
    }
}
