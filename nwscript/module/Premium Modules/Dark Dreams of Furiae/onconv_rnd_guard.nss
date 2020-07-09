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

    int iRandom = Random(7); // 0 to (val - 1)

    if(iRandom == 0)
    {
        SpeakString("\"Keep moving.\"");
    }
    else if(iRandom == 1)
    {
        SpeakString("\"You want a quick trip to the stockade?\"");
    }
    else if(iRandom == 2)
    {
        SpeakString("\"Harmonium bastards always in my way...\"");
    }
    else if(iRandom == 3)
    {
        SpeakString("\"Devils brought some godsdamned law and order to the city.\"");
    }
    else if(iRandom == 4)
    {
        SpeakString("\"Outta my way.\"");
    }
    else if(iRandom == 5)
    {
        SpeakString("\"This is *my* street.\"");
    }
    else if(iRandom == 6)
    {
        SpeakString("\"Find an alleyway, find a dreamer. Round 'em all up.\"");
    }

}
