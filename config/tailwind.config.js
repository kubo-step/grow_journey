module.exports = {
  daisyui: {
    themes: [
      {
        mytheme: {
          "primary": "#FFA500",
          "secondary": "#FFD700",
          "accent": "#37cdbe",
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
  ]
}
