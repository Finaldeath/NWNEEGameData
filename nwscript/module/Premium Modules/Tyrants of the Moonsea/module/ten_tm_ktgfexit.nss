//Kur-Tharsu Ground Floor trigger to initiate Blizzard and Elf's departure

#include "hf_in_plot"

void main()
{
    object oFollower;
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if(PlotLevelGet("Blizzard") == 16)
        {
            oFollower = GetNearestObjectByTag("Blizzard", oPC);
            SetLocalString(oFollower, "HF_EXIT_NAME", "WP_THKTGF_CS_BLIZZARD_EXIT");
            PlotLevelSet("Blizzard", 17);
        }

        if(PlotLevelGet("Elf") == 20)
        {
            oFollower = GetNearestObjectByTag("Elf", oPC);
            SetLocalString(oFollower, "HF_EXIT_NAME", "WP_THKTGF_CS_ELF_EXIT");
            PlotLevelSet("Elf", 21);
        }

        SetLocalInt(OBJECT_SELF, "nEntered", 1);
    }
}
