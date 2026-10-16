import SwiftUI

/// 導覽跳轉頁面目標
enum AppScreen: Hashable {
    case routeSearch      // 路線搜尋
    case favoriteStops    // 最愛站牌
    case nearbyStops      // 附近站牌
    case stopMap          // 站牌地圖
    case routePlanning    // 路線規劃
    case removeAds        // 免費去除廣告
    case hotelBooking     // 預訂飯店住宿
    case transferServices // 更多轉乘查詢
}

/// 公車選單項目模型
struct MenuItemModel: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let targetScreen: AppScreen?
    let destinationURL: URL?
    let iconName: String
    let isAssetImage: Bool
    let iconColor: Color
    let iconSize: CGFloat
    
    init(
        title: String,
        subtitle: String,
        targetScreen: AppScreen? = nil,
        destinationURL: URL? = nil,
        iconName: String,
        isAssetImage: Bool = false,
        iconColor: Color = .blue,
        iconSize: CGFloat = 34
    ) {
        self.title = title
        self.subtitle = subtitle
        self.targetScreen = targetScreen
        self.destinationURL = destinationURL
        self.iconName = iconName
        self.isAssetImage = isAssetImage
        self.iconColor = iconColor
        self.iconSize = iconSize
    }
}

// 範例資料來源
extension MenuItemModel {
    static let samples: [MenuItemModel] = [
        MenuItemModel(
            title: "路線搜尋",
            subtitle: "路線編號快查系統，輕鬆查詢公車路線",
            targetScreen: .routeSearch,
            iconName: "bus.fill",
            iconColor: Color("BusCyan")
        ),
        MenuItemModel(
            title: "最愛站牌",
            subtitle: "常搭站牌加入最愛，再次查詢省時快速",
            targetScreen: .favoriteStops,
            iconName: "heart.fill",
            iconColor: Color("HeartRed")
        ),
        MenuItemModel(
            title: "附近站牌",
            subtitle: "快速搜尋附近站牌，即時掌握公車動態",
            targetScreen: .nearbyStops,
            iconName: "mappin.circle.fill",
            iconColor: Color("NearbyYellow")
        ),
        MenuItemModel(
            title: "站牌地圖",
            subtitle: "地圖定位快速搜尋附近公車站牌位置",
            targetScreen: .stopMap,
            iconName: "map.fill",
            iconColor: Color("MapGreen")
        ),
        MenuItemModel(
            title: "路線規劃",
            subtitle: "大眾運輸工具搭乘建議路徑與規劃系統",
            targetScreen: .routePlanning,
            iconName: "arrow.triangle.turn.up.right.diamond.fill",
            iconColor: Color("RoutePurple")
        ),
        MenuItemModel(
            title: "免費去除廣告",
            subtitle: "不想看到廣告嗎？按此升級無廣告體驗",
            targetScreen: .removeAds,
            iconName: "nosign",
            iconColor: Color("NoAdRed")
        ),
        MenuItemModel(
            title: "預訂飯店住宿",
            subtitle: "全球飯店搜尋引擎讓您輕鬆訂房比價",
            targetScreen: .hotelBooking,
            iconName: "HotelIcon",
            isAssetImage: true,
            iconSize: 42
        ),
        MenuItemModel(
            title: "常見問題解答",
            subtitle: "搭公車相關常見問題解答",
            destinationURL: URL(string: "https://jieapp.blogspot.com/2020/07/blog-post_0.html"),
            iconName: "info.circle.fill",
            iconColor: Color("FAQGreen")
        ),
        MenuItemModel(
            title: "更多轉乘查詢",
            subtitle: "台鐵／高鐵／捷運／客運／公車／Ubike／航班",
            targetScreen: .transferServices,
            iconName: "TransferIcon",
            isAssetImage: true,
            iconSize: 42
        )
    ]
}
