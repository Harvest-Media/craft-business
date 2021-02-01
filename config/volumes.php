<?php
$objectStorageAccess = [
    'url'      => "https://" . getenv('OBJECT_STORAGE_HOST'),
    'endpoint' => "https://" . getenv('OBJECT_STORAGE_SERVER'),
    'keyId'    => '$OBJECT_STORAGE_KEY',
    'secret'   => '$OBJECT_STORAGE_SECRET',
    'bucket'   => getenv('OBJECT_STORAGE_BUCKET'),
    'region'   => getenv('OBJECT_STORAGE_REGION'),
];

