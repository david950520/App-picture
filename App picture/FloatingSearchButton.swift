import SwiftUI

/// 自訂精準放大鏡向量圖形（完全依據設計稿幾何與圓角繪製）
struct CustomMagnifyingGlass: View {
    var color: Color = .white
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            // 放大鏡中心點略微偏左上以達成視覺平衡
            let center = CGPoint(x: w * 0.43, y: h * 0.43)
            let radius = w * 0.26
            let lineWidth = w * 0.125
            let angle: CGFloat = .pi / 4
            
            // 握把起點由圓周邊緣延伸
            let start = CGPoint(
                x: center.x + radius * cos(angle),
                y: center.y + radius * sin(angle)
            )
            // 握把終點具備圓頭造型
            let end = CGPoint(
                x: start.x + w * 0.22 * cos(angle),
                y: start.y + w * 0.22 * sin(angle)
            )
            
            ZStack {
                // 鏡面空心正圓
                Circle()
                    .stroke(color, lineWidth: lineWidth)
                    .frame(width: radius * 2, height: radius * 2)
                    .position(center)
                
                // 斜向圓角握把 (45 度)
                Path { path in
                    path.move(to: start)
                    path.addLine(to: end)
                }
                .stroke(
                    color,
                    style: StrokeStyle(lineWidth: lineWidth * 1.05, lineCap: .round, lineJoin: .round)
                )
            }
        }
    }
}

/// 懸浮搜尋圓形按鈕元件（依據使用者上傳圖片像素級打造）
struct FloatingSearchButton: View {
    var size: CGFloat = 62
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // 藍色圓形底座與柔和立體陰影
                Circle()
                    .fill(Color("FABBackground"))
                    .frame(width: size, height: size)
                    .shadow(color: Color.black.opacity(0.28), radius: 8, x: 0, y: 5)
                
                // 專屬繪製的放大鏡符號
                CustomMagnifyingGlass(color: .white)
                    .frame(width: size * 0.52, height: size * 0.52)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("放大鏡按鈕預覽") {
    ZStack {
        VStack(spacing: 0) {
            Color(red: 0.17, green: 0.24, blue: 0.52)
                .frame(height: 120)
            Color.white
                .frame(height: 120)
        }
        
        FloatingSearchButton()
    }
}
