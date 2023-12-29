Chartkick.options = {
  donut: true, # ドーナツグラフ
  responsive: true, # レスポンシブ対応を有効化
  colors: [
    "#FFD700",
    "#fceb56",
    "#fffbd4",
          ],
  message: {empty: "データがありません"},
  thousands: ",",
  suffix: "件",
  library: {
    title: {
      align: "center",
      verticalAlign: "middle",
      style: {
        color: "#4B5563",
      }
    },
    plotOptions: {
      pie: {
        startAngle: 0,
        dataLabels: {
          distance: -20, # ラベルの位置調節
          style: { #ラベルフォントの設定
            color: "#4B5563",
            textAlign: "center",
            textOutline: 0, #ラベルの白枠を消す
          }
        },
        size: "110%",
        innerSize: "70%", # ドーナツグラフの中の円の大きさ
        borderWidth: 0,
      }
    },
    tooltip: {
      pointFormat: "<b>{point.y}件</b>"
    },
  }
}