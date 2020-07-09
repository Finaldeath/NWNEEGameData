#include "ddf_util"
#include "x0_i0_partywide"

void UpdateRingsJournal(object oPC)
{
    string text = "";
    object oModule = GetModule();

    int iRingCount = GetLocalInt(oModule, "ddf_number_of_rings_found");
    int iUpdated = 0;
    int bFinished = FALSE;

    if(iRingCount == 0)
    {
        //debug("No ring updates as none have been found by your party yet.");
        return;
    }

    if(iRingCount == 1)
    {
        iUpdated += 1;
        text = "One of the people supposedly involved in the worldwine operation had a magical ring on them. You wonder what it does.";
    }
    else if(GetLocalInt(oModule, "ddf_ring_identified") == TRUE)
    {
        iUpdated += 2;
        text = "One of the people possibly involved in the worldwine operation had a magical ring on them. The ring seems to be one of a set, which allows communication between any or all who bear these rings. The rings must be how members of the worldwine operation communicate with each other secretly, without direct contact.";
        text += PARA + "You *could* use it to contact the other operatives, but you don't want to give your investigation away -- better to wait for them to give themselves up by trying to contact you.";
    }

    if(iRingCount > 1)
    {
        iUpdated += 4;

        // If the ring has been identified, then we have the text above, and need to make a new para for the following.
        // If not, then this is the only text, and we don't need the extra para vertical space.
        if(GetLocalInt(oModule, "ddf_ring_identified") == TRUE) text += PARA;

        text += "You've found a second magical ring in the set. It seems that each primary operative of the worldwine operation may have one.";

    }

    if(GetLocalInt(oModule, "ddf_spoke_with_shavann") == TRUE)
    {
        bFinished = TRUE;
        iUpdated = 8;
        text += PARA + "The worldwine operatives have been using these magical rings to communicate with each other. What operatives remain have now used the magical rings, accidentally contacting you and revealing their location -- smuggler's tunnels beneath the city. You've heard rumours there's even a connection to these tunnels through a cellar north of your apartment.";
        text += PARA + "You have what you need to find the heart of the worldwine operation.";

    }

    DoJournalUpdate(oPC, JOURNAL_RINGS, text, iUpdated, 6700, bFinished);

}

