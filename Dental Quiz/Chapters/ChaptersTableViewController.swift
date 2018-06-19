//
//  ChaptersTableViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/19/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import UIKit
import Mixpanel

class ChaptersTableViewController: UITableViewController {
    
    let chapterTitles = [
        "Ch 1. Clinical Dental Hygiene/Fluoride",
        "Ch 2. Community Dental Health",
        "Ch 3. Dental Materials",
        "Ch 4. Nutrition",
        "Ch 5. Oral Pathology",
        "Ch 6. Oral/Dental Anatomy",
        "Ch 7. Pharmacology",
        "Ch 8. Professional Responsibility",
        "Ch 9. Radiology",
        "Ch 10. Special Needs Patients",
        "Ch 11. Microbiology",
        "Ch 12. Periodontology"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Analytics.track(event: Analytics.Events.chapters)
        UserDefaults.standard.set(true, forKey: User.userLoggedIn)

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapterTitles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChapterTableViewCell.className, for: indexPath) as! ChapterTableViewCell
        let row = indexPath.row
        cell.chapterLabel.text = chapterTitles[row]
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == QuestionViewController.className {
            if let questionViewController = segue.destination as? QuestionViewController {
                let cellRow = tableView.indexPathForSelectedRow?.row ?? 0
                let chapter = "chapter" + "\(cellRow + 1)"
                Analytics.track(event: Analytics.Events.chapterSelected, properties: ["chapter": chapter])
                questionViewController.chapter = chapter
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: QuestionViewController.className, sender: self)
    }

}
