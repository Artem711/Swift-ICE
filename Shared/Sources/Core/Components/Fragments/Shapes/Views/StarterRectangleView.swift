//
//  SwiftUIView.swift
//  ICE
//
//  Created by Артём Мошнин on 6/8/21.
//

import SwiftUI

struct StarterRectangleView: View {
    let data: SectionPreviewData
    @AppStorage var hasInitiatedSection: Bool
    
    init(data: SectionPreviewData, userDefaultsIdentifier: String) {
        self.data = data
        self._hasInitiatedSection = AppStorage(wrappedValue: false, userDefaultsIdentifier)
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
                    Text(self.data.title)
                        .foregroundColor(Color.theme.text)
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding()
                        .background(Color.theme.cardLayerOne.cornerRadius(120, corners: [.bottomRight]).cornerRadius(10, corners: [.bottomLeft]))
                        .frame(maxWidth: 220)
                    Spacer()
                    Image(systemName: "star")
                        .padding(.top, 6)
                }
            }.padding()
            Spacer()
            self.footer
        }
        .background(Color.theme.card)
        .frame(maxHeight: 340)
        .cornerRadius(10)
    }
    
    var footer: some View {
        HStack(spacing: 15) {
            Spacer()
            Text(self.data.description)
                    .foregroundColor(Color.theme.subText)
                    .font(.caption2)
                .lineLimit(3)
            Spacer()
//                PrimaryButtonView(title: "Get started", backgroundColor: Color.theme.text) {
//                    print("clicked")
//                    withAnimation {
//                        self.hasInitiatedSection = true
//                    }
//                }
            Spacer()
        }.padding(.vertical, 10)
        .background(Color.theme.cardLayerOne)
    }
}

struct StarterRectangle_Previews: PreviewProvider {
    static var previews: some View {
        StarterRectangleView(data: (title: "Auto investing", description: "Invest completely automatically", image: "person"), userDefaultsIdentifier: "")
            .previewComponent(with: "RectangleShape")
    }
}
