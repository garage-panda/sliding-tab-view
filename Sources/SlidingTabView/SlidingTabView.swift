import SwiftUI

@available(macOS 10.15, *)
struct SlidingTabView : View {
    
    // MARK: Internal State
    
    /// Internal state to keep track of the selection index
    @State private var selectionState: Int = 0 {
        didSet {
            selection = selectionState
        }
    }
    
    @State private var tabWidths: [CGFloat] = []
    
    // MARK: Required Properties
    
    /// Binding the selection index which will  re-render the consuming view
    @Binding var selection: Int
    
    /// The title of the tabs
    let tabs: [String]
    
    // Mark: View Customization Properties
    
    /// The font of the tab title
    let font: Font
    
    /// The selection bar sliding animation type
    let animation: Animation
    
    /// The accent color when the tab is selected
    let activeAccentColor: Color
    
    /// The accent color when the tab is not selected
    let inactiveAccentColor: Color
    
    /// The color of the selection bar
    let selectionBarColor: Color
    
    /// The tab color when the tab is not selected
    let inactiveTabColor: Color
    
    /// The tab color when the tab is  selected
    let activeTabColor: Color
    
    /// The height of the selection bar
    let selectionBarHeight: CGFloat
    
    /// The selection bar background color
    let selectionBarBackgroundColor: Color
    
    /// The height of the selection bar background
    let selectionBarBackgroundHeight: CGFloat
    
    let tabsPadding: CGFloat = UIConstants.padding
    
    // MARK: init
    
    public init(selection: Binding<Int>,
                tabs: [String],
                font: Font = .body,
                animation: Animation = .spring(),
                activeAccentColor: Color = Color("ColorPrimary"),
                inactiveAccentColor: Color = Color.black.opacity(0.4),
                selectionBarColor: Color = Color("ColorPrimary"),
                inactiveTabColor: Color = .clear,
                activeTabColor: Color = .clear,
                selectionBarHeight: CGFloat = 2,
                selectionBarBackgroundColor: Color = .clear.opacity(0.2),
                selectionBarBackgroundHeight: CGFloat = 1) {
        self._selection = selection
        self.tabs = tabs
        self.font = font
        self.animation = animation
        self.activeAccentColor = activeAccentColor
        self.inactiveAccentColor = inactiveAccentColor
        self.selectionBarColor = selectionBarColor
        self.inactiveTabColor = inactiveTabColor
        self.activeTabColor = activeTabColor
        self.selectionBarHeight = selectionBarHeight
        self.selectionBarBackgroundColor = selectionBarBackgroundColor
        self.selectionBarBackgroundHeight = selectionBarBackgroundHeight
    }
    
    // MARK: View Construction

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: nil) {
                    ForEach(self.tabs, id:\.self) { tab in
                        Button(action: {
                            let selection = self.tabs.firstIndex(of: tab) ?? 0
                            self.selectionState = selection
                        }) {
                            HStack {
                                if (self.tabs.count == 2) {
                                    Spacer()
                                }
                                Text(tab).font(self.font)
                                if (self.tabs.count == 2) {
                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal, tabsPadding)
                        .padding(.top, UIConstants.smallPadding)
                        .padding(.bottom, UIConstants.extraLargePadding)
                        .accentColor(
                            self.isSelected(tabIdentifier: tab)
                            ? self.activeAccentColor
                            : self.inactiveAccentColor)
                        .background(
                            self.isSelected(tabIdentifier: tab)
                            ? self.activeTabColor
                            : self.inactiveTabColor)
                        .background(
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    tabWidths.insert(proxy.size.width, at: 0)
                                }
                            }
                        )
                    }
                }
                .frame(minWidth: geometry.size.width)
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(self.selectionBarColor)
                            .frame(
                                width: self.tabWidth(),
                                height: self.selectionBarHeight,
                                alignment: .leading
                            )
                            .offset(x: self.selectionBarXOffset(), y: 0)
                            .animation(self.animation)
                        Rectangle()
                            .fill(self.selectionBarBackgroundColor)
                            .frame(
                                width: geometry.size.width,
                                height: self.selectionBarBackgroundHeight,
                                alignment: .leading
                            )
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(width: geometry.size.width)
        }
        .frame(height: 60)
    }
    
    // MARK: Private Helper
    
    private func isSelected(tabIdentifier: String) -> Bool {
        return tabs[selectionState] == tabIdentifier
    }
    
    private func tabWidth() -> CGFloat {
        if (tabWidths.count == 0) {
            return 0
        }
        return tabWidths[selectionState] + tabsPadding
    }
    
    private func selectionBarXOffset() -> CGFloat {
        var offset: CGFloat = 0
        if (tabWidths.count == 0) {
            return 0
        }
        for i in 0..<selectionState {
            offset = offset + CGFloat(tabWidths[i])
        }
        let padding1 = tabsPadding / 2 * CGFloat(selectionState)
        let padding2 = tabsPadding * CGFloat(selectionState)
        let padding = (padding1 + padding2) / 2
        
        return offset + padding
    }
}

struct SlidingTabConsumerView : View {
    @State private var selectedTabIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            SlidingTabView(
                selection: self.$selectedTabIndex,
                tabs: [
                    "First View", "Second View", "Third View", "Fourth View"
                ],
                font: .body,
                activeAccentColor: Color("ColorPrimary"),
                selectionBarColor: Color("ColorPrimary")
            )
            switch selectedTabIndex {
            case 0:
                Text("First View")
            case 1:
                Text("Second View")
            case 2:
                Text("Third View")
            case 3:
                Text("Fourth View")
            default:
                Text("No View")
            }
            Spacer()
        }
    }
}

struct SlidingTabView_Previews: PreviewProvider {
    static var previews: some View {
        SlidingTabConsumerView()
    }
}
