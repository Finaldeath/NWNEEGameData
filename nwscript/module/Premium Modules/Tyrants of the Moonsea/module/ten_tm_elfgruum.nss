//Kur-Tharsu Chapel trigger to remind Elf of his true self

#include "hf_in_plot"

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) && GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if(PlotLevelGet("Elf") == 20)
        {
            object oElf = GetNearestObjectByTag("Elf", oPC);
            SetLocalInt(OBJECT_SELF, "nEntered", 1);
            SetLocalInt(oElf, "nGruumsh", 1);
            DelayCommand(RoundsToSeconds(15), DeleteLocalInt(oElf, "nGruumsh"));
        }
    }
}
