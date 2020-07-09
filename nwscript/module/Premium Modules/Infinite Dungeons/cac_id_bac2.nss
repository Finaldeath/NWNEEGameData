#include "inc_id_liltimmy"

void main()
{
    // baccha was the second lieutenant
    SetLocalInt(GetModule(), "bSecondLieutenant", TRUE);

    // get the first lieutenant
    int nLieutenant = lt_GetFirstLieutenant();

    if (nLieutenant == 2) // it was hagatha
    {
        nLieutenant = 3; // next is maggris
    } else // it was maggris
    {
        nLieutenant = 2; // next is hagatha
    }

    // set the third lieutenant
    lt_SetThirdLieutenant(nLieutenant);
    SetDungeonParameters(1, nLieutenant);
    SetLocalInt(GetModule(), "bPlotDungeon", TRUE);
}
