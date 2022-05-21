//
//  History.swift
//  Scrumdinger
//
//  Created by Rafael Orofino on 15/05/22.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var lenghInMinutes: Int
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], lenghInMinutes: Int = 5, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lenghInMinutes = lenghInMinutes
        self.transcript = transcript
    }
}
