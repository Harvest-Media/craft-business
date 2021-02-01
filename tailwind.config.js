// tailwind.config.js
const colors = require('tailwindcss/colors')

module.exports = {
  important: true,
  darkMode: false,
  purge: {
    mode: 'all',
    content: [
      "./templates/**/*.html",
      "./templates/**/*.twig",
      "./src/js/theme.js",
    ],
    options: {
      safelist: {
        deep: [
          /^(js-|is-|has-|sticky-|responsive-|submenu-|first-|opens-|position-|slick)/,
        ],
        greedy: [
          /^(js-|is-|has-|sticky-|responsive-|submenu-|first-|opens-|position-|slick)/,
        ],
      },
    },
  },
  theme: {
    screens: {
      sm: "640px",
      md: "1024px",
      lg: "1200px",
      xl: "1440px",
    },
    extend: {
      spacing: {
        '3px': '3px',
        '18': '4.5rem'
      },
      colors: {
        gray: colors.trueGray,
        "brand-maroon": {
          default: "#6B0004",
          100: "#FF383F",
          200: "#FF050D",
          300: "#D10007",
          400: "#9E0005",
          500: "#6B0004",
          600: "#5C0003",
          700: "#4D0003",
          800: "#3D0002",
          900: "#2E0002",
        },
        "brand-gold": {
          default: "#AF9B41",
          100: "#E2D9B1",
          200: "#D7CB93",
          300: "#CCBC75",
          400: "#C1AE57",
          500: "#AF9B41",
          600: "#958437",
          700: "#7B6D2D",
          800: "#615624",
          900: "#473F1A",
        },
        "brand-navy": {
          default: "#232339",
          100: "#C6C6DC",
          200: "#9393BD",
          300: "#61619E",
          400: "#42426C",
          500: "#232339",
          600: "#1D1D2F",
          700: "#171726",
          800: "#11111C",
          900: "#0C0C13",
        },
        social: {
          twitter: "#00aced",
          facebook: "#3b5998",
          pinterest: "#cb2027",
          linkedin: "#007bb6",
          youtube: "#bb0000",
          instagram: "#517fa4",
          vimeo: "#aad450",
        },
      },
      fontFamily: {
        //'sans': ['Montserrat', 'sans-serif'],
        //'serif': ['EB Garamond', 'serif'],
      },
      minHeight: (theme) => ({
        ...theme('spacing'),
      }),
      minWidth: (theme) => ({
        //...theme('spacing'),
      }),
      zIndex: {
        //'99': 99,
      },
    },
  },
  variants: {
    extend: {
      //fontWeight: ['hover', 'focus']
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
};
