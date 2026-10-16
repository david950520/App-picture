import SwiftUI

/// 單一公車選單功能列元件
struct MenuItemRowView: View {
    // 透過 Property 傳入自訂資料與配置
    let item: MenuItemModel
    var showDivider: Bool = true
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                // 左側圖示：支援 SF Symbol 與 Assets 圖片
                Group {
                    if item.isAssetImage {
                        Image(item.iconName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: item.iconSize, height: item.iconSize)
                    } else {
                        Image(systemName: item.iconName)
                            .font(.system(size: item.iconSize))
                            .foregroundColor(item.iconColor)
                    }
                }
                .frame(width: 48, height: 48, alignment: .center)
                
                // 中間標題與說明文字（已將字體顏色統一改為黑色）
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("TextPrimary"))
                    
                    Text(item.subtitle)
                        .font(.system(size: 13.5))
                        .foregroundColor(Color("TextPrimary"))
                        .lineLimit(2)
                }
                
                // 右側彈性空白區域（讓右側空白處同樣可供點選跳轉）
                Spacer()
                
                // 右側箭頭指示
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color("ChevronColor"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .contentShape(Rectangle()) // 使整個橫列（包含標題與右側空白處）皆可點選
            .onTapGesture {
                onTap?()
            }
            .background(Color("ListBackground"))
            
            // 底部分隔線
            if showDivider {
                Divider()
                    .background(Color("DividerColor"))
                    .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    VStack {
        MenuItemRowView(item: MenuItemModel.samples[0])
        MenuItemRowView(item: MenuItemModel.samples[6]) // Hotel Asset
        MenuItemRowView(item: MenuItemModel.samples[8]) // Transfer Asset
    }
}
