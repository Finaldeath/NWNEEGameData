//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// MODULE: Tyrants of the Moonsea
// NAME: ptc_tm_ktgtoktu
// DATE: October 15, 2018.
// AUTH: Rich Barker
// NOTE: Area transition for Kur-Tharsu Lower to Upper
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

void main()
{
    object oClicker=GetClickingObject();
    object oTarget=GetTransitionTarget(OBJECT_SELF);

    if(GetIsPC(oClicker))
    {
        //Ensure Blizzard and Elf destroyed if present
        object oBlizzard = GetNearestObjectByTag("Blizzard", oClicker);
        object oElf = GetNearestObjectByTag("Elf", oClicker);

        if(GetIsObjectValid(oBlizzard))
        {
            ExecuteScript("hf_cs_exit", oBlizzard);
        }

        if(GetIsObjectValid(oElf))
        {
            ExecuteScript("hf_cs_exit", oElf);
        }

         // move the player
        AssignCommand(oClicker, JumpToObject(oTarget));
    }
}
