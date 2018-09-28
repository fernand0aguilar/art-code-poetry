# Session 1 Resources
## GETTING STARTED WITH MACHINE LEARNING - PART 2

### **Written Component**

Brainstorm 3 scenarios in which supervised learning could be used to make a piece of interactive art or music. Each of your three scenarios should be between 100-300 words.

* 1. Plant Feeder - model learning when to drop water in the plant system. Geting data from sensors.
* 2. Aura Vitalis v3. - Aura with posenet recognition reproducing the pose from the person standing in front of it
* 3. Enlightenment social measure - Twitter sentiment analysis for measuring enlightenment based on hashtags such as pineal gland, third eye, and then change image alpha based on it.

Specifically, describe:

**A. What input devices or sensors might you use?** _(These don’t have to be things that you own! Think big.)_
```
1. Arduino uno with humidity sensor attached to plants for learning when to drop water in the system.
2. Raspbery pi running processing, webcam and display cells for reproducing positions
3. Twitter API
```
**B. What do you imagine changing the state of these sensors/devices?** _(e.g., motions of a person, state of the environment, ... ?)_
```
1. humidity on sensors in the plant ground
2. Posenet
3. Sentiment Analysis, summing up tags 
```
**C. What output processes might you use?** _(e.g., changing the melody or timbre of a sound, changing the position or color of an animated object, or something much more complicated. This doesn’t have to be something you know how to do as a programmer!)_
```
1. Low humidity - feeds water
2. On or Off the display cells
3. change on the image alpha
```

**D. How do changes in the input relate to changes in the output?** _That is, how do the motions of a person drive changes in a computer generated melody? Or how do changes in the amount of traffic on a street influence changes in an animated character? etc..._
```
1. low humidity means high probability of classifying as dry
2. Changes on the positions change the activation of the displays
3. The image alpha changes in real time based on the api calls made on the hashtags
```

**E. Say a little bit about your motivation.** _If you came up with this system because you thought it would be interesting / useful / fun / otherwise a good idea._
```
1. This is a project that I want to make for a long time. The computer being able to control some plants based on sensor input is really powerful and can open different roads in the future.
2. The Auravitalis was a project that I got involved when at Medialab/UnB and it is beautiful at the same time that is simple. Applying posenet to it increases the chances of strenghening it responsivity up to tons of percents.
3. This is just a silly project that is doable enough for me to get the hands dirty.
```

## Extra
Make the spider robot that I have shared with Arthur a few weeks ago.
This would need access to a 3D printer and some servos. It's doable, no doubt.
https://github.com/JonComo/spider
