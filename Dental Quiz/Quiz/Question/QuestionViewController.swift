//
//  ViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/6/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var chapterNumberLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var rationalContainerView: UIView!
    @IBOutlet weak var rationalBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var rationalContainerViewTopConstraint: NSLayoutConstraint!
    var chapterQuestions = [Question]()
    var currentQuestion = 0
    var chapter = ""
    let showRationaleText = "Show Rationale"
    let showAnswerText = "Show Answer"
    
    fileprivate var multipleQuestionsTableViewController: MultipleChoiceTableViewController?
    fileprivate var rationalViewController: RationalViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let questions = parseQuestionsFromPList(plistName: chapter) else {
            return
        }
        guard let multipleChoiceTVC = childViewControllers.first as? MultipleChoiceTableViewController else { return }
        multipleQuestionsTableViewController = multipleChoiceTVC
        guard let rationalVC = childViewControllers[1] as? RationalViewController else { return }
        rationalViewController = rationalVC
        chapterQuestions = questions
        loadViewWithData(question: chapterQuestions[currentQuestion])
        title = chapterQuestions.first?.chapterTitle
    }
    
    func loadViewWithData(question: Question) {
        if rationalContainerViewTopConstraint.isActive {
            animateRationale()
        }
        showAnswerButton.setTitle(showAnswerText, for: .normal)
        chapterNumberLabel.text = "Chapter " + question.chapterNumber
        questionNumberLabel.text = "Question " + question.questionNumber + "/\(chapterQuestions.count)"
        questionTitleLabel.text = question.questionTitle
        
        // Update Multiple Questions
        multipleQuestionsTableViewController?.options = (question.multipleChoices, question.answer)
        multipleQuestionsTableViewController?.cellSelected = updatedShowAnswerButtonTitle
        multipleQuestionsTableViewController?.questionInfo = question
        
        // Update Rationale View
        rationalViewController?.rationalText = question.rationale
        rationalViewController?.rationalTapHandler = animateRationale
    }
    
    @IBAction func showAnswer(_ sender: UIButton) {
        let questionDictionary = chapterQuestions[currentQuestion].dictionary
        if showAnswerButton.titleLabel?.text == showAnswerText {
            Analytics.track(event: Analytics.Events.answerButtonSelected, properties: questionDictionary)
            multipleQuestionsTableViewController?.showRightAnswers()
            updatedShowAnswerButtonTitle()
        } else {
            Analytics.track(event: Analytics.Events.rationaleButtonSelected, properties: questionDictionary)
            animateRationale()
        }
    }
    
    func updatedShowAnswerButtonTitle() {
        showAnswerButton.setTitle(showRationaleText, for: .normal)
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        goToNextQuestion()
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        goToPreviousQuestion()
    }
    
    func animateRationale() {
        let isShowingRationale = rationalContainerViewTopConstraint.isActive
        self.rationalContainerViewTopConstraint.isActive = !isShowingRationale
        self.rationalBottomConstraint.isActive = isShowingRationale
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
                upcoming.cellSelected = updatedShowAnswerButtonTitle
                let question = chapterQuestions[currentQuestion]
                upcoming.options = (question.multipleChoices, question.answer)
                upcoming.questionInfo = question
            }
        case RationalViewController.className:
            if let upcoming = segue.destination as? RationalViewController, chapterQuestions.count > 0 {
                upcoming.rationalTapHandler = animateRationale
                rationalViewController = upcoming
                upcoming.rationalText = chapterQuestions[currentQuestion].rationale
            }
        default:
            break
        }
    }
    
}

extension QuestionViewController {
    
    func goToNextQuestion() {
        let isLastQuestion = currentQuestion == chapterQuestions.count - 1
        if isLastQuestion  { return }
        currentQuestion += 1
        loadViewWithData(question: chapterQuestions[currentQuestion])
        Analytics.track(event: Analytics.Events.nextSwipe, properties: chapterQuestions[currentQuestion].dictionary)
    }
    
    func goToPreviousQuestion() {
        if currentQuestion == 0 { return }
        currentQuestion -= 1
        loadViewWithData(question: chapterQuestions[currentQuestion])
        Analytics.track(event: Analytics.Events.previousSwipe, properties: chapterQuestions[currentQuestion].dictionary)
    }
}
