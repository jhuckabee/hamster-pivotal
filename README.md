[Hamster](http://projecthamster.wordpress.com/) makes it so easy to keep track of your time throughout the course of the day.
However, getting that data into other systems can be a pain in the ass, which is why I created this little library to help automate
the process of submiting Hamster time entries in to [PivotalTracker](https://www.pivotaltracker.com/).

Unfortunately, the current official PivotalTracker API doesn't give you access to time tracking methods, so I've created a bit of a workaround
using curl.  So make sure you have curl installed before trying to use this.

    sudo apt-get install curl

You'll also need Ruby to get this working.  I've only tested with ruby 1.9.2.

Setup
=====

First you will need to clone this repository to your local machine.

After you've cloned the repository you will need to configure the following envirionment variables:

* PIVOTAL_EMAIL
* PIVOTAL_PASSWORD
* PIVOTAL_PERSON_ID
* PIVOTAL_PROJECT_ID

You can grab your PERSON_ID and PROJECT_ID from PivotalTracker after logging in.

The simplest way to keep this sane right now is create a vars.txt file in the root of your project 
that looks something like:

    export PIVOTAL_EMAIL=your.email@example.org
    export PIVOTAL_PASSWORD=somePassW0rD
    export PIVOTAL_PERSON_ID=0000000
    export PIVOTAL_PROJECT_ID=0000000

Once this is setup, just run the following command:

    source vars.txt

Usage
=====

Once you've got your pivotal account configured, you will need to export your time entries from Hamster.
You can do this from the "Show Overview" button.  Filter the entries that you want to import into Pivotal and
then click "Overview > Save Report" from the menu bar.  Make sure to select "Tab-Separated Values (TSV)" from
the report format list and save the file in the root of this project's directory.

Now you're actually ready to import.  You can run either of the two commands:

    ./bin/show export.tsv

This will just verify that everything parses correctly and do a pretty print of your time entries.

    ./bin/submit export.tsv

This will actually upload the time entries in export.tsv to PivotalTracker.
