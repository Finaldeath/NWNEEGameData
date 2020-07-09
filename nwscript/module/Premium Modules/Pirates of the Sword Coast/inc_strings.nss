//::///////////////////////////////////////////////
//:: String constants
//:: strings.nss
//:: Copyright (c) 2004 Bioware Corp.
//:://////////////////////////////////////////////
/*
    String constants used by scripts in IoP.

    In most cases spoken text should be in dialogue files
    instead of strings, because you can't do double-quotes
    in scripts - well, not without it being a big pain in
    the butt anyway. :)
*/
//:://////////////////////////////////////////////
//:: Created By: Jonathan Epp
//:: Created On: Feb. 29, 2004
//:://////////////////////////////////////////////

// example: const string STRING_REDTIP_PLAYER_USED_WEAPON = "**TEMP** You're using weapons! You cheater!";

// note: though the constant names say "Fanny", it could be Fanny or either of her sisters.
const string s_A2_FANNY_HEARD_PC = "Hey now, I think I hear a rat...";
const string s_A2_FANNY_HEARD_PC_GONE = "That's odd, isn't it? I thought I heard something...";
const string s_A2_FANNY_SAW_PC = "Who's that now?";
const string s_A2_FANNY_SAW_PC_GONE = "Bloody sneaks... Now where did that little thief go?";
const string s_A2_FANNY_CHASING_PC = "If I ever get my hands on the likes of you...";
const string s_A2_FANNY_CAUGHT_PC = "Aha! Thought you'd get away with it, did you?";
const string s_A2_FANNY_THROW_PC_OUT = "And stay out!";

// Rob: Whipped Willigan says this just before he charges the Fanny sisters.
// I imagine "Charge!" should be sufficient, but I'm open to something different.
// I don't have anyone else saying anything in this scene, let me know if
// you'd like anything more.
const string s_A2_WILLIGAN_CHARGE = "Chaaaaaarge!";

// Rob: I haven't implemented any strings yet, so this is totally open to change.
// We have Tasina running away with some priestesses. Two sahuagin guards that
// will be near the PC's when the fight starts are staying to fight. There will
// also be some priestesses staying. We can have anything from nobody saying
// anything to everybody saying something. Whatever works best with the text you want.
const string s_A2_TASINA_FLEE = "To the Midnight Rose, priestesses! We sail for Fiddler's Green at once!";
const string s_A2_TASINA_GUARD = "Glub glub! You're staying with us, pirate...";
