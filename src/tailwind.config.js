module.exports = {
    content: ["./Pages/**/*.{razor,cshtml}",
        "./Shared/**/*.{razor,cshtml}",
        "./Components/**/*.razor"],
  theme: {
    extend: {},
  },
  plugins: [
        require("@tailwindcss/forms")
  ]
}
