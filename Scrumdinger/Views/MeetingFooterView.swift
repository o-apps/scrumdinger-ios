//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Rafael Orofino on 15/05/22.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    private var speakerNumber: Int? {
        guard let index = self.speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    private var speakersText: String {
        guard let speakerNumber = self.speakerNumber else { return "No more speakers" }
        
        return "Speaker \(speakerNumber) of \(self.speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(self.speakersText)
                    
                    Spacer()
                    
                    Button(action: self.skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
