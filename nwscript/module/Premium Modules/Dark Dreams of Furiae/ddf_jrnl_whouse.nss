#include "ddf_util"

void UpdateWarehouseJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iUpdated = 0;// GetLocalInt(oModule, JOURNAL_WAREHOUSE);
    int bClosed = FALSE;

    // Check if Investigation is complete...

    if(GetLocalInt(oModule, "dlg_quill_002_done") == TRUE)
    {
        iUpdated += 1;
        text = "A terrified gnome called Quillian has told you about his connection to the worldwine epidemic and his part in the destruction of the Sea Market warehouse where it was manufactured. Investigating that warehouse -- specifically, who may have owned or operated it -- would be a good place to start in the investigation of the worldwine operation, as it could determine who else is involved.";
        text += PARA + "Municipal buildings, now run by the Fraternity of Order, will have records and deeds to look into.";
        TryToMakeAvailable(AREA_MIDTOWN_MUNICIPAL_DISTRICT);
    }

    if(QuestActive(AREA_MIDTOWN_MUNICIPAL_DISTRICT) == TRUE)
    {
        if(GetLocalInt(oModule, "ddf_property_deed") == TRUE)
        {
            SetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT, INVESTIGATION_COMPLETE);
        }

        if(GetLocalInt(oModule, "ddf_fovor_guvners") == TRUE || GetLocalInt(oModule, "ddf_long_guard_001") == TRUE || GetLocalInt(oModule, "ddf_guvg_met") == TRUE)
        {
            iUpdated += 2;
            text += PARA + "The Fraternity of Order, or \"Guvners,\" run the municipal records buildings. They are known for their meticulous record keeping and bureaucracy, all in service of understanding the law in its entirety. You'll likely have to talk your way in to see the records you need. However, you might be able to find another way into the building.";
        }
        if(GetLocalInt(oModule, "ddf_guvner_guard_no_access") == TRUE)
        {
            iUpdated += 4;
            text += PARA + "The Guvners guarding the municipal records building might be able to be reasoned with, but their intense love of the laws may make it difficult. Perhaps you haven't exhausted all of your options to get into the building.";
        }
        if(GetLocalInt(oModule, "ddf_lone_guard_001") == TRUE)
        {
            iUpdated += 8;
            text += PARA + "There is a back door to the municipal records building, but something will have to be done about the guard there. You think perhaps a distraction is in order.";
        }

        if(GetLocalInt(oModule, "ddf_guvner_gain_entrance") == TRUE)
        {
            iUpdated += 16;
            text += PARA + "You have gained access to the Municipal Records Building; now to find evidence about the Sea Market warehouse in all these documents.";
        }

        if(GetLocalInt(oModule, "ddf_guvner_attack_guard") == TRUE)
        {
            iUpdated += 32;
            text += PARA + "Hopefully you don't get arrested for the murder of members of the Fraternity of Order in the meantime.";
        }
        if(GetLocalInt(oModule, "ddf_property_deed") == TRUE || GetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT) == INVESTIGATION_COMPLETE)
        {
            bClosed = TRUE;
            iUpdated += 64;
            text += PARA + "You have learned that the warehouse Quillian was trapped in is owned by the Coranos, one of Furiae's noble families. Is a noble house involved in the worldwine trade? If so, it would certainly be noteworthy. Investigating the family seems like the next logical step.";
        }
    }

    if(GetQuestWasActive(AREA_MIDTOWN_MUNICIPAL_DISTRICT) == TRUE && GetQuestState(AREA_MIDTOWN_MUNICIPAL_DISTRICT) != INVESTIGATION_COMPLETE && GetCurrentDay() > 2)
    {
        bClosed = TRUE;
        iUpdated = 128;
        text += PARA + "You never investigated the property deeds of the warehouse, but there are more pressing things to investigate now.";
    }

    DoJournalUpdate(oPC, JOURNAL_WAREHOUSE, text, iUpdated, 6200, bClosed);

}


