---
layout: post
title: "Next Thing Co - C.H.I.P. computer"
subtitle: "C.H.I.P. computer evaluation"
keywords: "c.h.i.p., raspberry pi, retro, single board computers, emulation"
date: 2016-07-05 01:31
comments: true
categories: geek

---

It's been a while, but I finally got my C.H.I.P. ! C.H.I.P is a `9$` mini computer produced by the [Next Thing Co](https://getchip.com/).
It has a [allwinner 500 MHz arm CPU, 512 megs of ram, onboard bluetooth and wifi](http://docs.getchip.com/chip.html#chip-hardware).
With these specs, it is considerably inferior to a Raspberry Pi, but compares well against a Raspberry Pi Zero.

{% img images/chip.jpg magick:resize:600x1200 alt:"CHIP, Raspberry Pi 2, a couple of 500 yen coins, and an Estimote"  %}

CPU specs might be low, but one good thing about CHIP is that it doesn't get as hot as a Raspberry Pi. As for my usecase,
I actually had to downclock my RPIs to 500 MHz to prevent them from overheating, so this is not a real concern.

Where CHIP actualy shines at is the good quality of onboard peripherals. On board wifi works out of the box (as expected),
supports 802.11b/g/n and monitor mode to boot ! Bluetooth supports  4.0 BLE standard as well. When you try to add these
to a RPI, you better choose your gadgets carefully. You might end up with a chipset which is not supported,
or which is very inferior, consuming lots of energy and producing lots of heat. Which is a real trouble for gadgets of this size.

The OS is your good old debian, so coming from Rasbian you feel right at home. One down side is the lack of a SD card slot.
This is both a blessing and a curse. Next Thing Co has developed their own tools for flashing the device ([right from your browser even !](http://flash.getchip.com/))
But the process seems little bit more complicated than flashing an SD for a Pi. My current mission is to examine this process and flash my
customized image to our CHIPs.

[The forums](https://bbs.nextthing.co/) seem active and lively. There is lots of excitement about the device, and the possibilities.
The community is usually what crowns or ditches a device, so I find the general atmosphere now very positive.

There is even have a special handheld version called [pocket chip](https://getchip.com/pages/pocketchip).
This is a 1Ghz CHIP inside a closure which has keyboard, LED touch screen, and battery (lasts 5 hours).
Appearantly there is a LUA programming interface for this, and community is already producing games for it.
There is also talk about C64 emulation on this device, which would be, totaly ace !
