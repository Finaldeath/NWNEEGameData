//::////////////////////////////////////////////////////
//:: MODULE: Tyrants of the Moonsea
//:: NAME: aen_tm_grandtemp
//:: DATE: January 22, 2019
//:: AUTHOR: Attila Gyoerkoes
//::////////////////////////////////////////////////////
//:: Area on Enter: Grand Temple in Zhentil Keep
//:: - Set Henchmen Dialog variables
//:: - Initiate Fzoul Cutscene (Rich Barker)
//::////////////////////////////////////////////////////

#include "hf_in_cutscene"
#include "hf_in_plot"

const string PLOT_HENCH_DIALOG = "plot_hen_dlg_all";

void main()
{
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC)&& GetLocalInt(OBJECT_SELF, "nEntered") == 0)
    {
        if (PlotLevelGet(PLOT_HENCH_DIALOG) < 20)
            PlotLevelSet(PLOT_HENCH_DIALOG, 20);        
        
        object oDirector = GetObjectByTag("FinaleDirector");
        SetLocalObject(oDirector, "oFzoul", GetNearestObjectByTag("Fzoul", oDirector));
        SetLocalObject(oDirector, "oMaganus", GetNearestObjectByTag("StrongholdMaganus", oDirector));

        SetLocalInt(OBJECT_SELF, "nEntered", 1);
        CutscenePlay(oPC, "cut_tm_fzoul");
    }
}
