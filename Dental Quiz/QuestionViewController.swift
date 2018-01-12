//
//  ViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/6/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
//    @IBOutlet weak var chapterTitleLabel: UILabel!
    @IBOutlet weak var chapterNumberLabel: UILabel!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var rationalContainerView: UIView!
    @IBOutlet weak var rationalBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rationalContainerViewTopConstraint: NSLayoutConstraint!
    var chapterQuestions = [Question]()
    var currentQuestion = 0
    var chapter = ""
    
    fileprivate var multipleQuestionsTableViewController: MultipleChoiceTableViewController?
    fileprivate var rationalViewController: RationalViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let questions = parseQuestionsFromPList(plistName: chapter) else {
//            nextButton.isEnabled = true
            return
        }
        guard let multipleChoiceTVC = childViewControllers.first as? MultipleChoiceTableViewController else { return }
        multipleQuestionsTableViewController = multipleChoiceTVC
        guard let rationalVC = childViewControllers[1] as? RationalViewController else { return }
        rationalViewController = rationalVC
        chapterQuestions = questions
        loadViewWithData(question: chapterQuestions[currentQuestion])
        title = chapterQuestions.first?.chapterTitle
//        previousButton.isEnabled = false
    }
    
    func loadViewWithData(question: Question) {
        chapterNumberLabel.text = "Chapter " + question.chapterNumber
        questionNumberLabel.text = "Question " + question.questionNumber + "/\(chapterQuestions.count)"
        questionTitleLabel.text = question.questionTitle
        let question = chapterQuestions[currentQuestion]
        multipleQuestionsTableViewController?.options = (question.multipleChoices, question.answer)
        multipleQuestionsTableViewController?.cellSelected = animateRational
        rationalViewController?.rationalText = question.rationale
        rationalViewController?.tapHandler = rationalSelected
    }
    
    @IBAction func previousButtonSelected(_ sender: UIButton) {
//        let isFirstQuestion = currentQuestion == 1
//        previousButton.isEnabled = !isFirstQuestion
        if currentQuestion == 0 { return }
        currentQuestion -= 1
//        nextButton.isEnabled = true

        loadViewWithData(question: chapterQuestions[currentQuestion])
    }
    
    @IBAction func nextButtonSelected(_ sender: UIButton) {
        currentQuestion += 1
        let isLastQuestion = currentQuestion == chapterQuestions.count
        if isLastQuestion  { return }
        loadViewWithData(question: chapterQuestions[currentQuestion])

//        nextButton.isEnabled = currentQuestion != chapterQuestions.count - 1
//        previousButton.isEnabled = true
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        multipleQuestionsTableViewController?.showAnswer()
        animateRational()
    }
    
    func animateRational() {
        UIView.animate(withDuration: 0.2) {
            self.rationalContainerView.frame.origin.y -= 40
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        currentQuestion += 1
        let isLastQuestion = currentQuestion == chapterQuestions.count
        if isLastQuestion  { return }
        loadViewWithData(question: chapterQuestions[currentQuestion])
//        nextButton.isEnabled = currentQuestion != chapterQuestions.count - 1
//        previousButton.isEnabled = true
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
//        let isFirstQuestion = currentQuestion == 1
//        previousButton.isEnabled = !isFirstQuestion
        if currentQuestion == 0 { return }
        currentQuestion -= 1
//        nextButton.isEnabled = true
        loadViewWithData(question: chapterQuestions[currentQuestion])
    }
    
    func rationalSelected() {
        let isShowingRational = rationalContainerViewTopConstraint.isActive
        self.rationalContainerViewTopConstraint.isActive = !isShowingRational
        self.rationalBottomConstraint.isActive = isShowingRational
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case MultipleChoiceTableViewController.className:
            if let upcoming = segue.destination as? MultipleChoiceTableViewController, chapterQuestions.count > 0 {
                multipleQuestionsTableViewController = upcoming
                upcoming.cellSelected = animateRational
                let question = chapterQuestions[currentQuestion]
                upcoming.options = (question.multipleChoices, question.answer)
            }
        case RationalViewController.className:
            if let upcoming = segue.destination as? RationalViewController, chapterQuestions.count > 0 {
                upcoming.tapHandler = rationalSelected
                rationalViewController = upcoming
                upcoming.rationalText = chapterQuestions[currentQuestion].rationale
            }
        default:
            break
        }
    }
    
}
