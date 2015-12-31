# curl_generator

## What is this ?

This is tool for generating and testing curl request for API.
If for some reason tech writers always blame you about request to build correct curl for them,
you easy could use this tool.

## Setup

1. Download the file

2. Install ruby 2.1.5 or higher

3. Run ruby curl.rb


## Workflow

Process founded on some few simple questions:

1. Type of request: just type in `get, post, put or delete`

2. Path: set the path for api request bases at default domain path (http://yourdoamin.com/path), you need add /path

3. Data: Please input request data in JSON format or just skip (press Enter) for empty data.

4. Test request (y/n): Input y and press Enter for execute this curl after generating of input something else and press enter for non-test mode.

Generator build for you two curl request: json & xml format. Yeahhh...!

## Contributing

Welcomed!
