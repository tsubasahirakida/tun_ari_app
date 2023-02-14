module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require("daisyui")
  ],
  theme: {
    extend: {
      darkMode: 'class',
      fontFamily: {
        fancy: ["Zen Kurenaido"],
      },
      screens: {
        'xs': '440px',
      },
    },
  }
}