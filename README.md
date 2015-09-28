# RIDDL

## Description

Riddl is your productive distraction. When you and your friends hit your afternoon slump, stretch your cortex or have a laugh with Riddl.

## Screenshots

<img width="791" alt="screen shot 2015-09-28 at 9 45 29 am" src="https://cloud.githubusercontent.com/assets/10355200/10137071/bc9eb6a4-65c5-11e5-8a0c-1b6c489f3ef8.png">
<img width="810" alt="riddl leaderboards" src="https://cloud.githubusercontent.com/assets/10355200/10136064/7190c97c-65c0-11e5-86b7-951378c942fc.png">

## Background

We set out to have fun building something new. We also were curious about how to create an app that could integrate well on a mobile device.

We decided to work with the Twilio API to create a user experience that everyone could use - text messages. We wanted a simple, fast UX with a minimal front-end.

## Features

* Webhooks with Twilio API
* Validate correct/incorrect user riddle answers
* Heroku Scheduler to deliver riddles during your "afternoon slump."

## Usage

If you can send a text, you can use Riddl. Sign up for Riddl and receive a riddle every afternoon. Simply text "STOP" at any time if you just want to chug coffee in the afternoon instead.

## Development/Contribution

Fork the Repo, submit a PR, hit one of us up on Twitter - the main objective of this project was to build something fun and to get people up during their afternoon lull. 

## What You Need To Know Before You Work With Twilio In Rails 

1) To *send* SMS messages to yours users, you will need to use the [Twilio API](https://www.twilio.com/api). To *receive* SMS messages to your users, you will need to webhook into your app using a [TwiML Response Object](https://www.twilio.com/blog/2014/11/an-easier-way-to-write-twiml-templates-in-rails-and-sinatra.html) in whatever controller you create to handle receiving SMS messages from your user. It should look something like this:<br> 
<img width="374" alt="webhook" src="https://cloud.githubusercontent.com/assets/10355200/10136946/2ec641c6-65c5-11e5-9e1b-4b4a5cfb0398.png"><br>
**Note that you are dealing with two file formats, .xml and TwiML.**
<br>
<br>
2) You will need to [disable CSRF to allow Twilio to make 3rd party POST requests](http://stackoverflow.com/questions/11930491/rails-disable-csrf-for-a-3rd-party-post-request) to your app. 
<br>
3) In your controller you build to handle receiving SMS messages, Twilio will only recognize your webhook if it is defined in a send_sms method. Your method should look something like: <br>

## Author

Programmer's of The Bizz <br>
[Zoe Chodosh](http://web0715.students.flatironschool.com/students/zoe_chodosh.html)<br>
[Evan Hawk](http://web0715.students.flatironschool.com/students/evan_hawk.html)<br>
[Diane Cai](http://web0715.students.flatironschool.com/students/diane_cai.html)<br>
[Matthew Krey](http://web0715.students.flatironschool.com/students/matt_krey.html)<br>

## License

Riddl is MIT Licensed. See LICENSE for details.
