
page 50250 ALIssueList

{

    PageType = List;

    SourceTable = ALIssue;
    Caption = 'AL Issues';
    Editable = false;
    SourceTableView = order(descending);
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(Number; number)
                {
                    ApplicationArea = All;
                }

                field(Title; title)
                {
                    ApplicationArea = All;
                }

                field(CreatedAt; created_at)
                {
                    ApplicationArea = All;
                }

                field(User; user)
                {
                    ApplicationArea = All;
                }

                field(State; state)
                {
                    ApplicationArea = All;
                }

                field(URL; html_url)

                {

                    ExtendedDatatype = URL;
                    ApplicationArea = All;
                }

            }

        }

    }



    actions

    {

        area(processing)

        {

            action(RefreshALIssueList)

            {

                Caption = 'Refresh Issues';

                Promoted = true;

                PromotedCategory = Process;

                Image = RefreshLines;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction();

                begin

                    RefreshIssues();

                    CurrPage.Update();

                    if FindFirst() then;

                end;

            }

        }

    }



    trigger OnOpenPage();

    begin

        //RefreshIssues();

        //if FindFirst then;

    end;

}