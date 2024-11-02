module.exports = {
  content: [
    './public/*.html',
    './app/views/**/*',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/**/*.js'
  ],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/line-clamp'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require("daisyui"),
    require("flowbite/plugin")
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
