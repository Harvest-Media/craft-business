<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

return [
    // Global settings
    '*' => [

        // Craft Config Items
        'useEmailAsUsername' => true,
        'usePathInfo' => true,
        'sendPoweredByHeader' => false,

        // Default Week Start Day (0 = Sunday, 1 = Monday...)
        'defaultWeekStartDay' => 0,

        // Whether generated URLs should omit "index.php"
        'omitScriptNameInUrls' => true,

        // Control Panel trigger word
        'cpTrigger' => 'admin',

        // Control Panel Resources
        'resourceBasePath' => dirname(__DIR__) . '/public/cpresources',

        // Control Panel Search
        'defaultSearchTermOptions' => array(
            'subLeft' => true,
            'subRight' => true
        ),

        // GraphQL off by default
        'enableGql' => false,

        // The secure key Craft will use for hashing and encrypting data
        'securityKey' => getenv('SECURITY_KEY'),

        // Caching
        'enableTemplateCaching' => true,
        'cacheDuration' => false,
        'cacheElementQueries' => false,

        // File Uploads
        'maxUploadFileSize' => (1048576 * 100), // 100 MB

        // Security
        'enableCsrfProtection' => true,
        'preventUserEnumeration' => true,

        // Custom Config Variables to use in Twig Templates
        'theme' => [
            'assets' => getenv('THEME_ASSET_URL'),
            'assetsImages' => getenv('THEME_ASSET_IMAGES'),
            'assetsCss' => getenv('THEME_ASSET_CSS'),
            'assetsJs' => getenv('THEME_ASSET_JS'),
            'assetsSvg' => getenv('THEME_ASSET_SVG'),
        ],
    ],

    // Dev environment settings
    'dev' => [
        // Dev Mode (see https://craftcms.com/guides/what-dev-mode-does)
        'devMode' => true,
        'userSessionDuration' => false,
        'enableTemplateCaching' => false,
        'backupOnUpdate' => false,
        'allowAdminChanges' => true,
    ],

    // Staging environment settings
    'staging' => [
        'allowAdminChanges' => true,
    ],

    // Production environment settings
    'production' => [
        'allowAdminChanges' => false,
    ],
];
