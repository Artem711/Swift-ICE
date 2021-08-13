//
//  AuthRegistrationBlock.swift
//  ICE
//
//  Created by Артём Мошнин on 13/8/21.
//

import SwiftUI

struct AuthRegistrationBlockView: View {
    let title: String
    let description: String
    let time: Int
    let comlpetionStatus: CompletionStatus
    let handler: () -> Void
    
    var body: some View {
        HStack {
            self.statusCircle
            self.content
        }
    }
    
    private var statusCircle: some View {
        Group {
            switch self.comlpetionStatus {
            case .completed:
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 24))
                    .foregroundColor(Color.theme.accent)
            case .completing:
                Circle().foregroundColor(Color.theme.accent)
            case .toBeCompleted:
                Circle().strokeBorder(Color.theme.accent,lineWidth: self.LINE_WIDTH)
            }
                
        }
        .frame(width: self.CIRCLE_SIZE, height: self.CIRCLE_SIZE)
        .padding(.trailing, 10)
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(self.title).titleTextStyle(reduced: true)
                self.timeBadge
            }
            Text(self.description).subtitleTextStyle(reduced: true)
                .padding(.top, 1)
            PrimaryButtonView(title: "Continue", handler: self.handler)
                .padding(.top)
        }
        .padding()
        .background(Color.theme.card)
        .cornerRadius(self.BLOCK_CORNER_RADIUS)
    }
    
    private var timeBadge: some View {
        Text("\(self.time) min")
            .font(.subheadline)
            .foregroundColor(Color.theme.accent)
            .padding(.horizontal, self.BADGE_HORIZONTAL_PADDING)
            .padding(.vertical, self.BADGE_VERTICAL_PADDING)
            .background(RoundedRectangle(cornerRadius: self.BADGE_CORNER_RADIUS).fill(Color.theme.card))
    }
    
    // MARK: - Block constants
    private let BLOCK_CORNER_RADIUS: CGFloat = 10
    // MARK: - Circle constants
    private let CIRCLE_SIZE: CGFloat = 26
    private let LINE_WIDTH: CGFloat = 2
    // MARK: - Badge constants
    private let BADGE_HORIZONTAL_PADDING: CGFloat  = 7
    private let BADGE_VERTICAL_PADDING: CGFloat  = 4
    private let BADGE_CORNER_RADIUS: CGFloat  = 6
    
    
    enum CompletionStatus {
        case completed, completing, toBeCompleted
    }
}

struct AuthRegistrationBlockView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .completed) {}
            
            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .completing) {}
            
            AuthRegistrationBlockView(title: "Personal data", description: "Text Text Text", time: 2, comlpetionStatus: .toBeCompleted) {}
        }
        .previewComponent(with: "AuthRegistrationBlock View", darkOnly: true)
    }
}
