//Test Shop: Markup = +20, Markdown = -20;
#include "nw_i0_plot"
void main()
{
    int iMarkup = 20;
    int iMarkdown = -20;
    object oStore = GetObjectByTag("TestStore");
    object oPC = GetPCSpeaker();

    gplotAppraiseOpenStore(oStore, oPC, iMarkup, iMarkdown);
}
