import SwiftUI

/// 頂部公車標題與天氣資訊看板
struct HeaderWeatherView: View {
    // 透過 Property 客製化自訂 View
    var title: String = "基隆公車"
    var dateText: String = "2026/10/16 星期五"
    var temperature: String = "28°C"
    var locationName: String = "基隆市"
    var rainProbability: String = "10%"
    var weatherDescription: String = "陰天 27°C-30°C 舒適至悶熱"
    
    var onMenuTapped: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 16) {
            // 頂部導覽列：漢堡按鈕與標題
            HStack {
                Button(action: onMenuTapped) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: "line.3.horizontal")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                // 為了對稱佔位的透明圓形
                Color.clear
                    .frame(width: 44, height: 44)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            
            // 雙圓形天氣看板區
            HStack(spacing: 28) {
                // 左側圓圈：氣溫與日期
                WeatherCircleView(diameter: 140) {
                    VStack(spacing: 2) {
                        Image(systemName: "cloud.fill")
                            .font(.system(size: 26))
                            .foregroundColor(.white)
                        
                        // 虛線分隔線
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                            .frame(width: 84, height: 1)
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.vertical, 2)
                        
                        Text(dateText)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.white)
                        
                        Text(temperature)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                
                // 右側圓圈：基隆市與降雨機率
                VStack(spacing: 4) {
                    // 圓形上方標籤：定位圖示與城市名稱
                    HStack(spacing: 4) {
                        Image(systemName: "mappin.and.ellipse")
                            .font(.system(size: 16, weight: .semibold))
                        Text(locationName)
                            .font(.system(size: 18, weight: .bold))
                    }
                    .foregroundColor(.white)
                    
                    WeatherCircleView(diameter: 140) {
                        VStack(spacing: 2) {
                            Text(rainProbability)
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                            
                            Text("降雨機率")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                }
            }
            
            // 底部天氣簡述
            Text(weatherDescription)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .padding(.bottom, 22)
        }
        .frame(maxWidth: .infinity)
        .background(Color("HeaderBackground"))
    }
}

#Preview {
    HeaderWeatherView()
}
