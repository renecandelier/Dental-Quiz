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
    var isFirstQuestion = true
    var isLastQuestion = false
    let showRationalText = "Show Rationale"
    let showAnswerText = "Show Answer"
    
    var isRationalVisible: Bool {
        return rationalContainerViewTopConstraint.isActive
    }
    
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
        if rationalContainerViewTopConstraint.isActive {
            rationalSelected()
        }
        showAnswerButton.setTitle(showAnswerText, for: .normal)
        chapterNumberLabel.text = "Chapter " + question.chapterNumber
        questionNumberLabel.text = "Question " + question.questionNumber + "/\(chapterQuestions.count)"
        questionTitleLabel.text = question.questionTitle
        let question = chapterQuestions[currentQuestion]
        multipleQuestionsTableViewController?.options = (question.multipleChoices, question.answer)
        multipleQuestionsTableViewController?.cellSelected = animateRational
        multipleQuestionsTableViewController?.questionInfo = question

        rationalViewController?.rationalText = question.rationale
        rationalViewController?.rationalTapHandler = rationalSelected
    }
    
    @IBAction func previousButtonSelected(_ sender: UIButton) {
        isFirstQuestion = currentQuestion == 1
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
        let questionDictionary = chapterQuestions[currentQuestion].dictionary
        if showAnswerButton.titleLabel?.text == showAnswerText {
            track(event: "Show Answer Selected", properties: questionDictionary)
            multipleQuestionsTableViewController?.showRightAnswers()
            animateRational()
        } else {
            track(event: "Rational Selected", properties: questionDictionary)
            rationalSelected()
        }
    }
    
    func animateRational() {

        showAnswerButton.setTitle(showRationalText, for: .normal)
//            UIView.animate(withDuration: 0.2) {
//                self.rationalContainerView.frame.origin.y -= 40
//                self.view.layoutIfNeeded()
//            }
//        }
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        goToNextQuestion()
    }
    
    @IBAction func rightSwipe(_ sender: UISwipeGestureRecognizer) {
        goToPreviousQuestion()
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
                upcoming.questionInfo = question
            }
        case RationalViewController.className:
            if let upcoming = segue.destination as? RationalViewController, chapterQuestions.count > 0 {
                upcoming.rationalTapHandler = rationalSelected
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
        track(event: "next swipe", properties: chapterQuestions[currentQuestion].dictionary)
    }
    
    func goToPreviousQuestion() {
        if currentQuestion == 0 { return }
        currentQuestion -= 1
        loadViewWithData(question: chapterQuestions[currentQuestion])
        track(event: "previous swipe", properties: chapterQuestions[currentQuestion].dictionary)
    }
}
