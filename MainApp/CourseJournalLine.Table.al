table 50104 "CLIP Course Journal Line"
{
    Caption = 'Course Journal Line', Comment = 'ESP="Lín. diario curso"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            // TableRelation = "Res. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', Comment = 'ESP="Nº"';
        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.', Comment = 'ESP="Nº documento"';
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date', Comment = 'ESP="Fecha registro"';

            trigger OnValidate()
            begin
                TestField("Posting Date");
            end;
        }
        field(6; "Course No."; Code[20])
        {
            Caption = 'Course No.', Comment = 'ESP="Nº curso"';
            TableRelation = "CLIP Course";

            trigger OnValidate()
            begin
                if "Course No." = '' then
                    exit;

                Course.Get("Course No.");
                Rec.Description := Course.Name;
                Rec."Unit Price" := Course.Price;
            end;
        }
        field(7; "Course Edition"; Code[20])
        {
            Caption = 'Course Edition', comment = 'ESP="Edición curso"';
            TableRelation = "CLIP Course Edition";
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description', Comment = 'ESP="Descripción"';
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity', Comment = 'ESP="Cantidad"';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(16; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price', Comment = 'ESP="Precio unitario"';
            MinValue = 0;

            trigger OnValidate()
            begin
                "Total Price" := Quantity * "Unit Price";
            end;
        }
        field(17; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price', Comment = 'ESP="Importe"';

            trigger OnValidate()
            begin
                TestField(Quantity);
                GetGLSetup();
                "Unit Price" := Round("Total Price" / Quantity, GeneralLedgerSetup."Unit-Amount Rounding Precision");
            end;
        }
        field(23; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            // TableRelation = "Res. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(959; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    // trigger OnInsert()
    // begin
    //     LockTable();
    //     ResJournalTemplate.Get("Journal Template Name");
    //     ResJournalBatch.Get("Journal Template Name", "Journal Batch Name");
    // end;

    var
        // ResJournalTemplate: Record "Res. Journal Template";
        // ResJournalBatch: Record "Res. Journal Batch";
        Course: Record "CLIP Course";
        GeneralLedgerSetup: Record "General Ledger Setup";
        GLSetupRead: Boolean;

    procedure EmptyLine(): Boolean
    begin
        exit((Rec."Course No." = '') and (Rec.Quantity = 0));
    end;

    procedure CopyDocumentFields(DocNo: Code[20])
    begin
        Rec."Document No." := DocNo;
    end;

    procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header")
    begin
        Rec."Posting Date" := SalesHeader."Posting Date";

        OnAfterCopyCourseJournalLineFromSalesHeader(SalesHeader, Rec);
    end;

    procedure CopyFromSalesLine(SalesLine: Record "Sales Line")
    begin
        Rec."Course No." := SalesLine."No.";
        Rec."Course Edition" := SalesLine."CLIP Course Edition";
        Rec.Description := SalesLine.Description;
        Rec.Quantity := -SalesLine."Qty. to Invoice";
        Rec."Unit Price" := SalesLine."Unit Price";
        Rec."Total Price" := -SalesLine.Amount;

        OnAfterCopyCourseJournalLineFromSalesLine(SalesLine, Rec);
    end;

    local procedure GetGLSetup()
    begin
        if not GLSetupRead then
            GeneralLedgerSetup.Get();
        GLSetupRead := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesHeader(var SalesHeader: Record "Sales Header"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCopyCourseJournalLineFromSalesLine(var SalesLine: Record "Sales Line"; var CourseJournalLine: Record "CLIP Course Journal Line")
    begin
    end;
}

