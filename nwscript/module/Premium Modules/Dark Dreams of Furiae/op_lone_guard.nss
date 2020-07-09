//::///////////////////////////////////////////////
//:: Name x2_def_percept
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Perception script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////

void main()
{
    object oPC = GetLastPerceived();
    if(GetIsPC(oPC))
    {
        int iLastMinute = GetLocalInt(OBJECT_SELF, "ddf_last_perceived_min");
        int iCurrentMinute = GetTimeMinute();
        if(iCurrentMinute != iLastMinute && (iCurrentMinute + 1) != iLastMinute)
        {
            SetLocalInt(OBJECT_SELF, "ddf_last_perceived_min", iCurrentMinute);

            object oLastPerceivedPC = GetLocalObject(OBJECT_SELF, "ddf_last_perceived_pc");
            if(oLastPerceivedPC != oPC)
            {
                SetLocalObject(OBJECT_SELF, "ddf_last_perceived_pc", oPC);
                SpeakString("You there! Stand and declare.");
            }
        }
    }
    ExecuteScript("nw_c2_default2", OBJECT_SELF);
}
