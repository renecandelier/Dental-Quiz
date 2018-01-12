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
        "Microbiology/Immunology",
        "Nutrition",
        "Oral Pathology",
        "Oral/Dental Anatomy",
        "Periodontolgy",
        "9.1 Pharmacology",
        "9.2 Pharmacology",
        "N/A",
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
        //var chapterNumber = "" //\(indexPath.row + 1) -
        
//        if [9,10].contains(row + 1) {
//            if row + 1 == 9 {
//                chapterNumber = "9.1 - "
//            }
//            if row + 1 == 10 {
//                chapterNumber = "9.2 - "
//            }
//        }
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
//                if cellRow + 1 == 9 {
//                    chapter = "chapter91"
//                }
//                if cellRow + 1 == 10 {
//                    chapter = "chapter92"
//                }
                upcoming.chapter = chapter
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if [8, 4, 11].contains(indexPath.row + 1) {
            let chapterAlert = UIAlertController(title: "Chapter", message: "No questions found in this chapter", preferredStyle: .alert)
            chapterAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(chapterAlert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: QuestionViewController.className, sender: self)
        }
    }

}
