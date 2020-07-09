#include "ddf_util"

//::///////////////////////////////////////////////
//:: Name x2_def_onconv
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Conversation script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    //ExecuteScript("nw_c2_default4", OBJECT_SELF);

    debug("on conversation...");


    int nMatch = GetListenPatternNumber();

    debug("nMatch: " + IntToString(nMatch));

    if (nMatch != -1)
    {
        ExecuteScript("nw_c2_default4", OBJECT_SELF);
        return;
    }

    int iRandom = Random(12); // 0 to (val - 1)

    if(iRandom == 0)
    {
        SpeakString("\"Lost my cousin to that worldwine stuff. Just drifted away to nothing.\"");
    }
    else if(iRandom == 1)
    {
        SpeakString("\"Can't hardly walk around Rathole without seeing someone on worldwine. Not that you'd want to anyway.\"");
    }
    else if(iRandom == 2)
    {
        SpeakString("\"Of course I'd never try the stuff. I don't want the guards up my arse, do I?\"");
    }
    else if(iRandom == 3)
    {
        SpeakString("\"Talk too loud and you'll attract *someone's* attention. Better to keep quiet.\"");
    }
    else if(iRandom == 4)
    {
        SpeakString("\"Guards are gettin' mean. Used to be strict, sure, keep the order. Now they're gettin' mean.\"");
    }
    else if(iRandom == 5)
    {
        SpeakString("\"You seen those Harmonium? Finally getting some real law and order 'round here.\"");
    }
    else if(iRandom == 6)
    {
        SpeakString("\"Haven't seen my neighbor in a few days. Heard whispers he was a rebel, y'know. Disappeared in the night, serves him right.\"");
    }
    else if(iRandom == 7)
    {
        SpeakString("\"Think this is bad? Better by miles than the civil war days.\"");
    }
    else if(iRandom == 8)
    {
        SpeakString("\"Has the sky always been that particular shade of... pink-orange?\"");
    }
    else if(iRandom == 9)
    {
        SpeakString("\"Got nothin' to say to you.\"");
    }
    else if(iRandom == 10)
    {
        SpeakString("\"Don't go gettin' into trouble, you'll bring the devils down on this whole district.\"");
    }
    else if(iRandom == 11)
    {
        SpeakString("\"Hate slavery. 'Course, if I could *afford* a slave I expect I'd think different.\"");
    }

}
