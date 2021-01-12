# SelfDrivingRide

Hash Code With Google - Coding Competition

## Setup

To get started, you will need to install Xcode:

```
download Xcode https://developer.apple.com/downloads
open SelfDrivingRide.xcodeproj/
```

## Introduction

Millions of people commute by car every day; for example, to school or to their workplace.
Self-driving vehicles are an exciting development for transportation. They aim to make traveling by car safer
and more available while also saving commuters time.
In this competition problem, we’ll be looking at how a fleet of self-driving vehicles can efficiently get
commuters to their destinations in a simulated city.

## Task
Given a list of pre-booked rides in a city and a fleet of self-driving vehicles, assign the rides to vehicles, so
that riders get to their destinations on time.
For every ride that finishes on time (or early), you will earn points proportional to the distance of that ride
plus an additional bonus if the ride also started precisely on time

## Algorithms Implemented

-   [x] Hill Climbing
-   [x] GRASP
    
## Validation
  
Tested it with a provided tool

![Image](SelfDrivingRide/Assets/Images/hill_climbing_test_tool.png?raw=true "Title")

The solution is also validated using this Python [script:](https://github.com/PicoJr/2018-hashcode-score)

## Score

| Instance name  | Min Fitness | Max Fitness  | Average Fitness | Standard Deviation | Best Known Value | Difference from the best in % | 
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| a_example  | 2  | 10  | 6.2  | 1.66 | 10  | 0% |
| b_should_be_easy  | 174032  | 176275  | 175795.7  | 802.54  | 176.677  | 0.22%  |
| c_no_hurry  | 8239359  | 8304043  | 8275301.81  | 21688.76  | 13.789.773  | 49.6%  |
| d_metropolis  | 8327824  | 8583247  | 8488971.27  | 64929.77  | 10.914.293  | 23.9% |
| e_high_bonus  | 20721117  | 20817212  | 20772837.81  | 30071.3  | 21.460.945  | 3.04%  |
