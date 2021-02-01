const mix = require("laravel-mix");
require("dotenv").config();

let devProxy = process.env.BROWSERSYNC_PROXY_URL || "http://dandjroofingandconstruction.test";

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for your application, as well as bundling up your JS files.
 |
 | https://laravel-mix.com/docs
 | https://github.com/JeffreyWay/laravel-mix
 |
 */

mix
  .setPublicPath("public")

  .browserSync({
    browser: "google chrome",
    proxy: devProxy,
    notify: false,
    files: [
      "templates/**/*.twig",
      "templates/**/*.html",
      "public/assets/css/theme.css",
      "public/assets/js/theme.js"
    ]
  })

  /* Configure Larval Mix with the options we want.  */
  .options({

    processCssUrls: false, // default true

    /* Configure Mix's built in PostCSS to use the plugins we want including tailwindcss and purgecss */
    postCss: [
      require("tailwindcss")("tailwind.config.js")
      //require("autoprefixer")()
    ],
    clearConsole: mix.inProduction() ? true : false,
    cssNano: {
      discardComments: { removeAll: true }
    }
  })

  /* Process SCSS and PostCSS */
  .sass("src/css/theme.scss", "public/assets/css/", {
    sassOptions: {
      outputStyle: "expanded"
    }
  })

  /* JS */
  .js("src/js/theme.js", "public/assets/js/");

// versioning in Production only
if (mix.inProduction()) {
  mix.version();
}
