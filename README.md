# Sliding Tab View
## _Add as many tabs as you want and scroll through them_

## Installation
Use [Swift Package Manager](https://swiftpackageregistry.com/garage-panda/sliding-tab-view) to install.

## Usage

```swift
import SlidingTabView

struct SlidingTabConsumerView : View {
    @State private var selectedTabIndex = 0

    var body: some View {
        VStack() {
            SlidingTabView(
                selection: self.$selectedTabIndex,
                tabs: ["First View", "Second View", "Third View", "Fourth View"]
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
        }
    }
}
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Support
If you like what you see, feel free to support us!
<a href="https://www.buymeacoffee.com/garage.panda">
<img src="https://img.buymeacoffee.com/button-api/?text=Buy us a beer&emoji=:beer:&slug=garage.panda&button_colour=FFDD00&font_colour=000000&font_family=Poppins&outline_colour=000000&coffee_colour=ffffff"></a>

## License
[MIT](https://choosealicense.com/licenses/mit/)
