# LinuxBuddy (ES)

LinuxBuddy is a tool used to search for Linux distributed OS commands using the Lumen PHP Micro-Framework By Laravel with Elasticsearch

## Deployment

The easiest way to deploy LinuxBuddy (ES) is via Heroku.

## Web Stack

- Ubuntu (Operating System)
- PHP 5.6
- Apache 2.4
- Elasticsearch 1.7

## Dependencies

- Elasticsearch Client

## Development

The virtual development environment for LinuxBuddy (ES) is configured with Vagrant.

"Vagrant up" in the project directory.

    $ cd /path/to/linuxbuddy
    $ vagrant up

Open up your browser at <code>127.0.0.1:3000</code>

<img src="https://raw.githubusercontent.com/linuxbuddy/linuxbuddy-es/master/public/Linuxbuddy.png" />

If you don't have Vagrant you can install it here at <a href="http://www.vagrantup.com">vagrantup.com</a>

# curl -X GET http://127.0.0.1:9200/
