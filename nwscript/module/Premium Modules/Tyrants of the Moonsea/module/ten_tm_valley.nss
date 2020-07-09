//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ten_tm_valley
// DATE: November 19, 2005
// AUTH: Luke Scull
// NOTE: If Gloomfang isn't dead, restrict player from
//       leaving area in this direction.
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oPC = GetClickingObject();
    if (GetIsPC(oPC))
    {
        if (GetLocalInt(oPC, "gloomfangdead") == 0)
        {
            SpeakString("The path ahead is rocky and leads uphill. You have no chance of fleeing the valley while Gloomfang still lives.");
        }
        else
        {
            ExecuteScript("hf_map_show", OBJECT_SELF);
        }
    }
}

