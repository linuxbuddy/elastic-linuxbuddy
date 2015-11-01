# LinuxBuddy (ES)

LinuxBuddy is a tool used to search for Linux distributed OS commands using the Lumen PHP Micro-Framework By Laravel with Elasticsearch

## Deployment

The easiest way to deploy LinuxBuddy (ES) is via Heroku.

## Web Stack

- RHEL / CentOS 6
- PHP 5.6
- Apache 2.4
- Elasticsearch 1.7

## Application Dependencies

- Elasticsearch Client

## Development

The virtual development environment for LinuxBuddy (ES) is configured with Vagrant.

"Vagrant up" in the project directory.

    $ cd /path/to/linuxbuddy
    $ vagrant up

Open up your browser at <code>192.168.100.4</code>

Check commands are indexed in Elasticsearch.

	curl -X POST http://localhost:9200/linux_buddy/commands/_search

If LinuxBuddy commands are not indexed then you will get the following `Elasticsearch\Common\Exceptions\Missing404Exception` exception in /storage/logs/lumen.log:

	{"error":"IndexMissingException[[linux_buddy] missing]","status":404}

<img src="https://raw.githubusercontent.com/linuxbuddy/linuxbuddy-es/master/public/Linuxbuddy.png" />

If you don't have Vagrant you can install it here at <a href="http://www.vagrantup.com">vagrantup.com</a>
