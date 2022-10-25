codeunit 50140 "CLIP Courses Test"
{
    Subtype = Test;

    [Test]
    procedure SelectCourseOnSalesDocuments()
    begin
        // [Scenario] Se puede seleccionar un curso en una línea de venta

        SelectCourseOnSalesDocument("Sales Document Type"::Quote);
        SelectCourseOnSalesDocument("Sales Document Type"::Order);
        SelectCourseOnSalesDocument("Sales Document Type"::"Blanket Order");
        SelectCourseOnSalesDocument("Sales Document Type"::Invoice);
        SelectCourseOnSalesDocument("Sales Document Type"::"Credit Memo");
        SelectCourseOnSalesDocument("Sales Document Type"::"Return Order");
    end;

    local procedure SelectCourseOnSalesDocument(SalesDocumentType: Enum "Sales Document Type")
    var
        Course: Record "CLIP Course";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LibraryCourses: Codeunit "CLIP Library - Courses";
        LibrarySales: Codeunit "Library - Sales";
        LibraryAssert: Codeunit "Library Assert";
    begin
        // [Given] Un curso configurado con: nombre, grupos contables, precio
        Course := LibraryCourses.CreateCourse();
        //         Un documento de venta
        LibrarySales.CreateSalesHeader(SalesHeader, SalesDocumentType, '');
        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::Item, '', 1);
        LibrarySales.CreateSalesLineSimple(SalesLine, SalesHeader);

        // [When] Seleccionamos el curso en una línea venta
        SalesLine.Validate(Type, "Sales Line Type"::"CLIP Course");
        SalesLine.Validate("No.", Course."No.");

        // [Then] La línea de venta tiene la Nombre del curso, el precio y los grupos contables
        LibraryAssert.AreEqual(Course.Name, SalesLine.Description, 'La descripción no es correcta');
        LibraryAssert.AreEqual(Course.Price, SalesLine."Unit Price", 'El precio no es correcto');
        LibraryAssert.AreEqual(Course."Gen. Prod. Posting Group", SalesLine."Gen. Prod. Posting Group", 'El grupo contable producto no es correcto');
        LibraryAssert.AreEqual(Course."VAT Prod. Posting Group", SalesLine."VAT Prod. Posting Group", 'El grupo IVA producto no es correcto');
    end;
}