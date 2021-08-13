//
//  IndividualAuthView.swift
//  ICE (iOS)
//
//  Created by Артём Мошнин on 12/8/21.
//

import SwiftUI

struct IndividualAuthView: View {
    @EnvironmentObject private var viewModel: AuthViewModel
    let item: AuthNavigationStep
    
    internal init(_ item: AuthNavigationStep) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            self.midheader()
            self.body(items: self.item.text.fields)
            self.footer(next: self.viewModel.moveToNextScreen)
            Spacer()
        }.padding(.horizontal)
    }
    
    private func midheader() -> some View {
        VStack(alignment: .leading) {
            Text(self.item.text.title).titleTextStyle()
            Text(self.item.text.description).subtitleTextStyle()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
    }

    private func body(items: [FormComponent]) -> some View {
        LazyVGrid(columns: [GridItem(.flexible(minimum: 44))], spacing: 20) {
            ForEach(items) { item in
                item.view(component: item)
            }
        }
    }

    private func footer(next: @escaping () -> ()) -> some View {
        HStack {
            Spacer()
            Button("Next", action: next)
        }
    }

    private func backButton(back: @escaping () -> ()) -> some View {
        Button(action: back) {
            HStack {
                Image("ic_back")
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Text("Go back")
            }
        }
    }

}

struct IndividualAuthView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualAuthView(AuthNavigationStep.verifyPhoneNumber)
            .environmentObject(AuthViewModel())
    }
}
