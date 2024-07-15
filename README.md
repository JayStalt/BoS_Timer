# BoS_Timer
 A dynamic timer for Breath of Sindragosa above your character's head involves using WoW's API to track the ability's duration and runic power. 

# Explanation:
Frame Creation: A frame is created and positioned above the character's head. The spell icon for Breath of Sindragosa is displayed on this frame.

Timer Update: The UpdateTimer function calculates the remaining time based on the ability's cooldown and the player's current runic power. The time is adjusted based on the runic power drain rate (16 runic power per second).

Event Handling: The frame listens for events related to spell cooldowns and runic power updates to dynamically update the timer.

This add-on should now display a dynamic timer for Breath of Sindragosa above your character's head, adjusting in real-time as you gain and lose runic power. Let me know if you need any further assistance or modifications!
