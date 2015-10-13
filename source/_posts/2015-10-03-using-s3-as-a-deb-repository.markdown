---
layout: post
title: "Our Gitlab CI setup"
date: 2015-10-03 12:06
comments: true
categories: dev
---

We're fervent supporters of Gitlab in our company, and when they rolled out a new CI module, we immediately jumped in to see how
we can use it. In the past I've had experience with Jenkins, and some with Travis. It seems 
and I had my doubts about Gitlabs new CI module, but fortunately it
turned out pretty good.

## The Project

Recently I'm working on a project where I need to distribute my software to a fleet of raspberry pis.
Well, I had already packaged it nicely with goxc, but I was not really sure about how I would distribute it.
Obviously I needed to setup a repository, however I eiter had to spin up a new server (which I thought was overkill,
and I would have a hardtime pushing it to OPs, because one more server is one more headache to maintain) or piggyback
it to an existing one, which is pretty damn ugly and subject to other kinds of headaches.

Then I was checking what actually is a repository server, and it dawnded at me that it could very well be
static file directory, and I don't actually need to spin up a dedicated server. I checked up little bit and
sure enough, there are folks who use AWS S3 as an apt repository.

There is a tool out there called [apt-s3](https://github.com/castlabs/apt-s3) which lets you use a S3 bucket
as an apt source. I didn't want my repository to be public, so I created a reader user with reading priviledges
on the bucket, and configure apt-s3 at the clients.

My project is written in Go, so I used [goxc](https://github.com/castlabs/apt-s3) For crosscompiling to arm/linux
and packaging as deb. For pushing the package to the repository, I created a master keypair for the bucket and
used [deb-s3](https://github.com/castlabs/apt-s3).
