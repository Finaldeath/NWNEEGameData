//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "ddf_util"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "ddf_set_rand_dialog") == FALSE)
    {
        //Random Bubbles on Day 1:
        SetLocalString(OBJECT_SELF, "d1_0", "I can't believe this...");
        SetLocalString(OBJECT_SELF, "d1_1", "Drinks are much stronger here.");
        SetLocalString(OBJECT_SELF, "d1_2", "I miss a sea that makes sense.");

        //Random Bubbles on Day 2-3:
        SetLocalString(OBJECT_SELF, "d2_0", "I might want to slow down, but what else do I have to do?") ;
        SetLocalString(OBJECT_SELF, "d2_1", "Barkeep, gimme some of that hot wine! There's a chill today.");
        SetLocalString(OBJECT_SELF, "d2_2", "Wonder if that elf is working at that Forvor's shop today...");

        //Random Bubbles on Day 4:
        SetLocalString(OBJECT_SELF, "d4_0", "Ugh, I'll never get back out to sea at this rate...");
        SetLocalString(OBJECT_SELF, "d4_1", "Barkeeeeep! One more! Make it two. I think someone is stealing these on me, they disappear so fast.") ;
        SetLocalString(OBJECT_SELF, "d4_2", "I love you, hot wine.");

        //Random Bubbles on Day 5-6:
        SetLocalString(OBJECT_SELF, "d5_0", "...maybe I will give it a shot.");
        SetLocalString(OBJECT_SELF, "d5_1", "*whistles*");
        SetLocalString(OBJECT_SELF, "d5_2", "*hiccups*");

        SetLocalInt(OBJECT_SELF, "ddf_set_rand_dialog", TRUE);
    }


    if (d100() < 20)
    {
        int iDay = GetCurrentDay();
        string prefix;
        if(iDay == 1)
        {
            prefix = "d1_";
        }
        else if(iDay == 2 || iDay == 3)
        {
            prefix = "d2_";
        }
        else if(iDay == 4)
        {
            prefix = "d4_";
        }
        else if(iDay == 5 || iDay == 6)
        {
            prefix = "d5_";
        }

        int nRandom = Random(3);
        string sLineVarName = prefix + IntToString(nRandom);
        SpeakString(GetLocalString(OBJECT_SELF, sLineVarName));
    }


    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
