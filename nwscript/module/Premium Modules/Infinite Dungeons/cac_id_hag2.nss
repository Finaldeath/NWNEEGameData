#include "inc_id_liltimmy"

void main()
{
    // hagatha was the second lieutenant
    SetLocalInt(GetModule(), "bSecondLieutenant", TRUE);

    // get the first lieutenant
    int nLieutenant = lt_GetFirstLieutenant();

    if (nLieutenant == 1) // it was baccha
    {
        nLieutenant = 3; // next is maggris
    } else // it was maggris
    {
        nLieutenant = 1; // next is baccha
    }

    // set the third lieutenant
    lt_SetThirdLieutenant(nLieutenant);
    SetDungeonParameters(1, nLieutenant);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
