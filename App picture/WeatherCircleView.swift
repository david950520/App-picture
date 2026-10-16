import SwiftUI

/// 帶有雙層同心圓環的天氣儀表圓形元件
struct WeatherCircleView<Content: View>: View {
    // 透過 Property 客製化自訂元件尺寸與內容
    var diameter: CGFloat = 140
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        ZStack {
            // 最外層圓環
            Circle()
                .stroke(Color.white.opacity(0.85), lineWidth: 2)
                .frame(width: diameter, height: diameter)
            
            // 內層稍粗的圓環
            Circle()
                .stroke(Color.white, lineWidth: 3.5)
                .frame(width: diameter - 10, height: diameter - 10)
            
            // 圓內展示的自訂內容
            content()
                .frame(width: diameter - 20, height: diameter - 20)
        }
    }
}

#Preview {
    ZStack {
        Color("HeaderBackground")
            .ignoresSafeArea()
        
        WeatherCircleView(diameter: 140) {
            VStack(spacing: 2) {
                Image(systemName: "cloud.fill")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                
                Rectangle()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                    .frame(width: 80, height: 1)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.vertical, 2)
                
                Text("2026/10/16 星期五")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.white)
                
                Text("28°C")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
        }
    }
}
