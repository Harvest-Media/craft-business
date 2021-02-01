# Harvest Media's CraftCMS Starter Theme

This is an opinionated, base starter theme to build new CraftCMS websites at Harvest Media. It's intended to save our developers time and improve consistency across our projects while following good practices for performance.

## About CraftCMS

CraftCMS is our tool of choice. It's a flexible, scalable CMS written in PHP (7+), and built on the [Yii 2 framework](https://www.yiiframework.com/). It can connect to MySQL (5.5+) and PostgreSQL (9.5+) for content storage.

- **[Documentation](http://docs.craftcms.com/v3/)** – Read the official docs.
- **[Guides](https://craftcms.com/guides)** – Follow along with the official guides.
- [Server Requirements](https://docs.craftcms.com/v3/requirements.html)
- [Installation Instructions](https://docs.craftcms.com/v3/installation.html)

## Assumptions

We've designed this starter theme around the most common use cases for Harvest Media including:

- Hosting on a [Linode VPS](https://www.linode.com) provisioned by [Laravel Forge](https://forge.laravel.com)
  - using the nginx web server
- Deployed automatically when a user pushes to the `master` branch

But of course this will work in any other LAMP environment that can run CraftCMS.

## Features of this Starter Theme

- Pages / Navigation (Native Craft Sections)
- Blog (Native Craft Sections)
- Content Blocks Builder (Native Craft Matrix)
- Contact Form (via the Craft Contact Form Plugin)
- Server Side Static Page Caching (via CacheFlag)
- CSRF Protection (Native in Craft)
- SEOMatic (3rd party plugin to keep SEO consistent, easy, and flexible)

### Plugin Dependencies

- [SEOMatic](https://plugins.craftcms.com/seomatic)
- [CacheFlag](https://plugins.craftcms.com/cache-flag)
- [LinkIt](https://plugins.craftcms.com/linkit) (used in the content blocks / builder)

### Optional Plugins

- [Minify](https://plugins.craftcms.com/minify)
- [Wordsmith](https://plugins.craftcms.com/wordsmith)


## Directory Structure

### Folders

- **config** (for CraftCMS config settings - there should be **no** client specific information in craft's config folder)
- modules (used by Craft)
- vendor (used by npm and ignored in our repo)
- **public** (web root)
- src (source files for front end code: css and js)
- storage  (used by Craft)
- **templates**  (these are the [TWIG](https://twig.symfony.com/) template files where we'll be spending most of our development time)
- translations (used by Craft to change the translation of certain words in the control panel or front end app)
- vendor (used by [Composer](https://getcomposer.org/) and ignored in our repo)

### Files
- **.env** (Craft's master config file which also contains client-specific information. This will be edited on every single project and different in every environment: dev, staging, and production.)
- composer.json &amp; composer.lock (Used by Craft - not typically edited manually)
- craft &amp; craft.bat (Craft's command line files)
- **favicon.master.png** (a transparent square logo image that we use to build our favicons here: https://realfavicongenerator.net )
- package.json &amp package-lock.json (Used by npm - not typically edited manually)
- README.md (the file we're looking at :-)
- tailwind.config.js (extends TailwindCSS default configuration to include client brand colors, or other classes.)
- **webpack.mix.js** (our Laravel Mix config file that configures SCSS, PostCSS, and JS builds)

**Note:** This starter theme assumes a directory structure with `public` as the web root (not "web" or "public_html"). If you change your web root folder name, you will need to update the Laravel Mix config file and Craft's `config/general.php` file.

## Developing for the Front End Using Laravel Mix

Keeping pace with the modern web is challenging, but we make an effort to stay with the pack and follow the recommended practices of the day. Presently, we use **[Laravel Mix](https://laravel-mix.com/)**, self-described as an elegant wrapper around [Webpack](https://webpack.js.org/) for the 80% use case. Where WebPack configuration is long and complex, Laravel Mix is relatively short and sweet.

See the `webpack.mix.js` file in the root of the repo.

### Developing Locally

From the terminal, `cd` into the project directory and run `npm install`.

The follow commands are available. (You can find them in `package.json`).

- `npm run watch` starts a local development with BrowserSync at `localhost:3000`
- `npm run prod` build CSS and JS for production (including [PurgeCSS](https://purgecss.com/configuration.html#configuration-file))

Note: that Laravel Mix also supports Hot Module Replacement (HMR) via `npm run hot` but it seems to be meant for single page javascript apps or .vue files. We've haven't cracked the code on how to use it yet.

See the Laravel Mix config file for details.

### CSS (SCSS and PostCSS)

The starter theme has a master CSS file at `src/css/theme.scss`. It uses:

- **[Foundation Sites](https://get.foundation/sites/docs/)** for base styling, layout, and some of its built in components
- **[TailwindCSS](https://tailwindcss.com/)** for custom styling and components

We include only the pieces of Foundation that we want, rather than the whole framework.

For the most part, styling will happen in the html using `tw-` utilty classes provided by TailwindCSS.

When building for production SASS/SCSS is processed first, and PostCSS plugins are run afterward.

### JS

The master JS file for the theme is located at `src/js/theme.js`.

For any Foundation plugins that require javascript we included them along with jQuery.

We recommended keeping JS to a minimum.

#### CSRF Protection with JS

Note: we achieve CSRF protection by the jQuery code.

```
if (
  $("input[name='CRAFT_CSRF_TOKEN']").length > 0
) {
  $(() => {
    $.ajax({
      url: "/get-token",
      success: response => {
        $("input[name='CRAFT_CSRF_TOKEN']").val(
          response
        );
      }
    });
  });
}
```


which summarized in English will:

1. Check for any CSRF form inputs on the page.
1. Make an AJAX request to a CraftCMS template which contains only the CSRF token.
1. Add the AJAX response (the current valid CSRF token) to the form inputs.

## Templating

### Using Macros

Partials, and macros in particular, will help you avoid repetition in your TWIG templates. Use them freely.

### SVG Icons

Craft allows us to inline a single SVG in our HTML directly from a file in the `public` folder. This is much easier than building icon sprites and it allows us to easily include only the icons we actually use on the page.

Here's the code we use to achieve this:

```
{{ svg('@webroot/assets/svg/YOUR_FILE_NAME_HERE.svg')|attr({class:'YOUR_CLASSES_HERE',role:'img'})|append('<title>YOUR_TITLE_HERE</title>', 'replace') }}
```

### Watching Out for Server Side Performance

Eager loading elements in craft will make a significant difference and is pretty easy to do. [See the instructions](https://docs.craftcms.com/v3/dev/eager-loading-elements.html) in Craft's docs.

## Local Development and Testing

In addition to testing via the IP address on your network, you can test cross device and remotely (outside your network) by using **[ngrok](https://ngrok.com)**.

We also recommend changing the environment from `dev` to `staging` when performing final tests locally.

## There's More Work to Do on This Starter Theme

### Low Hanging Fruit
- Install the contact form....
- lazyload images with JS and a macro...

### Improve Content Blocks / Builder

- Use [TailwindUI Icons](https://github.com/refactoringui/heroicons)
- add an *image + caption* block
- improve use of macros
