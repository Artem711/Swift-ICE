import SwiftUI


struct ScrollerView<T: ModuleNavigator>: View where T.AllCases: RandomAccessCollection, T.RawValue: StringProtocol {
    let items: T.Type
    @Binding var selectedView: T
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                HStack(spacing: 12) {
                    ForEach(self.items.allCases) { item in
                        let isSelected = self.selectedView == item
                        HStack {
                            Image(systemName: item.icon)
                                .font(.caption)
                            Text(item.rawValue)
                        }
                        .foregroundColor(isSelected ? Color.theme.text : Color.theme.subText)
                        .padding(.vertical, 6) .padding(.horizontal)
                        .background(isSelected ? Color.theme.card : nil)
                        .cornerRadius(8)
                        .onTapGesture { self.selectedView = item }
                        .id(item)
                        .onChange(of: isSelected, perform: { _ in
                            withAnimation { value.scrollTo(self.selectedView, anchor: .center) }
                        })
                    }
                }
                .padding()
            }
        }
    }
}

struct TopScroller_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScrollerView(items: HomeNavigation.self, selectedView: .constant(HomeNavigation.overview))
            
            ScrollerView(items: HomeNavigation.self, selectedView: .constant(HomeNavigation.overview)) .preferredColorScheme(.dark)
            
        } .previewLayout(.sizeThatFits) }
    
}
