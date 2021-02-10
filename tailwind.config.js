// tailwind.config.js
const colors = require("tailwindcss/colors");

module.exports = {
  //important: true,
  darkMode: false,
  purge: {
    mode: "all",
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
        "3px": "3px",
        18: "4.5rem",
      },
      colors: {
        gray: colors.coolGray, // or 'trueGray' (see https://tailwindcss.com/docs/customizing-colors#color-palette-reference)
        primary: colors.blue,
        /*
        "secondary": {
          default: "",
          100: "",
          200: "",
          300: "",
          400: "",
          500: "",
          600: "",
          700: "",
          800: "",
          900: "",
        },
        */
        social: {
          twitter: "#00aced",
          facebook: "#3b5998",
          instagram: "#517fa4",
          linkedin: "#007bb6",
          youtube: "#bb0000",
          vimeo: "#aad450",
        },
      },
      fontFamily: {
        //'sans': ['Montserrat', 'sans-serif'],
        //'serif': ['EB Garamond', 'serif'],
      },
      minHeight: (theme) => ({
        //...theme("spacing"),
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
  plugins: [require("@tailwindcss/typography")],
};
