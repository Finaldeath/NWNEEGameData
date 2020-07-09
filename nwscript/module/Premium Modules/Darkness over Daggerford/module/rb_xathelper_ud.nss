#include "hf_in_plot"

void main()
{
    switch(GetUserDefinedEventNumber())
    {
        case 6000:
        object oPC = GetFirstPC();

        SetLocalInt(GetModule(), "nXatuumKilled", 1);

        // check for journal update
        string sJournal = "j95"; // relevant quest
        string sJournalVar = ("NW_JOURNAL_ENTRY" + sJournal);

        int iState = GetLocalInt(oPC, sJournalVar);

        //If Xatuum plot has progressed, update journal appropriately
        if (iState >= 10 && iState < 50)
        {
            if(GetLocalInt(GetModule(), "iDamagedFromFake") == 0)
            {
                // player needs an update
                AddJournalQuestEntry(sJournal, 60, oPC);
            }
            else
            {
                AddJournalQuestEntry(sJournal, 55, oPC);
            }
        }
        /* Maerovyna plot
        plot 1 - found note(favoured)
        plot 2 - shown note (no dialog)
        plot 3 - asked to kill
        plot 4 - told to get fake (no dialog)
        plot 5 - can tell killed xatuum (favoured)
        */
        int iMaerPlot = PlotLevelGet("pm_Maerovyna");
        //If Maerovyna helped with the fake heart, or we have shown her the note
        //and told her about Xatuum, allow her to be informed
        if((iMaerPlot == 2) && GetLocalInt(GetModule(), "iToldMaerXatuum") == 1)
        {
            //Don't want to set this if we showed her note before meeting Xatuum
            PlotLevelSet("pm_Maerovyna", 5);
        }
        else
        //If told to kill Maer but never met her, reset to be able to show note
        //If have told her about Xatuum, you can tell her you've killed him
        if(iMaerPlot == 3)
        {
            if(GetLocalInt(GetModule(), "iShownMaerovynaNote") == 0)
            {
                PlotLevelSet("pm_Maerovyna", 1);
            }
            else
            if(GetLocalInt(GetModule(), "iToldMaerXatuum") == 1)
            {
                PlotLevelSet("pm_Maerovyna", 5);
            }
        }
        if(iMaerPlot == 4)
        {
            PlotLevelSet("pm_Maerovyna", 5);
        }

        //Farmers don't need to talk about boar any more
        PlotLevelSet("ac_farmersam", 0);
        PlotLevelSet("ac_farmerjoe", 0);

        //Destroy hearts if still around
        DestroyObject(GetObjectByTag("rb_maerheart"));
        DestroyObject(GetObjectByTag("rb_boarheart"));

        break;
    }
 }
