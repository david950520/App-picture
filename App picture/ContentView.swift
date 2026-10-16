import SwiftUI

struct ContentView: View {
    @Environment(\.openURL) private var openURL
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var navigationPath = NavigationPath()
    
    // 選單資料列表
    private let menuItems = MenuItemModel.samples
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack(alignment: .top) {
                // 背景色會隨系統深色 / 淺色模式自動切換
                Color("ScreenBackground")
                    .ignoresSafeArea()
                
                // 可上下捲動的滾動視圖
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 0) {
                        // 頂部看板區域 (含漢堡選單、天氣雙圓環與定位)
                        ZStack(alignment: .bottomTrailing) {
                            HeaderWeatherView(
                                title: "基隆公車",
                                dateText: "2026/10/16 星期五",
                                temperature: "28°C",
                                locationName: "基隆市",
                                rainProbability: "10%",
                                weatherDescription: "陰天 27°C-30°C 舒適至悶熱",
                                onMenuTapped: {
                                    alertMessage = "側邊選單已開啟"
                                    showingAlert = true
                                }
                            )
                            
                            // 懸浮搜尋放大鏡按鈕（設定最高 zIndex 確保始終位於最上層，完整覆蓋在白色列表之上）
                            FloatingSearchButton(size: 62) {
                                navigationPath.append(AppScreen.routeSearch)
                            }
                            .offset(x: -24, y: 31)
                            .zIndex(999)
                        }
                        .zIndex(999)
                        
                        // 功能清單列表（點選標題或右側空白處即可跳轉對應頁面或網址）
                        VStack(spacing: 0) {
                            ForEach(menuItems) { item in
                                MenuItemRowView(item: item) {
                                    if let target = item.targetScreen {
                                        navigationPath.append(target)
                                    } else if let url = item.destinationURL {
                                        openURL(url)
                                    }
                                }
                            }
                        }
                        .background(Color("ListBackground"))
                        .zIndex(1)
                        
                        // 底部說明文字與版權（留白以利舒適滑動）
                        Text("基隆市公車動態資訊系統 • Jie App")
                            .font(.footnote)
                            .foregroundColor(Color("TextSecondary"))
                            .padding(.vertical, 32)
                    }
                }
                .scrollBounceBehavior(.always)
            }
            .navigationDestination(for: AppScreen.self) { screen in
                switch screen {
                case .routeSearch:
                    RouteSearchView()
                case .favoriteStops:
                    FavoriteStopsView()
                case .nearbyStops:
                    NearbyStopsView()
                case .stopMap:
                    StopMapView()
                case .routePlanning:
                    RoutePlanningView()
                case .removeAds:
                    RemoveAdsView()
                case .hotelBooking:
                    HotelBookingView {
                        navigationPath.append(AppScreen.routeSearch)
                    }
                case .transferServices:
                    TransferServicesView()
                }
            }
            .alert("提示", isPresented: $showingAlert) {
                Button("確定", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

// 支援深淺色兩種模式的 Preview 預覽
#Preview("一般模式 (Light Mode)") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("深色模式 (Dark Mode)") {
    ContentView()
        .preferredColorScheme(.dark)
}
