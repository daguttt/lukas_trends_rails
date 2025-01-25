// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
document.addEventListener("DOMContentLoaded", function () {
  const chartContainer = document.getElementById("echart-container");
  if (!chartContainer) {
    console.error("El contenedor del gráfico no se encuentra.");
    return;
  }

  const chart = echarts.init(chartContainer);

  // Configuración más simple para depuración
  const option = {
    title: {
      text: "Simple Line Chart",
    },
    tooltip: {
      trigger: "axis",
    },
    xAxis: {
      type: "category",
      data: ["2021", "2022", "2023", "2024", "2025"],
    },
    yAxis: {
      type: "value",
    },
    series: [
      {
        name: "Line",
        type: "line",
        data: [120, 132, 101, 134, 90],
      },
    ],
  };

  chart.setOption(option);
});
