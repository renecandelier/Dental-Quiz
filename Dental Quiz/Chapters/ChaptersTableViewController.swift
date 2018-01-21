//
//  ChaptersTableViewController.swift
//  Dental Quiz
//
//  Created by Rene Candelier on 12/19/17.
//  Copyright © 2017 Novus Mobile. All rights reserved.
//

import UIKit

class ChaptersTableViewController: UITableViewController {
    
    let chapterTitles = [
        "Clinical Dental Hygiene/Flouride",
        "Community Dental Health",
        "Dental Materials",
        "Nutrition",
        "Oral Pathology",
        "Oral/Dental Anatomy",
        "Pharmacology",
        "Professional Responsibility",
        "Radiology",
        "Special Needs Patients"
    ]
    
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == QuestionViewController.className {
            if let upcoming = segue.destination as? QuestionViewController {
                let cellRow = tableView.indexPathForSelectedRow?.row ?? 0
                let chapter = "chapter" + "\(cellRow + 1)"
                upcoming.chapter = chapter
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: QuestionViewController.className, sender: self)
    }

}
