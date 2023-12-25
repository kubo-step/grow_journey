module.exports = {
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#37cdbe",
          "secondary": "#FFD700",
          "accent": "#FFC107",
          "neutral": "#3d4451",
          "base-100": "#ffffff",
        },
      },
    ],
  },
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  plugins: [
    require('daisyui'),
  ],
  theme: {
    extend: {
      // ここでカスタムアニメーションを定義します
      animation: {
        'fade-in-up': 'fadeInUp 1.5s ease-out',
      },
      keyframes: {
        fadeInUp: {
          '0%': { transform: 'translateY(10%)', opacity: '0' },
          '100%': { transform: 'translateY(0)', opacity: '1' },
        },
      },
      colors: {
        'line-green': '#06C755',
        'line-dark-green': '#008c00',
      },
    },
  },
}
